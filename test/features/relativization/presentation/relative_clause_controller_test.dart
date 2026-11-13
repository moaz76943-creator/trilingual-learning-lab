import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/relativization/presentation/controllers/relative_clause_controller.dart';

void main() {
  group('RelativeClauseController Tests', () {
    late RelativeClauseController controller;

    setUp(() {
      controller = RelativeClauseController();
    });

    test('Initializes with default relativization scenarios', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedPattern, equals(RelativizationPattern.resumptivePronounBinding));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.fullSentenceAr, contains('الكِتَابُ المُنِيرُ'));
    });

    test('Transitions smoothly across relativization patterns', () {
      controller.selectPattern(RelativizationPattern.asyndeticZeroRelative);
      expect(controller.state.selectedPattern, equals(RelativizationPattern.asyndeticZeroRelative));
      expect(controller.state.currentScenario?.pattern, equals(RelativizationPattern.asyndeticZeroRelative));
      expect(controller.state.currentScenario?.fullSentenceAr, contains('بَعَثَ اللَّهُ نَبِيّاً'));
    });

    test('Toggles resumptive binding and transfer pitfall views', () {
      controller.toggleResumptiveBinding();
      expect(controller.state.showResumptiveBinding, isFalse);

      controller.toggleTransferPitfall();
      expect(controller.state.showTransferPitfall, isFalse);
    });
  });
}
