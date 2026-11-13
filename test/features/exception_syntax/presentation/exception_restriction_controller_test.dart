import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/exception_syntax/presentation/controllers/exception_restriction_controller.dart';

void main() {
  group('ExceptionRestrictionController Tests', () {
    late ExceptionRestrictionController controller;

    setUp(() {
      controller = ExceptionRestrictionController();
    });

    test('Initializes with default exception scenarios', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedTypology, equals(ExceptionTypology.completeAffirmative));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.fullSentenceAr, contains('إِلَّا المُقَصِّرَ'));
    });

    test('Transitions smoothly across exception typologies', () {
      controller.selectTypology(ExceptionTypology.hollowedRestrictive);
      expect(controller.state.selectedTypology, equals(ExceptionTypology.hollowedRestrictive));
      expect(controller.state.currentScenario?.typology, equals(ExceptionTypology.hollowedRestrictive));
      expect(controller.state.currentScenario?.fullSentenceAr, contains('المُخْلِصُونَ'));
    });

    test('Toggles constituent split and semantic trap views', () {
      controller.toggleConstituentSplit();
      expect(controller.state.showConstituentSplit, isFalse);

      controller.toggleSemanticTraps();
      expect(controller.state.showSemanticTraps, isFalse);
    });
  });
}
