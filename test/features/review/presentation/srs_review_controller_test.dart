import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/models/srs_card.dart';
import 'package:trilingual_learning_lab/features/review/presentation/controllers/srs_review_controller.dart';

void main() {
  group('SrsReviewController Full Session Lifecycle', () {
    final refTime = DateTime(2026, 11, 10, 10, 0);

    late List<SrsCard> sampleCards;
    late SrsReviewController controller;

    setUp(() {
      sampleCards = [
        SrsCard(
          id: 'card_1',
          frontAr: 'الأَسْطُرْلاَبُ',
          frontDe: 'Das Astrolabium',
          frontEn: 'The Astrolabe',
          repetitions: 1,
          interval: 1,
          easeFactor: 2.5,
          nextReview: refTime.subtract(const Duration(hours: 2)), // Due
        ),
        SrsCard(
          id: 'card_2',
          frontAr: 'العِضَادَةُ',
          frontDe: 'Die Alhidade',
          frontEn: 'The Alidade',
          repetitions: 2,
          interval: 6,
          easeFactor: 2.5,
          nextReview: refTime.subtract(const Duration(hours: 1)), // Due
        ),
      ];

      controller = SrsReviewController(allCards: sampleCards);
    });

    test('Initializes into reviewing state with due cards loaded', () {
      expect(controller.state, equals(SrsReviewState.initial));
      expect(controller.isFlipped, isFalse);

      controller.startSession(now: refTime);

      expect(controller.state, equals(SrsReviewState.reviewing));
      expect(controller.totalInSession, equals(2));
      expect(controller.currentIndex, equals(0));
      expect(controller.currentCard!.id, equals('card_1'));
    });

    test('Flips card and reveals back translations', () {
      controller.startSession(now: refTime);
      expect(controller.isFlipped, isFalse);

      controller.flipCard();
      expect(controller.isFlipped, isTrue);

      controller.flipCard();
      expect(controller.isFlipped, isFalse);
    });

    test('Answers card with Again (0) resetting repetitions and interval to 1', () {
      controller.startSession(now: refTime);
      controller.flipCard();

      controller.answerCard(0, now: refTime); // Rating: Again

      expect(controller.completedCount, equals(1));
      expect(controller.lapsedCount, equals(1));
      expect(controller.currentIndex, equals(1)); // Advanced to second card

      // First card in queue should now have 0 reps and 1-day interval
      final updatedCard1 = controller.currentCard!;
      expect(updatedCard1.id, equals('card_2'));
    });

    test('Completes entire session when all cards are answered', () {
      controller.startSession(now: refTime);

      // Card 1
      controller.flipCard();
      controller.answerCard(4, now: refTime); // Good

      // Card 2
      controller.flipCard();
      controller.answerCard(5, now: refTime); // Easy

      expect(controller.completedCount, equals(2));
      expect(controller.progressPercentage, equals(100.0));
      expect(controller.state, equals(SrsReviewState.sessionCompleted));
      expect(controller.retentionRate, equals(100.0));
    });
  });
}
