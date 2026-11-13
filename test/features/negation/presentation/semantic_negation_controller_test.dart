import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/negation/presentation/controllers/semantic_negation_controller.dart';

void main() {
  group('SemanticNegationController Tests', () {
    late SemanticNegationController controller;

    setUp(() {
      controller = SemanticNegationController();
    });

    test('Initializes with default negation scenarios', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedCategory, equals(NegationCategory.temporalAspectual));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.negatedSentenceAr, contains('لَمْ يَخُنْ'));
    });

    test('Transitions smoothly across negation categories', () {
      controller.selectCategory(NegationCategory.litotesDoubleNeg);
      expect(controller.state.selectedCategory, equals(NegationCategory.litotesDoubleNeg));
      expect(controller.state.currentScenario?.category, equals(NegationCategory.litotesDoubleNeg));
      expect(controller.state.currentScenario?.negatedSentenceAr, contains('بِبَعِيدٍ'));
    });

    test('Toggles scope visualizer and polarity constraints', () {
      controller.toggleScopeVisualizer();
      expect(controller.state.showScopeVisualizer, isFalse);

      controller.togglePolarityConstraints();
      expect(controller.state.showPolarityConstraints, isFalse);
    });
  });
}
