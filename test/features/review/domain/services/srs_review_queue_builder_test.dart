import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/models/srs_card.dart';
import 'package:trilingual_learning_lab/features/review/domain/services/srs_review_queue_builder.dart';

void main() {
  group('SrsReviewQueueBuilder Session Optimization', () {
    final referenceDate = DateTime(2026, 11, 10, 10, 0);

    test('Partitions and bounds review queue with overdue priority', () {
      final cards = [
        // Severely overdue card (due 2 days ago)
        SrsCard(
          id: 'card_overdue_2d',
          frontAr: 'الرُّبْعُ المُجَيَّبُ',
          frontDe: 'Sinusquadrant',
          frontEn: 'Sine quadrant',
          repetitions: 3,
          interval: 4,
          easeFactor: 2.5,
          nextReview: referenceDate.subtract(const Duration(days: 2)),
        ),
        // Moderately overdue card (due 1 hour ago)
        SrsCard(
          id: 'card_overdue_1h',
          frontAr: 'المَخْرُوطُ المَائِيُّ',
          frontDe: 'Wasserkegel',
          frontEn: 'Water cone',
          repetitions: 2,
          interval: 2,
          easeFactor: 2.4,
          nextReview: referenceDate.subtract(const Duration(hours: 1)),
        ),
        // Not due yet (due tomorrow)
        SrsCard(
          id: 'card_future',
          frontAr: 'المِشْكَاةُ النَّحَّاسِيَّةُ',
          frontDe: 'Messinglaterne',
          frontEn: 'Brass lantern',
          repetitions: 4,
          interval: 7,
          easeFactor: 2.6,
          nextReview: referenceDate.add(const Duration(days: 1)),
        ),
        // Brand new card
        SrsCard(
          id: 'card_new_1',
          frontAr: 'العَقْرَبُ الفَلَكِيُّ',
          frontDe: 'Astronomischer Zeiger',
          frontEn: 'Astronomical pointer',
          repetitions: 0,
          interval: 0,
          easeFactor: 2.5,
          nextReview: referenceDate,
        ),
      ];

      final plan = SrsReviewQueueBuilder.buildSessionQueue(
        allCards: cards,
        now: referenceDate,
        maxDueReviews: 10,
        maxNewCards: 5,
        interleaveNewCards: false,
      );

      expect(plan.summary.totalCandidateCards, equals(4));
      expect(plan.summary.totalDueReviews, equals(2));
      expect(plan.summary.totalNewCards, equals(1));
      expect(plan.summary.totalQueued, equals(3));

      // Overdue card due 2 days ago must appear BEFORE card due 1 hour ago
      expect(plan.queue.first.id, equals('card_overdue_2d'));
      expect(plan.queue[1].id, equals('card_overdue_1h'));
      expect(plan.queue[2].id, equals('card_new_1'));

      // Future card should not be queued
      expect(plan.queue.any((c) => c.id == 'card_future'), isFalse);
    });

    test('Enforces maximum review and new card caps', () {
      final dueCards = List.generate(
        15,
        (i) => SrsCard(
          id: 'due_$i',
          frontAr: 'كَلِمَةٌ $i',
          frontDe: 'Wort $i',
          frontEn: 'Word $i',
          repetitions: 1,
          interval: 1,
          easeFactor: 2.5,
          nextReview: referenceDate.subtract(Duration(hours: i + 1)),
        ),
      );

      final newCards = List.generate(
        10,
        (i) => SrsCard(
          id: 'new_$i',
          frontAr: 'جَدِيدٌ $i',
          frontDe: 'Neu $i',
          frontEn: 'New $i',
          repetitions: 0,
          interval: 0,
          easeFactor: 2.5,
          nextReview: referenceDate,
        ),
      );

      final plan = SrsReviewQueueBuilder.buildSessionQueue(
        allCards: [...dueCards, ...newCards],
        now: referenceDate,
        maxDueReviews: 5,
        maxNewCards: 3,
      );

      expect(plan.summary.queuedReviews, equals(5));
      expect(plan.summary.queuedNew, equals(3));
      expect(plan.summary.totalQueued, equals(8));
      expect(plan.queue.length, equals(8));
    });
  });
}
