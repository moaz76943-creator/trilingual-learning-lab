import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/simulator/presentation/controllers/astrolabe_simulator_controller.dart';

void main() {
  group('AstrolabeSimulatorController Applied Mechanics', () {
    late AstrolabeSimulatorController controller;

    setUp(() {
      controller = AstrolabeSimulatorController(initialAlidadeAngle: 30.0);
    });

    test('Initializes with default alidade elevation and location', () {
      expect(controller.alidadeAngle, equals(30.0));
      expect(controller.reteAngle, equals(0.0));
      expect(controller.activeLocation.id, equals('loc_damascus'));
      expect(controller.isChallengeCompleted, isFalse);
    });

    test('Rotates alidade and clamps within 0° to 90°', () {
      controller.setAlidadeAngle(60.0);
      expect(controller.alidadeAngle, equals(60.0));

      controller.setAlidadeAngle(110.0); // Exceeds 90°
      expect(controller.alidadeAngle, equals(90.0));

      controller.setAlidadeAngle(-10.0); // Negative
      expect(controller.alidadeAngle, equals(0.0));
    });

    test('Computes shadow square proportion correctly (at 45° shadow equals 12 units)', () {
      controller.setAlidadeAngle(45.0);

      // tan(45°) = 1.0, so 12 / tan(45°) = 12.0 digits
      expect(controller.horizontalShadowDigits, closeTo(12.0, 0.1));
      expect(controller.verticalShadowDigits, closeTo(12.0, 0.1));
      expect(controller.isChallengeCompleted, isTrue); // Completes challenge!
    });

    test('Normalizes rete diurnal rotation angles within 0° to 360°', () {
      controller.setReteAngle(400.0);
      expect(controller.reteAngle, equals(40.0)); // 400 % 360 = 40
    });

    test('Switches active tympan plate location', () {
      controller.selectLocation(1); // Mecca
      expect(controller.activeLocation.id, equals('loc_mecca'));
      expect(controller.activeLocation.latitudeDegrees, equals(21.4));
    });
  });
}
