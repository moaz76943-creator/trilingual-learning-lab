import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/modal_particles/presentation/controllers/modal_particles_controller.dart';

void main() {
  group('ModalParticlesController Tests', () {
    late ModalParticlesController controller;

    setUp(() {
      controller = ModalParticlesController();
    });

    test('Initializes with default modal particles catalogue', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedFunction, equals(ParticleFunction.sharedPresupposition));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.flavoredSentenceAr, contains('أَلَا إِنَّ'));
    });

    test('Transitions smoothly across pragmatic functions', () {
      controller.selectFunction(ParticleFunction.softenedUrgency);
      expect(controller.state.selectedFunction, equals(ParticleFunction.softenedUrgency));
      expect(controller.state.currentScenario?.function, equals(ParticleFunction.softenedUrgency));
      expect(controller.state.currentScenario?.particleDe, contains('mal'));
    });

    test('Toggles pragmatic contrast and Abtönung tips', () {
      controller.togglePragmaticContrast();
      expect(controller.state.showPragmaticContrast, isFalse);

      controller.toggleAbtönungTips();
      expect(controller.state.showAbtönungTips, isFalse);
    });
  });
}
