import '../models/srs_models.dart';

class Sm2SchedulerService {
  const Sm2SchedulerService();

  static const double minEaseFactor = 1.3;
  static const double maxEaseFactor = 2.8;

  /// Applies standard SM-2 scheduling with bounded ease factor and lapse tracking.
  SrsReviewCard scheduleNext({
    required SrsReviewCard card,
    required RecallGrade grade,
    required int currentEpochDays,
  }) {
    final q = grade.quality;
    var nextEase = card.easeFactor + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02));
    if (nextEase < minEaseFactor) nextEase = minEaseFactor;
    if (nextEase > maxEaseFactor) nextEase = maxEaseFactor;

    int nextReps;
    int nextInterval;
    int nextLapses = card.lapses;

    if (q < 3) {
      nextReps = 0;
      nextInterval = 1;
      nextLapses += 1;
    } else {
      nextReps = card.repetitions + 1;
      if (nextReps == 1) {
        nextInterval = 1;
      } else if (nextReps == 2) {
        nextInterval = 6;
      } else {
        nextInterval = (card.intervalDays * nextEase).round();
        if (nextInterval < 1) nextInterval = 1;
      }
      if (grade == RecallGrade.easy && nextReps >= 2) {
        nextInterval = (nextInterval * 1.25).round();
      }
    }

    return card.copyWith(
      easeFactor: double.parse(nextEase.toStringAsFixed(2)),
      intervalDays: nextInterval,
      repetitions: nextReps,
      lapses: nextLapses,
      dueEpochDays: currentEpochDays + nextInterval,
    );
  }
}
