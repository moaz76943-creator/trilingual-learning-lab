import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/phonetics/presentation/controllers/phonetic_studio_controller.dart';

void main() {
  group('PhoneticStudioController Auditory Discernment State', () {
    late PhoneticStudioController controller;

    setUp(() {
      controller = PhoneticStudioController();
    });

    test('Initializes with default minimal pairs and zero attempts', () {
      expect(controller.totalPairs, greaterThanOrEqualTo(3));
      expect(controller.activePairIndex, equals(0));
      expect(controller.currentPair!.id, equals('pair_sad_seen'));
      expect(controller.totalAttempts, equals(0));
      expect(controller.score, equals(0));
      expect(controller.accuracyPercentage, equals(0.0));
      expect(controller.selectedWord, isNull);
      expect(controller.isCorrect, isNull);
    });

    test('Evaluates correct auditory choice and updates score', () {
      final pair = controller.currentPair!;
      controller.submitChoice(pair.targetWord); // Correct

      expect(controller.isCorrect, isTrue);
      expect(controller.selectedWord, equals(pair.targetWord));
      expect(controller.score, equals(1));
      expect(controller.totalAttempts, equals(1));
      expect(controller.accuracyPercentage, equals(100.0));
    });

    test('Evaluates incorrect auditory choice and tracks accuracy', () {
      final pair = controller.currentPair!;
      final wrongWord = pair.isWordACorrect ? pair.wordB : pair.wordA;

      controller.submitChoice(wrongWord); // Incorrect

      expect(controller.isCorrect, isFalse);
      expect(controller.score, equals(0));
      expect(controller.totalAttempts, equals(1));
      expect(controller.accuracyPercentage, equals(0.0));
    });

    test('Advances to next minimal pair and resets selection state', () {
      controller.submitChoice('صَيْفٌ');
      controller.nextPair();

      expect(controller.activePairIndex, equals(1));
      expect(controller.selectedWord, isNull);
      expect(controller.isCorrect, isNull);
    });

    test('Resets session state completely', () {
      controller.submitChoice('صَيْفٌ');
      controller.reset();

      expect(controller.activePairIndex, equals(0));
      expect(controller.score, equals(0));
      expect(controller.totalAttempts, equals(0));
      expect(controller.isCorrect, isNull);
    });
  });
}
