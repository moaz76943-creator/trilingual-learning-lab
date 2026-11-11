import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/ebru/presentation/controllers/ebru_studio_controller.dart';

void main() {
  group('EbruStudioController Fluid Physics & Combing', () {
    late EbruStudioController controller;

    setUp(() {
      controller = EbruStudioController();
    });

    test('Initializes with empty tray and default ox gall concentration', () {
      expect(controller.dropCount, equals(0));
      expect(controller.activeTool, equals(EbruToolType.dropper));
      expect(controller.activePigment.id, equals('lapis_lazuli'));
      expect(controller.oxGallConcentration, equals(1.2));
      expect(controller.isPaperPrinted, isFalse);
    });

    test('Adds drop computing radius from surface tension formula', () {
      controller.addDrop(100.0, 100.0);

      expect(controller.dropCount, equals(1));
      final drop = controller.drops.first;
      expect(drop.x, equals(100.0));
      expect(drop.y, equals(100.0));
      expect(drop.radius, greaterThan(15.0)); // Base 18.0 * sqrt(1.2)
    });

    test('Applies Gel-Git sinusoidal wave transformation', () {
      controller.addDrop(50.0, 50.0);
      final initialY = controller.drops.first.y;

      controller.applyCombPattern(EbruPatternStyle.gelGit);

      final newY = controller.drops.first.y;
      expect(newY, isNot(equals(initialY))); // Y coordinates shifted by wave
    });

    test('Prints paper and locks further edits until reset', () {
      controller.addDrop(50.0, 50.0);
      controller.printPaper();

      expect(controller.isPaperPrinted, isTrue);

      // Dropping while printed should be rejected
      controller.addDrop(80.0, 80.0);
      expect(controller.dropCount, equals(1));

      controller.resetTray();
      expect(controller.dropCount, equals(0));
      expect(controller.isPaperPrinted, isFalse);
    });
  });
}
