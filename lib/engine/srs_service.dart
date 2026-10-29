import 'dart:math';

/// Representation of a learning item's spaced repetition state.
class SrsItemState {
  final String itemId;
  final int repetitions;
  final double easinessFactor;
  final int intervalDays;
  final DateTime nextReviewDate;
  final int masteryLevel;

  SrsItemState({
    required this.itemId,
    this.repetitions = 0,
    this.easinessFactor = 2.5,
    this.intervalDays = 0,
    DateTime? nextReviewDate,
    this.masteryLevel = 0,
  }) : nextReviewDate = nextReviewDate ?? DateTime.now();

  factory SrsItemState.fromJson(Map<String, dynamic> json) {
    return SrsItemState(
      itemId: json['itemId'] as String,
      repetitions: json['repetitions'] as int? ?? 0,
      easinessFactor: (json['easinessFactor'] as num?)?.toDouble() ?? 2.5,
      intervalDays: json['intervalDays'] as int? ?? 0,
      nextReviewDate: json['nextReviewDate'] != null 
          ? DateTime.parse(json['nextReviewDate'] as String)
          : DateTime.now(),
      masteryLevel: json['masteryLevel'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'itemId': itemId,
    'repetitions': repetitions,
    'easinessFactor': easinessFactor,
    'intervalDays': intervalDays,
    'nextReviewDate': nextReviewDate.toIso8601String(),
    'masteryLevel': masteryLevel,
  };
}

/// Core SM-2 Spaced Repetition calculation service.
class SrsService {
  static const double minEasinessFactor = 1.3;

  /// Calculate the next review state given a user score (0 to 5).
  static SrsItemState calculateNextState(SrsItemState current, int qualityScore) {
    assert(qualityScore >= 0 && qualityScore <= 5, 'Quality score must be between 0 and 5');

    int newReps = current.repetitions;
    int newInterval = current.intervalDays;
    double newEf = current.easinessFactor;

    if (qualityScore >= 3) {
      if (newReps == 0) {
        newInterval = 1;
      } else if (newReps == 1) {
        newInterval = 6;
      } else {
        newInterval = (current.intervalDays * newEf).round();
      }
      newReps += 1;
    } else {
      newReps = 0;
      newInterval = 1;
    }

    // Standard SM-2 formula: EF' = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
    newEf = newEf + (0.1 - (5 - qualityScore) * (0.08 + (5 - qualityScore) * 0.02));
    if (newEf < minEasinessFactor) {
      newEf = minEasinessFactor;
    }

    int newMastery = min(5, (newReps / 2).floor());
    DateTime nextReview = DateTime.now().add(Duration(days: newInterval));

    return SrsItemState(
      itemId: current.itemId,
      repetitions: newReps,
      easinessFactor: newEf,
      intervalDays: newInterval,
      nextReviewDate: nextReview,
      masteryLevel: newMastery,
    );
  }

  /// Check if an item is due for review today.
  static bool isDue(SrsItemState item) {
    return DateTime.now().isAfter(item.nextReviewDate);
  }
}
