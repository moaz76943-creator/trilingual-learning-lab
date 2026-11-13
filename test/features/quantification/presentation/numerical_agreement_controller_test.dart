import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/quantification/presentation/controllers/numerical_agreement_controller.dart';

void main() {
  group('NumericalAgreementController Tests', () {
    late NumericalAgreementController controller;

    setUp(() {
      controller = NumericalAgreementController();
    });

    test('Initializes with default quantification catalogue', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedCategory, equals(QuantificationCategory.inverseAgreement3to10));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.expressionAr, contains('سَبْعَةَ كُتُبٍ'));
    });

    test('Computes inverse gender agreement dynamically for 3-10 and 11-19', () {
      controller.updateInteractiveCount(5);
      expect(controller.state.dynamicArabicPreview, equals('خَمْسَةُ كُتُبٍ'));

      controller.toggleCountedNounGender();
      expect(controller.state.dynamicArabicPreview, equals('خَمْسُ آيَاتٍ'));

      controller.updateInteractiveCount(11);
      expect(controller.state.dynamicArabicPreview, equals('إِحْدَى عَشْرَةَ آيَةً'));

      controller.toggleCountedNounGender();
      expect(controller.state.dynamicArabicPreview, equals('أَحَدَ عَشَرَ كِتَاباً'));
    });

    test('Transitions smoothly across quantification categories', () {
      controller.selectCategory(QuantificationCategory.partitiveMeasureUnits);
      expect(controller.state.selectedCategory, equals(QuantificationCategory.partitiveMeasureUnits));
      expect(controller.state.currentScenario?.category, equals(QuantificationCategory.partitiveMeasureUnits));
    });
  });
}
