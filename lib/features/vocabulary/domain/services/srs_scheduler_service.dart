import 'dart:math' as math;

class SrsCardReview {
  final int intervalDays;
  final int repetitions;
  final double easeFactor;
  final DateTime nextReviewDate;

  const SrsCardReview({
    required this.intervalDays,
    required this.repetitions,
    required this.easeFactor,
    required this.nextReviewDate,
  });
}

class SrsSchedulerService {
  // تقييم جودة الاسترجاع من 0 إلى 5 (0: نسيان تام، 5: استرجاع فوري متقن)
  static SrsCardReview calculateNextReview({
    required int quality,
    required int previousInterval,
    required int previousRepetitions,
    required double previousEaseFactor,
  }) {
    int repetitions = previousRepetitions;
    int interval = previousInterval;
    double easeFactor = previousEaseFactor;

    if (quality >= 3) {
      if (repetitions == 0) {
        interval = 1;
      } else if (repetitions == 1) {
        interval = 6;
      } else {
        interval = (interval * easeFactor).round();
      }
      repetitions += 1;
    } else {
      repetitions = 0;
      interval = 1;
    }

    // معادلة SuperMemo-2 لتعديل معامل السهولة
    easeFactor = easeFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    easeFactor = math.max(1.3, easeFactor);

    final nextReviewDate = DateTime.now().add(Duration(days: interval));

    return SrsCardReview(
      intervalDays: interval,
      repetitions: repetitions,
      easeFactor: easeFactor,
      nextReviewDate: nextReviewDate,
    );
  }
}
