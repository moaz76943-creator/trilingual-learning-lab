import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/automata/presentation/controllers/hydro_automata_controller.dart';

void main() {
  group('HydroAutomataController - Al-Jazari Hydro-Mechanical Unit Tests', () {
    late HydroAutomataController controller;

    setUp(() {
      controller = HydroAutomataController();
    });

    test('Initial state parameters conform to classical Tarjahar mechanism', () {
      final state = controller.state;
      expect(state.mechanismType, AutomataMechanismType.tarjaharSinkingFloat);
      expect(state.orificeDiameterMm, 2.4);
      expect(state.bowlVolumeMl, 850.0);
      expect(state.isSimulating, isTrue);
      expect(state.totalCyclesCompleted, 0);
    });

    test('Torricelli orifice discharge formula produces accurate flow rate', () {
      final state = controller.state;
      // Area = pi * (2.4 / 2000)^2 = pi * (0.0012)^2 ~ 4.52389e-6 m^2
      // v = sqrt(2 * 9.80665 * 0.04) ~ sqrt(0.784532) ~ 0.885738 m/s
      // Q = 0.62 * 4.52389e-6 * 0.885738 * 1e6 ~ 2.484 ml/s
      final flowRate = state.inflowRateMlPerSec;
      expect(flowRate, closeTo(2.48, 0.15));

      // Fill time for 850 ml: 850 / 2.48 ~ 342 seconds
      final fillTime = state.theoreticalFillTimeSec;
      expect(fillTime, closeTo(342.0, 25.0));
    });

    test('Simulation tick advances elapsed time and computes fill fraction', () {
      controller.setSimulationSpeed(1.0);
      controller.tick(10.0); // 10 seconds

      expect(controller.state.elapsedSeconds, 10.0);
      expect(controller.state.fillFraction, greaterThan(0.0));
      expect(controller.state.sinkProgressPercent, greaterThan(0.0));
    });

    test('Cycle completion resets elapsed seconds and increments completed cycles', () {
      final fillTime = controller.state.theoreticalFillTimeSec;
      controller.setSimulationSpeed(1.0);
      // Advance past full fill time
      controller.tick(fillTime + 5.0);

      expect(controller.state.totalCyclesCompleted, 1);
      expect(controller.state.elapsedSeconds, 0.0);
    });

    test('Auto-calibration adjusts orifice diameter to match target duration', () {
      // Calibrate for 30 minutes (1800 seconds)
      controller.autoCalibrateForTargetMinutes(30.0);

      final state = controller.state;
      final newFillTime = state.theoreticalFillTimeSec;
      // Theoretical fill time should closely match 1800 seconds
      expect(newFillTime, closeTo(1800.0, 60.0));
    });

    test('Reset restores pristine initial state', () {
      controller.setBowlVolume(1500.0);
      controller.setOrificeDiameter(5.0);
      controller.reset();

      expect(controller.state.bowlVolumeMl, 850.0);
      expect(controller.state.orificeDiameterMm, 2.4);
    });
  });
}
