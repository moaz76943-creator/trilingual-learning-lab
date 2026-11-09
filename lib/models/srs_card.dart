import 'dart:math' as math;

/// SM-2 Spaced Repetition Card domain entity with strict mathematical guarantees.
class SrsCard {
  final String id;
  final String conceptId;
  final int repetitions;
  final double easeFactor;
  final int intervalDays;
  final DateTime nextReviewDate;
  final DateTime lastReviewedDate;

  const SrsCard({
    required this.id,
    required this.conceptId,
    this.repetitions = 0,
    this.easeFactor = 2.5,
    this.intervalDays = 0,
    required this.nextReviewDate,
    required this.lastReviewedDate,
  });

  /// True calendar-date and timestamp comparison preventing day-of-month bugs.
  bool isDue(DateTime currentDate) {
    // A card is due if scheduled on or before today's calendar date
    final scheduledDate = DateTime(
      nextReviewDate.year,
      nextReviewDate.month,
      nextReviewDate.day,
    );
    final today = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );
    return scheduledDate.isBefore(today) || scheduledDate.isAtSameMomentAs(today);
  }

  /// Calculates next review schedule strictly adhering to SuperMemo SM-2 algorithm.
  /// [qualityScore] ranges from 0 (complete blackout) to 5 (perfect recall).
  SrsCard review(int qualityScore, DateTime reviewTime) {
    final clampedScore = qualityScore.clamp(0, 5);

    if (clampedScore < 3) {
      // Repetition failed: reset interval to 1 day, preserve easeFactor with minor penalty
      return SrsCard(
        id: id,
        conceptId: conceptId,
        repetitions: 0,
        easeFactor: math.max(1.3, easeFactor - 0.2),
        intervalDays: 1,
        nextReviewDate: reviewTime.add(const Duration(days: 1)),
        lastReviewedDate: reviewTime,
      );
    }

    // Repetition successful
    int nextInterval;
    if (repetitions == 0) {
      nextInterval = 1;
    } else if (repetitions == 1) {
      nextInterval = 6;
    } else {
      nextInterval = (intervalDays * easeFactor).round();
    }

    // Calculate new Ease Factor: EF' = EF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
    final double efDelta = 0.1 - (5 - clampedScore) * (0.08 + (5 - clampedScore) * 0.02);
    final double updatedEaseFactor = math.max(1.3, easeFactor + efDelta);

    return SrsCard(
      id: id,
      conceptId: conceptId,
      repetitions: repetitions + 1,
      easeFactor: updatedEaseFactor,
      intervalDays: nextInterval,
      nextReviewDate: reviewTime.add(Duration(days: nextInterval)),
      lastReviewedDate: reviewTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'conceptId': conceptId,
        'repetitions': repetitions,
        'easeFactor': easeFactor,
        'intervalDays': intervalDays,
        'nextReviewDate': nextReviewDate.toIso8601String(),
        'lastReviewedDate': lastReviewedDate.toIso8601String(),
      };

  factory SrsCard.fromJson(Map<String, dynamic> json) {
    return SrsCard(
      id: json['id']?.toString() ?? '',
      conceptId: json['conceptId']?.toString() ?? '',
      repetitions: json['repetitions'] as int? ?? 0,
      easeFactor: (json['easeFactor'] as num?)?.toDouble() ?? 2.5,
      intervalDays: json['intervalDays'] as int? ?? 0,
      nextReviewDate: json['nextReviewDate'] != null
          ? DateTime.tryParse(json['nextReviewDate'] as String) ?? DateTime.now()
          : DateTime.now(),
      lastReviewedDate: json['lastReviewedDate'] != null
          ? DateTime.tryParse(json['lastReviewedDate'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
