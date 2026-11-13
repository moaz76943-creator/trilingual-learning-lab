import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/diglossia/presentation/controllers/diglossia_matrix_controller.dart';

void main() {
  group('DiglossiaMatrixController Tests', () {
    late DiglossiaMatrixController controller;

    setUp(() {
      controller = DiglossiaMatrixController();
    });

    test('Initializes with default diglossia catalogue across situational contexts', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedContext, equals(SituationalContext.academicConference));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.standardFormalAr, contains('المَنْهَجِيَّةِ'));
    });

    test('Transitions smoothly across situational contexts', () {
      controller.selectContext(SituationalContext.dailyMarketplace);
      expect(controller.state.selectedContext, equals(SituationalContext.dailyMarketplace));
      expect(controller.state.currentScenario?.context, equals(SituationalContext.dailyMarketplace));
      expect(controller.state.currentScenario?.colloquialSpokenAr, contains('قَدِّيشْ'));
    });

    test('Toggles phonetic shifts and pragmatic suitability views', () {
      controller.togglePhoneticShifts();
      expect(controller.state.showPhoneticShifts, isFalse);

      controller.togglePragmaticSuitability();
      expect(controller.state.showPragmaticSuitability, isFalse);
    });
  });
}
