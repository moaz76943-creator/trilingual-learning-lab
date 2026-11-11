import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/bookbinding/presentation/controllers/bookbinding_studio_controller.dart';

void main() {
  group('BookbindingStudioController Codicology & Flap State', () {
    late BookbindingStudioController controller;

    setUp(() {
      controller = BookbindingStudioController();
    });

    test('Initializes with Quire Sewing stage and open flap angle', () {
      expect(controller.activeStageIndex, equals(0));
      expect(controller.currentStage.titleAr, contains('الكَرَارِيسِ'));
      expect(controller.flapFoldAngleDegrees, equals(0.0));
      expect(controller.isFlapFullyLocked, isFalse);
      expect(controller.isBlindToolingActive, isFalse);
      expect(controller.quireCount, equals(8));
      expect(controller.spineThicknessMm, equals(20.0)); // 8 quires * 2.5mm = 20.0mm
    });

    test('Folds envelope flap and detects fully locked state at 180 degrees', () {
      controller.setFlapFoldAngle(90.0);
      expect(controller.flapFoldAngleDegrees, equals(90.0));
      expect(controller.isFlapFullyLocked, isFalse);

      controller.setFlapFoldAngle(180.0);
      expect(controller.flapFoldAngleDegrees, equals(180.0));
      expect(controller.isFlapFullyLocked, isTrue); // Locked under front cover!
    });

    test('Toggles blind tooling stamp overlay and resets state', () {
      expect(controller.isBlindToolingActive, isFalse);
      controller.toggleBlindTooling();
      expect(controller.isBlindToolingActive, isTrue);

      controller.setQuireCount(12);
      expect(controller.quireCount, equals(12));
      expect(controller.spineThicknessMm, equals(30.0));

      controller.reset();
      expect(controller.activeStageIndex, equals(0));
      expect(controller.flapFoldAngleDegrees, equals(0.0));
      expect(controller.isBlindToolingActive, isFalse);
      expect(controller.quireCount, equals(8));
    });
  });
}
