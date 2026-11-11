import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/calligraphy/presentation/controllers/calligraphy_studio_controller.dart';

void main() {
  group('CalligraphyStudioController Proportioned Script State', () {
    late CalligraphyStudioController controller;

    setUp(() {
      controller = CalligraphyStudioController(); // Default: Alef (7 dots)
    });

    test('Initializes with Alef model and 7 rhombic dots height', () {
      expect(controller.activeLetter.letterId, equals('letter_alef'));
      expect(controller.activeLetter.letterAr, equals('ا'));
      expect(controller.activeLetter.rhombicDotHeight, equals(7));
      expect(controller.nibSlantAngleDegrees, equals(45.0));
      expect(controller.showRhombicGrid, isTrue);
      expect(controller.showCircumscribedCircle, isTrue);
    });

    test('Switches letters and updates dot geometry and stroke notes', () {
      controller.selectLetter(1); // Baa
      expect(controller.activeLetter.letterId, equals('letter_baa'));
      expect(controller.activeLetter.rhombicDotWidth, equals(6));
      expect(controller.activeLetter.nameDe, contains('Ba'));

      controller.selectLetter(2); // Jeem
      expect(controller.activeLetter.letterId, equals('letter_jeem'));
      expect(controller.activeLetter.strokeDescriptionEn, contains('bowl'));
    });

    test('Toggles grid and circle overlays', () {
      controller.toggleRhombicGrid();
      expect(controller.showRhombicGrid, isFalse);

      controller.toggleCircumscribedCircle();
      expect(controller.showCircumscribedCircle, isFalse);
    });

    test('Clamps nib angle and resets state', () {
      controller.setNibAngle(85.0); // Above 75° max
      expect(controller.nibSlantAngleDegrees, equals(75.0));

      controller.setNibAngle(10.0); // Below 30° min
      expect(controller.nibSlantAngleDegrees, equals(30.0));

      controller.reset();
      expect(controller.activeLetter.letterId, equals('letter_alef'));
      expect(controller.nibSlantAngleDegrees, equals(45.0));
    });
  });
}
