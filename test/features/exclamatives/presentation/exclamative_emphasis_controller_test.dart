import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/exclamatives/presentation/controllers/exclamative_emphasis_controller.dart';

void main() {
  group('ExclamativeEmphasisController Tests', () {
    late ExclamativeEmphasisController controller;

    setUp(() {
      controller = ExclamativeEmphasisController();
    });

    test('Initializes with default exclamative catalogue', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedCategory, equals(ExclamativeCategory.standardExclamationMaAfala));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.exclamativeAr, contains('مَا أَبْدَعَ'));
    });

    test('Transitions smoothly across exclamative categories', () {
      controller.selectCategory(ExclamativeCategory.evaluativePraiseBlame);
      expect(controller.state.selectedCategory, equals(ExclamativeCategory.evaluativePraiseBlame));
      expect(controller.state.currentScenario?.category, equals(ExclamativeCategory.evaluativePraiseBlame));
      expect(controller.state.currentScenario?.exclamativeAr, contains('نِعْمَ الخُلُقُ'));
    });

    test('Toggles neutral comparison and structural formula views', () {
      controller.toggleNeutralComparison();
      expect(controller.state.showNeutralComparison, isFalse);

      controller.toggleStructuralFormula();
      expect(controller.state.showStructuralFormula, isFalse);
    });
  });
}
