import 'dart:math' as math;

/// SM-2 Spaced Repetition Algorithm implementation for offline language learning.
/// Fully local, no network required. Integrates with existing SQLite progress storage.
/// 
/// Based on the classic SuperMemo SM-2 algorithm with ease factor and interval calculation.
class SM2Card {
  final String cardId;
  final String front; // e.g. Arabic or English
  final String back;  // German or target
  final double easeFactor; // starts at 2.5
  final int intervalDays;
  final int repetitions;
  final DateTime nextReviewDate;
  final DateTime lastReviewDate;
  final double lastQuality; // 0-5

  const SM2Card({
    required this.cardId,
    required this.front,
    required this.back,
    this.easeFactor = 2.5,
    this.intervalDays = 0,
    this.repetitions = 0,
    required this.nextReviewDate,
    required this.lastReviewDate,
    this.lastQuality = 0.0,
  });

  SM2Card copyWith({
    double? easeFactor,
    int? intervalDays,
    int? repetitions,
    DateTime? nextReviewDate,
    DateTime? lastReviewDate,
    double? lastQuality,
  }) {
    return SM2Card(
      cardId: cardId,
      front: front,
      back: back,
      easeFactor: easeFactor ?? this.easeFactor,
      intervalDays: intervalDays ?? this.intervalDays,
      repetitions: repetitions ?? this.repetitions,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      lastReviewDate: lastReviewDate ?? this.lastReviewDate,
      lastQuality: lastQuality ?? this.lastQuality,
    );
  }

  Map<String, dynamic> toMap() => {
        'cardId': cardId,
        'front': front,
        'back': back,
        'easeFactor': easeFactor,
        'intervalDays': intervalDays,
        'repetitions': repetitions,
        'nextReviewDate': nextReviewDate.toIso8601String(),
        'lastReviewDate': lastReviewDate.toIso8601String(),
        'lastQuality': lastQuality,
      };

  factory SM2Card.fromMap(Map<String, dynamic> map) => SM2Card(
        cardId: map['cardId'] as String,
        front: map['front'] as String,
        back: map['back'] as String,
        easeFactor: (map['easeFactor'] as num).toDouble(),
        intervalDays: map['intervalDays'] as int,
        repetitions: map['repetitions'] as int,
        nextReviewDate: DateTime.parse(map['nextReviewDate'] as String),
        lastReviewDate: DateTime.parse(map['lastReviewDate'] as String),
        lastQuality: (map['lastQuality'] as num).toDouble(),
      );
}

class SM2SpacedRepetitionService {
  /// Quality rating 0-5 where 5 = perfect, 0 = complete blackout.
  /// Returns updated card after review.
  SM2Card review(SM2Card card, int quality) {
    if (quality < 0 || quality > 5) {
      throw ArgumentError('Quality must be between 0 and 5');
    }

    final now = DateTime.now();
    double newEase = card.easeFactor;
    int newInterval = card.intervalDays;
    int newReps = card.repetitions;

    if (quality >= 3) {
      // Correct response
      if (newReps == 0) {
        newInterval = 1;
      } else if (newReps == 1) {
        newInterval = 6;
      } else {
        newInterval = (newInterval * newEase).round();
      }
      newReps += 1;
    } else {
      // Incorrect: reset
      newReps = 0;
      newInterval = 1;
    }

    // Update ease factor
    newEase = newEase + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (newEase < 1.3) newEase = 1.3;

    final nextReview = now.add(Duration(days: newInterval));

    return card.copyWith(
      easeFactor: newEase,
      intervalDays: newInterval,
      repetitions: newReps,
      nextReviewDate: nextReview,
      lastReviewDate: now,
      lastQuality: quality.toDouble(),
    );
  }

  /// Get cards due for review (nextReviewDate <= now).
  List<SM2Card> getDueCards(List<SM2Card> allCards) {
    final now = DateTime.now();
    return allCards.where((c) => !c.nextReviewDate.isAfter(now)).toList()
      ..sort((a, b) => a.nextReviewDate.compareTo(b.nextReviewDate));
  }

  /// Calculate next interval preview without mutating.
  int previewInterval(SM2Card card, int quality) {
    return review(card, quality).intervalDays;
  }
}
