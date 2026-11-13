import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/horology/presentation/controllers/ibn_yunus_pendulum_controller.dart';

void main() {
  group('IbnYunusPendulumController - Horological Physics Unit Tests', () {
    late IbnYunusPendulumController controller;

    setUp(() {
      controller = IbnYunusPendulumController();
    });

    test('Initial state configures Seconds Pendulum parameters (L ~ 0.994m)', () {
      final state = controller.state;
      expect(state.pendulumLengthMeters, 0.994);
      expect(state.initialAngleDeg, 15.0);
      expect(state.isSimulating, isTrue);

      // Period should be extremely close to 2.0 seconds
      expect(state.smallAnglePeriodSec, closeTo(2.00, 0.02));
      expect(state.exactPeriodSec, closeTo(2.01, 0.03));
    });

    test('Finite amplitude correction increases period with larger release angles', () {
      controller.setInitialAngle(5.0);
      final periodSmall = controller.state.exactPeriodSec;

      controller.setInitialAngle(45.0);
      final periodLarge = controller.state.exactPeriodSec;

      expect(periodLarge, greaterThan(periodSmall));
    });

    test('Beats per minute calculation for seconds pendulum is ~ 60 bpm', () {
      controller.loadSecondsPendulumPreset();
      // Period is 2.0s -> 2 beats per 2.0s = 1 beat/sec = 60 beats/min
      final bpm = controller.state.beatsPerMinute;
      expect(bpm, closeTo(60.0, 1.0));
    });

    test('Numerical tick integration updates instantaneous angle and elapsed time', () {
      final initialAngle = controller.state.currentAngleDeg;
      controller.tick(0.1); // 100 ms

      expect(controller.state.elapsedSeconds, closeTo(0.1, 0.001));
      expect(controller.state.currentAngleDeg, isNot(equals(initialAngle)));
    });

    test('Pendulum length doubling increases period by sqrt(2)', () {
      controller.setPendulumLength(1.0);
      final t1 = controller.state.smallAnglePeriodSec;

      controller.setPendulumLength(2.0);
      final t2 = controller.state.smallAnglePeriodSec;

      expect(t2 / t1, closeTo(math.sqrt(2.0), 0.01));
    });

    test('Reset restores pristine state', () {
      controller.setPendulumLength(1.8);
      controller.setInitialAngle(30.0);
      controller.reset();

      expect(controller.state.pendulumLengthMeters, 0.994);
      expect(controller.state.initialAngleDeg, 15.0);
    });
  });
}
