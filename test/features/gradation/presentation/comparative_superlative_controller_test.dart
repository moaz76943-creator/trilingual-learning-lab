import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/gradation/presentation/controllers/comparative_superlative_controller.dart';

void main() {
  group('ComparativeSuperlativeController Tests', () {
    late ComparativeSuperlativeController controller;

    setUp(() {
      controller = ComparativeSuperlativeController();
    });

    test('Initializes with default gradation scenarios', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedPattern, equals(GradationPattern.comparativeDifferential));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.gradedSentenceAr, contains('أَنْفَعُ مِنَ'));
    });

    test('Transitions smoothly across gradation patterns', () {
      controller.selectPattern(GradationPattern.correlativeProportional);
      expect(controller.state.selectedPattern, equals(GradationPattern.correlativeProportional));
      expect(controller.state.currentScenario?.pattern, equals(GradationPattern.correlativeProportional));
      expect(controller.state.currentScenario?.gradedSentenceDe, contains('desto höher'));
    });

    test('Toggles morphological rules and common error views', () {
      controller.toggleMorphologicalRules();
      expect(controller.state.showMorphologicalRules, isFalse);

      controller.toggleCommonErrors();
      expect(controller.state.showCommonErrors, isFalse);
    });
  });
}
