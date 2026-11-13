import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/collocations/presentation/controllers/collocation_binding_controller.dart';

void main() {
  group('CollocationBindingController - Prepositional Verb Collocation Tests', () {
    late CollocationBindingController controller;

    setUp(() {
      controller = CollocationBindingController();
    });

    test('Initial state configures Arabic prepositional verb (raghiba)', () {
      final state = controller.state;
      expect(state.selectedLanguage, CollocationLanguage.arabic);
      expect(state.selectedVerb.baseVerb, 'رَغِبَ');
      expect(state.selectedVariantIndex, 0);
      expect(state.activeVariant.preposition, 'فِي');
      expect(state.activeVariant.meaningAr.contains('أَرَادَهُ'), isTrue);
    });

    test('Switching preposition variant updates semantic meaning and governed case', () {
      // Switch from 'فِي' (desire) to 'عَنْ' (abstain)
      controller.selectVariant(1);

      expect(controller.state.selectedVariantIndex, 1);
      expect(controller.state.activeVariant.preposition, 'عَنْ');
      expect(controller.state.activeVariant.meaningAr.contains('زَهِدَ فِيهِ'), isTrue);
    });

    test('Language switching updates catalog to appropriate language verbs', () {
      controller.setLanguage(CollocationLanguage.german);
      expect(controller.state.selectedLanguage, CollocationLanguage.german);
      expect(controller.state.selectedVerb.baseVerb, 'warten');
      expect(controller.state.activeVariant.preposition, 'auf + Akkusativ');

      controller.setLanguage(CollocationLanguage.english);
      expect(controller.state.selectedLanguage, CollocationLanguage.english);
      expect(controller.state.selectedVerb.baseVerb, 'depend');
    });

    test('Preposition choice evaluation validates correct answer in quiz mode', () {
      controller.toggleQuizMode();
      expect(controller.state.isQuizModeActive, isTrue);

      // Current active variant is 'فِي'
      final correct = controller.evaluatePrepositionChoice('فِي');
      expect(correct, isTrue);
      expect(controller.state.lastQuizResult, isTrue);

      // Wrong choice 'بِـ'
      final wrong = controller.evaluatePrepositionChoice('بِـ');
      expect(wrong, isFalse);
      expect(controller.state.lastQuizResult, isFalse);
    });

    test('Selecting different verb updates active verb and resets variant index', () {
      final secondVerb = PrepositionalVerb.catalog[1]; // adala
      controller.selectVerb(secondVerb);

      expect(controller.state.selectedVerb.id, 'ar_adala');
      expect(controller.state.selectedVariantIndex, 0);
      expect(controller.state.activeVariant.preposition, 'عَنْ');
    });

    test('Reset restores pristine state', () {
      controller.setLanguage(CollocationLanguage.german);
      controller.reset();

      expect(controller.state.selectedLanguage, CollocationLanguage.arabic);
      expect(controller.state.selectedVerb.baseVerb, 'رَغِبَ');
    });
  });
}
