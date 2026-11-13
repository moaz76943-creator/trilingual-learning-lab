import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/sociolinguistics/presentation/controllers/pragmatic_register_controller.dart';

void main() {
  group('PragmaticRegisterController Tests', () {
    late PragmaticRegisterController controller;

    setUp(() {
      controller = PragmaticRegisterController();
    });

    test('Initializes with default pragmatic scenarios across register levels', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedLevel, equals(PragmaticRegisterLevel.diwanicFormal));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.titleAr, contains('طَلَبُ'));
    });

    test('Transitions smoothly across register levels and preserves politeness markers', () {
      controller.selectLevel(PragmaticRegisterLevel.academicScholarly);
      expect(controller.state.selectedLevel, equals(PragmaticRegisterLevel.academicScholarly));
      expect(controller.state.currentScenario?.level, equals(PragmaticRegisterLevel.academicScholarly));
      expect(controller.state.currentScenario?.politenessMarkerAr, contains('مَعَ بَالِغِ التَّقْدِيرِ'));
    });

    test('Toggles mitigation markers and cross-cultural tips', () {
      controller.toggleMitigationMarkers();
      expect(controller.state.showMitigationMarkers, isFalse);

      controller.toggleCrossCulturalTips();
      expect(controller.state.showCrossCulturalTips, isFalse);
    });
  });
}
