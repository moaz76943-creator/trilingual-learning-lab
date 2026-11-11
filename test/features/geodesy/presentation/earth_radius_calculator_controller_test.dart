import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/geodesy/presentation/controllers/earth_radius_calculator_controller.dart';

void main() {
  group('EarthRadiusCalculatorController - Al-Biruni Geodesy Unit Tests', () {
    late EarthRadiusCalculatorController controller;

    setUp(() {
      controller = EarthRadiusCalculatorController();
    });

    test('Initial parameters match Al-Biruni Nandana historic measurement', () {
      final state = controller.state;
      expect(state.mountainHeightMeters, 651.5);
      expect(state.dipAngleMinutes, 34.0);
      expect(state.selectedBenchmark, GeodeticBenchmark.alBiruniNandana);
      expect(state.showTrigRayDiagram, isTrue);
    });

    test('Al-Biruni formula computes accurate Earth Radius ~ 6339.6 km', () {
      // With h = 651.5 m (0.6515 km) and alpha = 34 arcminutes (0.56667 degrees):
      // alpha_rad = 0.566667 * pi / 180 = 0.009890199 rad
      // cos(alpha) = 0.99995109
      // 1 - cos(alpha) = 0.000048909
      // R = (0.6515 * 0.99995109) / 0.000048909 = 6339.6 km
      final radius = controller.state.calculatedRadiusKm;
      expect(radius, closeTo(6339.6, 5.0));

      // Circumference: 2 * pi * 6339.6 ~ 39833 km
      final circumference = controller.state.calculatedCircumferenceKm;
      expect(circumference, closeTo(39833.0, 50.0));

      // Error vs modern WGS-84 (6371.0 km) is within ~0.5%
      final error = controller.state.errorPercentageVsModern;
      expect(error.abs(), lessThan(1.0));
    });

    test('Changing mountain height updates radius proportionally', () {
      // If height doubles, radius doubles (holding dip angle constant)
      final initialRadius = controller.state.calculatedRadiusKm;
      controller.setMountainHeight(651.5 * 2);
      final newRadius = controller.state.calculatedRadiusKm;

      expect(newRadius, closeTo(initialRadius * 2, 1.0));
    });

    test('Horizon distance calculation', () {
      // d = R * tan(alpha)
      final d = controller.state.horizonDistanceKm;
      final expected = controller.state.calculatedRadiusKm *
          math.tan(controller.state.dipAngleRadians);
      expect(d, closeTo(expected, 0.001));
    });

    test('Reset restores pristine state', () {
      controller.setMountainHeight(1500.0);
      controller.setDipAngleMinutes(45.0);
      controller.reset();

      expect(controller.state.mountainHeightMeters, 651.5);
      expect(controller.state.dipAngleMinutes, 34.0);
    });
  });
}
