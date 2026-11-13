import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/tusi/presentation/controllers/al_tusi_cubic_controller.dart';

void main() {
  group('AlTusiCubicController - Cubic Equations & Extrema Unit Tests', () {
    late AlTusiCubicController controller;

    setUp(() {
      controller = AlTusiCubicController();
    });

    test('Initial state configures historic Al-Tusi equation x³ + 16 = 12x', () {
      final state = controller.state;
      expect(state.form, TusiCubicForm.cubesAndNumbersEqualRoots);
      expect(state.bCoefficient, 12.0);
      expect(state.dConstant, 16.0);
    });

    test('Al-Tusi derivative extremum rule yields x_max = sqrt(b/3) = 2.0', () {
      // For 12x - x³, derivative is 12 - 3x² = 0 => x = sqrt(12/3) = 2.0
      final xMax = controller.state.extremumX;
      expect(xMax, closeTo(2.0, 0.001));

      // Maximum value f(2) = 12(2) - (2)³ = 24 - 8 = 16.0
      final yMax = controller.state.maximumValue;
      expect(yMax, closeTo(16.0, 0.001));

      // Condition f(x_max) >= d holds (16 >= 16)
      expect(controller.state.hasRealPositiveRoots, isTrue);
    });

    test('Double root detection at x = 2 when maximum equals constant d', () {
      final roots = controller.state.positiveRoots;
      expect(roots.isNotEmpty, isTrue);
      // Double root is 2.0
      expect(roots.first, closeTo(2.0, 0.05));
    });

    test('Type 2 equation x³ + d = cx² has extremum at x = 2c/3', () {
      controller.setForm(TusiCubicForm.cubesAndNumbersEqualSquares);
      controller.setBCoefficient(6.0); // c = 6
      // x_max = 2(6) / 3 = 4.0
      expect(controller.state.extremumX, closeTo(4.0, 0.001));

      // f(4) = 6(4)² - (4)³ = 96 - 64 = 32.0
      expect(controller.state.maximumValue, closeTo(32.0, 0.001));
    });

    test('Impossible equation with d > f_max has no positive roots', () {
      // Set d = 25.0 while f_max = 16.0
      controller.setDConstant(25.0);
      expect(controller.state.hasRealPositiveRoots, isFalse);
      expect(controller.state.positiveRoots.isEmpty, isTrue);
    });

    test('Reset restores pristine historic state', () {
      controller.setDConstant(30.0);
      controller.reset();

      expect(controller.state.dConstant, 16.0);
      expect(controller.state.bCoefficient, 12.0);
    });
  });
}
