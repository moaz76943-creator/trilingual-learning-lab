import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/phonetics/presentation/controllers/formant_phonetic_trainer_controller.dart';

void main() {
  group('FormantPhoneticTrainerController - Acoustic Formant & Minimal Pair Tests', () {
    late FormantPhoneticTrainerController controller;

    setUp(() {
      controller = FormantPhoneticTrainerController();
    });

    test('Initial state configures Arabic minimal pair (qalb vs kalb)', () {
      final state = controller.state;
      expect(state.language, PhoneticLanguage.arabic);
      expect(state.selectedExercise.wordA, 'قَلْبٌ');
      expect(state.selectedExercise.wordB, 'كَلْبٌ');
      expect(state.targetIsWordA, isTrue);
      expect(state.acousticClosenessScore, greaterThan(80.0));
    });

    test('Language switching updates catalog to appropriate minimal pairs', () {
      controller.setLanguage(PhoneticLanguage.german);
      expect(controller.state.language, PhoneticLanguage.german);
      expect(controller.state.selectedExercise.wordA, 'schon');
      expect(controller.state.selectedExercise.wordB, 'schön');

      controller.setLanguage(PhoneticLanguage.english);
      expect(controller.state.language, PhoneticLanguage.english);
      expect(controller.state.selectedExercise.wordA, 'ship');
      expect(controller.state.selectedExercise.wordB, 'sheep');
    });

    test('Formant updates recalculate Euclidean Bark distance and match score', () {
      controller.setLanguage(PhoneticLanguage.arabic);
      final target = controller.state.targetVowel;

      // Perfectly matching formants
      controller.updateUserFormants(f1Hz: target.f1Hz, f2Hz: target.f2Hz);
      expect(controller.state.acousticClosenessScore, closeTo(100.0, 0.1));

      // Heavily shifted formants
      controller.updateUserFormants(f1Hz: 250.0, f2Hz: 2500.0);
      expect(controller.state.acousticClosenessScore, lessThan(60.0));
    });

    test('Discrimination guess updates attempt tracking accurately', () {
      // Current target is Word A
      final isCorrect = controller.submitDiscriminationGuess(true);
      expect(isCorrect, isTrue);
      expect(controller.state.correctDiscriminationsCount, 9);
      expect(controller.state.totalAttemptsCount, 10);

      // Guessing Word B when target is Word A
      final isWrong = controller.submitDiscriminationGuess(false);
      expect(isWrong, isFalse);
      expect(controller.state.correctDiscriminationsCount, 9);
      expect(controller.state.totalAttemptsCount, 11);
    });

    test('Target word switching flips target vowel reference', () {
      controller.switchTargetWord(false);
      expect(controller.state.targetIsWordA, isFalse);
      expect(controller.state.targetWord, controller.state.selectedExercise.wordB);
    });

    test('Reset restores pristine state', () {
      controller.setLanguage(PhoneticLanguage.english);
      controller.reset();

      expect(controller.state.language, PhoneticLanguage.arabic);
      expect(controller.state.selectedExercise.wordA, 'قَلْبٌ');
    });
  });
}
