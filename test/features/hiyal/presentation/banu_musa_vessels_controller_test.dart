import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/hiyal/presentation/controllers/banu_musa_vessels_controller.dart';

void main() {
  group('BanuMusaVesselsController - Cup of Justice Unit Tests', () {
    late BanuMusaVesselsController controller;

    setUp(() {
      controller = BanuMusaVesselsController();
    });

    test('Initial state configures safe volume below siphon apex', () {
      final state = controller.state;
      expect(state.vesselType, BanuMusaVesselType.cupOfJustice);
      expect(state.currentLiquidVolumeMl, 250.0);
      expect(state.siphonThresholdVolumeMl, 350.0);
      expect(state.isSiphonActive, isFalse);
      expect(state.isSafeZone, isTrue);
    });

    test('Hydrostatic pressure calculation conforms to rho*g*h formula', () {
      // At 250 ml in 500 ml cup of 16 cm height: h = 8 cm = 0.08 m
      // P = 1000 * 9.80665 * 0.08 = 784.53 Pa
      final p = controller.state.hydrostaticPressurePascal;
      expect(p, closeTo(784.5, 5.0));
    });

    test('Adding liquid below threshold preserves liquid without draining', () {
      controller.setLiquidVolume(340.0);
      expect(controller.state.isSafeZone, isTrue);
      expect(controller.state.isSiphonActive, isFalse);
    });

    test('Exceeding threshold triggers siphon and activates complete draining', () {
      controller.setLiquidVolume(360.0); // breaches 350 ml apex
      expect(controller.state.isSiphonActive, isTrue);
      expect(controller.state.isSafeZone, isFalse);
    });

    test('Siphon discharge decreases volume over simulation ticks', () {
      controller.triggerGreedOverflow();
      expect(controller.state.isSiphonActive, isTrue);

      final initialVol = controller.state.currentLiquidVolumeMl;
      // Tick 1 second
      controller.tick(1.0);

      expect(controller.state.currentLiquidVolumeMl, lessThan(initialVol));
    });

    test('Fill to safe limit restores safe equilibrium', () {
      controller.fillToSafeLimit();
      expect(controller.state.isSafeZone, isTrue);
      expect(controller.state.isSiphonActive, isFalse);
      expect(controller.state.currentLiquidVolumeMl, 320.0);
    });

    test('Reset restores pristine state', () {
      controller.setLiquidVolume(100.0);
      controller.reset();

      expect(controller.state.currentLiquidVolumeMl, 250.0);
      expect(controller.state.siphonThresholdVolumeMl, 350.0);
    });
  });
}
