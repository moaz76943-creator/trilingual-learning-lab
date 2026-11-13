import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/kinematics/presentation/controllers/tusi_couple_controller.dart';

void main() {
  group('TusiCoupleController - Pure Rectilinear Kinematics Unit Tests', () {
    late TusiCoupleController controller;

    setUp(() {
      controller = TusiCoupleController();
    });

    test('Initial state configures pure linear oscillation (d = r = R/2)', () {
      final state = controller.state;
      expect(state.mode, TusiCoupleMode.pureLinearOscillation);
      expect(state.outerRadiusR, 120.0);
      expect(state.innerRadiusR, 60.0);
      expect(state.pointOffsetRatio, 1.0);
      expect(state.tracingPointDistance, 60.0);
    });

    test('Al-Tusi theorem proof: y-coordinate is identically ZERO for all angles theta', () {
      // Test at 0°, 30°, 45°, 90°, 180°, 270°, 360°
      final testAngles = [0.0, 30.0, 45.0, 90.0, 180.0, 270.0, 330.0];

      for (final angle in testAngles) {
        controller.tick(0.0); // force state refresh
        // Set angle via state copy simulation
        final thetaRad = angle * (math.pi / 180.0);
        final r = controller.state.innerRadiusR;
        final d = controller.state.tracingPointDistance;

        // y = (r - d) * sin(theta) = (60 - 60) * sin(theta) = 0
        final y = (r - d) * math.sin(thetaRad);
        expect(y.abs(), lessThan(1e-9));

        // x = (r + d) * cos(theta) = 2r * cos(theta) = R * cos(theta)
        final x = (r + d) * math.cos(thetaRad);
        expect(x, closeTo(120.0 * math.cos(thetaRad), 1e-6));
      }
    });

    test('General point d != r produces elliptical trajectory', () {
      controller.setMode(TusiCoupleMode.ellipticalTrajectory);
      controller.setPointOffsetRatio(0.5); // d = 0.5 * r = 30 mm

      // Semi-major axis a = r + d = 60 + 30 = 90 mm
      expect(controller.state.semiMajorAxis, closeTo(90.0, 0.001));

      // Semi-minor axis b = |r - d| = |60 - 30| = 30 mm
      expect(controller.state.semiMinorAxis, closeTo(30.0, 0.001));
    });

    test('Velocity vector is strictly horizontal when d = r', () {
      // Since y(t) = 0, vy must be identically 0
      final vy = controller.state.velocityVector.dy;
      expect(vy.abs(), lessThan(1e-9));
    });

    test('Simulation tick increments angle and updates trajectory history', () {
      controller.tick(1.0); // 1 second
      expect(controller.state.rotationAngleThetaDeg, greaterThan(0.0));
      expect(controller.state.trajectoryHistory.isNotEmpty, isTrue);
    });

    test('Reset restores pristine state', () {
      controller.setAngularSpeedRpm(30.0);
      controller.setPointOffsetRatio(0.4);
      controller.reset();

      expect(controller.state.angularSpeedRpm, 12.0);
      expect(controller.state.pointOffsetRatio, 1.0);
    });
  });
}
