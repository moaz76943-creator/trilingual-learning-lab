import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/geometry/presentation/controllers/geometric_pattern_controller.dart';

void main() {
  group('GeometricPatternController Mathematical Symmetry', () {
    late GeometricPatternController controller;

    setUp(() {
      controller = GeometricPatternController(); // Default: 8-fold star
    });

    test('Initializes with Andalusian 8-fold star preset', () {
      expect(controller.foldCount, equals(8));
      expect(controller.activePreset.nameAr, contains('الثُّمَانِيُّ'));
      expect(controller.activePreset.nameDe, contains('achteckige'));
      expect(controller.constructionStage, equals(3));
      expect(controller.rotationAngleDegrees, equals(0.0));
    });

    test('Computes exactly 2N vertices for N-fold star polygon', () {
      final vertices = controller.calculateStarVertices(100.0, 100.0, 50.0);
      expect(vertices.length, equals(16)); // 8 outer tips + 8 inner indentations = 16
    });

    test('Calculates vertex tip angle correctly', () {
      // For N=8, angle = (1 - 2/8) * 180° = 135°
      expect(controller.vertexTipAngleDegrees, equals(135.0));

      controller.selectPreset(0); // 6-fold star: (1 - 2/6) * 180° = 120°
      expect(controller.vertexTipAngleDegrees, equals(120.0));
    });

    test('Clamps inner radius ratio within safe mathematical bounds', () {
      controller.setInnerRadiusRatio(0.99); // Exceeds max 0.85
      expect(controller.innerRadiusRatio, equals(0.85));

      controller.setInnerRadiusRatio(0.05); // Below min 0.20
      expect(controller.innerRadiusRatio, equals(0.20));
    });

    test('Advances and clamps construction stages', () {
      controller.setConstructionStage(1);
      expect(controller.constructionStage, equals(1));

      controller.setConstructionStage(5); // Clamped to 3
      expect(controller.constructionStage, equals(3));
    });
  });
}
