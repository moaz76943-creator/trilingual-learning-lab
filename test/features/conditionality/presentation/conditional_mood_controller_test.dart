import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/conditionality/presentation/controllers/conditional_mood_controller.dart';

void main() {
  group('ConditionalMoodController Tests', () {
    late ConditionalMoodController controller;

    setUp(() {
      controller = ConditionalMoodController();
    });

    test('Initializes with default conditional scenarios', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedCategory, equals(ConditionalCategory.realisPredictive));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.fullSentenceAr, contains('إِنْ تَجْتَهِدْ'));
    });

    test('Transitions smoothly across conditional categories', () {
      controller.selectCategory(ConditionalCategory.counterfactualPast);
      expect(controller.state.selectedCategory, equals(ConditionalCategory.counterfactualPast));
      expect(controller.state.currentScenario?.category, equals(ConditionalCategory.counterfactualPast));
      expect(controller.state.currentScenario?.fullSentenceAr, contains('لَوْ تَأَنَّى'));
    });

    test('Toggles protasis-apodosis split and mood mechanics views', () {
      controller.toggleProtasisApodosisSplit();
      expect(controller.state.showProtasisApodosisSplit, isFalse);

      controller.toggleMoodMechanics();
      expect(controller.state.showMoodMechanics, isFalse);
    });
  });
}
