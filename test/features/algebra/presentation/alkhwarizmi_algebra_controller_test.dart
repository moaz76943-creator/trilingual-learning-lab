import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/algebra/presentation/controllers/alkhwarizmi_algebra_controller.dart';

void main() {
  group('AlKhwarizmiAlgebraController - Geometric Algebra Unit Tests', () {
    late AlKhwarizmiAlgebraController controller;

    setUp(() {
      controller = AlKhwarizmiAlgebraController();
    });

    test('Initial state configures Al-Khwarizmi famous problem (x² + 10x = 39)', () {
      final state = controller.state;
      expect(state.equationType, KhwarizmiEquationType.squaresAndRootsEqualNumbers);
      expect(state.bCoefficient, 10.0);
      expect(state.cConstant, 39.0);
    });

    test('Solves canonical problem x² + 10x = 39 yielding positive root x = 3', () {
      // (10/2)² + 39 = 25 + 39 = 64
      // sqrt(64) - 5 = 8 - 5 = 3
      final root = controller.state.positiveRoot;
      expect(root, isNotNull);
      expect(root!, closeTo(3.0, 0.001));

      // Composite total area is 64
      expect(controller.state.compositeTotalArea, closeTo(64.0, 0.001));
      expect(controller.state.completingSquareArea, closeTo(25.0, 0.001));
      expect(controller.state.compositeSquareSide, closeTo(8.0, 0.001));
    });

    test('Solves canonical type 5 problem: x² + 21 = 10x yielding root x = 7 or 3', () {
      controller.loadHistoricProblem21();

      expect(controller.state.equationType, KhwarizmiEquationType.squaresAndNumbersEqualRoots);
      expect(controller.state.bCoefficient, 10.0);
      expect(controller.state.cConstant, 21.0);

      // (10/2)² - 21 = 25 - 21 = 4
      // x = 5 + sqrt(4) = 7
      final root = controller.state.positiveRoot;
      expect(root, isNotNull);
      expect(root!, closeTo(7.0, 0.001));
    });

    test('Solves simple equation ax² = bx yielding x = b', () {
      controller.setEquationType(KhwarizmiEquationType.squaresEqualRoots);
      controller.setBCoefficient(8.0);

      expect(controller.state.positiveRoot, closeTo(8.0, 0.001));
    });

    test('Solves simple equation ax² = c yielding x = sqrt(c)', () {
      controller.setEquationType(KhwarizmiEquationType.squaresEqualNumbers);
      controller.setCConstant(49.0);

      expect(controller.state.positiveRoot, closeTo(7.0, 0.001));
    });

    test('Proof method switching updates state', () {
      controller.setProofMethod(GeometricProofMethod.twoRectanglesComposite);
      expect(controller.state.proofMethod, GeometricProofMethod.twoRectanglesComposite);
    });

    test('Reset restores pristine state', () {
      controller.setBCoefficient(20.0);
      controller.setCConstant(50.0);
      controller.reset();

      expect(controller.state.bCoefficient, 10.0);
      expect(controller.state.cConstant, 39.0);
    });
  });
}
