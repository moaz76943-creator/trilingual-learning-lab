import 'package:flutter/foundation.dart';
import '../../../../models/srs_card.dart';

/// Metrics summarizing a built review queue session.
class ReviewQueueSummary {
  final int totalCandidateCards;
  final int totalDueReviews;
  final int totalNewCards;
  final int queuedReviews;
  final int queuedNew;

  const ReviewQueueSummary({
    required this.totalCandidateCards,
    required this.totalDueReviews,
    required this.totalNewCards,
    required this.queuedReviews,
    required this.queuedNew,
  });

  int get totalQueued => queuedReviews + queuedNew;
}

/// Result containing the ordered queue and session statistics.
class ReviewSessionPlan {
  final List<SrsCard> queue;
  final ReviewQueueSummary summary;

  const ReviewSessionPlan({
    required this.queue,
    required this.summary,
  });
}

/// Service that builds an optimized, bounded SRS review session queue.
class SrsReviewQueueBuilder {
  /// Builds a prioritized review queue from [allCards] evaluated at [now].
  static ReviewSessionPlan buildSessionQueue({
    required List<SrsCard> allCards,
    DateTime? now,
    int maxDueReviews = 20,
    int maxNewCards = 10,
    bool interleaveNewCards = true,
  }) {
    final referenceTime = now ?? DateTime.now();

    final dueCards = <SrsCard>[];
    final newCards = <SrsCard>[];

    // 1. Partition cards into due reviews vs new learning cards
    for (final card in allCards) {
      if (card.repetitions == 0) {
        newCards.add(card);
      } else if (card.isDue(referenceTime)) {
        dueCards.add(card);
      }
    }

    final totalDue = dueCards.length;
    final totalNew = newCards.length;

    // 2. Prioritize overdue cards: cards due longest ago come first
    dueCards.sort((a, b) => a.nextReview.compareTo(b.nextReview));

    // 3. Take up to configured limits
    final selectedDue = dueCards.take(maxDueReviews).toList();
    final selectedNew = newCards.take(maxNewCards).toList();

    // 4. Assemble final queue with zero duplicates
    final finalQueue = <SrsCard>[];
    final seenIds = <String>{};

    void addCard(SrsCard card) {
      if (!seenIds.contains(card.id)) {
        seenIds.add(card.id);
        finalQueue.add(card);
      }
    }

    if (interleaveNewCards && selectedNew.isNotEmpty && selectedDue.isNotEmpty) {
      // Interleave: review cards first with new cards introduced evenly
      int dueIndex = 0;
      int newIndex = 0;
      int cadence = (selectedDue.length / (selectedNew.length + 1)).ceil();
      if (cadence < 1) cadence = 1;

      while (dueIndex < selectedDue.length || newIndex < selectedNew.length) {
        for (var i = 0; i < cadence && dueIndex < selectedDue.length; i++) {
          addCard(selectedDue[dueIndex++]);
        }
        if (newIndex < selectedNew.length) {
          addCard(selectedNew[newIndex++]);
        }
      }
    } else {
      // Append reviews then new cards
      for (final card in selectedDue) {
        addCard(card);
      }
      for (final card in selectedNew) {
        addCard(card);
      }
    }

    return ReviewSessionPlan(
      queue: finalQueue,
      summary: ReviewQueueSummary(
        totalCandidateCards: allCards.length,
        totalDueReviews: totalDue,
        totalNewCards: totalNew,
        queuedReviews: selectedDue.length,
        queuedNew: selectedNew.length,
      ),
    );
  }
}
