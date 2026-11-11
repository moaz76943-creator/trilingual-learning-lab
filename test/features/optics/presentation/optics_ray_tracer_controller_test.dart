import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/optics/presentation/controllers/optics_ray_tracer_controller.dart';

void main() {
  group('OpticsRayTracerController - Sovereign Engineering Unit Tests', () {
    late OpticsRayTracerController controller;

    setUp(() {
      controller = OpticsRayTracerController();
    });

    test('Initial state conforms to classical Alhazen refraction parameters', () {
      final state = controller.state;
      expect(state.mode, OpticsMode.refraction);
      expect(state.incidentMedium, OpticalMedium.air);
      expect(state.refractiveMedium, OpticalMedium.glassCrown);
      expect(state.incidentAngleDeg, 30.0);
      expect(state.showNormalLine, isTrue);
      expect(state.showReflectedRay, isTrue);
    });

    test('Snell-Alhazen refraction angle computation is accurate', () {
      // Air (n1=1.0003) to Glass Crown (n2=1.52) with incident angle 30°
      // sin(theta2) = (1.0003 / 1.52) * sin(30°) = 0.65809 * 0.5 = 0.329046
      // theta2 = asin(0.329046) in degrees ~ 19.21°
      final state = controller.state;
      final refracted = state.refractedAngleDeg;
      expect(refracted, isNotNull);
      expect(refracted!, closeTo(19.21, 0.1));
    });

    test('Total Internal Reflection is accurately detected when transitioning denser to rarer medium', () {
      // Glass Crown (n1=1.52) to Air (n2=1.0003)
      controller.setIncidentMedium(OpticalMedium.glassCrown);
      controller.setRefractiveMedium(OpticalMedium.air);

      // Critical angle: asin(1.0003 / 1.52) = asin(0.65809) ~ 41.15°
      final crit = controller.state.criticalAngleDeg;
      expect(crit, isNotNull);
      expect(crit!, closeTo(41.15, 0.2));

      // At 30° (< crit), refraction occurs
      controller.setIncidentAngle(30.0);
      expect(controller.state.isTotalInternalReflection, isFalse);
      expect(controller.state.refractedAngleDeg, isNotNull);

      // At 60° (> crit), total internal reflection occurs
      controller.setIncidentAngle(60.0);
      expect(controller.state.isTotalInternalReflection, isTrue);
      expect(controller.state.refractedAngleDeg, isNull);
    });

    test('Camera Obscura magnification and inverted image calculation', () {
      controller.setMode(OpticsMode.cameraObscura);
      controller.setObjectDistance(50.0); // 50 cm
      controller.setChamberDepth(25.0); // 25 cm
      controller.setObjectHeight(10.0); // 10 cm

      // Image height = 10 * (25 / 50) = 5.0 cm
      expect(controller.state.pinholeImageHeightCm, closeTo(5.0, 0.01));

      // Blur spot calculation
      controller.setApertureDiameter(2.0); // 2 mm
      // blur = 2.0 * (1 + 25 / 50) = 2.0 * 1.5 = 3.0 mm
      expect(controller.state.blurCircleDiameterMm, closeTo(3.0, 0.01));
    });

    test('Medium swapping maintains mathematical consistency', () {
      controller.setIncidentMedium(OpticalMedium.water);
      controller.setRefractiveMedium(OpticalMedium.diamond);

      controller.swapMediums();

      expect(controller.state.incidentMedium, OpticalMedium.diamond);
      expect(controller.state.refractiveMedium, OpticalMedium.water);
    });
  });
}
