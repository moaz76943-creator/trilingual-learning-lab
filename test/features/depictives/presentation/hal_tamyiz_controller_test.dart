import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/depictives/presentation/controllers/hal_tamyiz_controller.dart';

void main() {
  group('HalTamyizController Tests', () {
    late HalTamyizController controller;

    setUp(() {
      controller = HalTamyizController();
    });

    test('Initializes with default depictive scenarios', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedCategory, equals(DepictiveCategory.singularDepictiveHal));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.sentenceAr, contains('مُبْتَسِماً'));
    });

    test('Transitions smoothly across depictive categories', () {
      controller.selectCategory(DepictiveCategory.specificationTamyiz);
      expect(controller.state.selectedCategory, equals(DepictiveCategory.specificationTamyiz));
      expect(controller.state.currentScenario?.category, equals(DepictiveCategory.specificationTamyiz));
      expect(controller.state.currentScenario?.sentenceAr, contains('طَابَ المُؤْمِنُ نَفْساً'));
    });

    test('Toggles contrast rule and detailed diagnosis views', () {
      controller.toggleContrastRule();
      expect(controller.state.showContrastRule, isFalse);

      controller.toggleDetailedDiagnosis();
      expect(controller.state.showDetailedDiagnosis, isFalse);
    });
  });
}
