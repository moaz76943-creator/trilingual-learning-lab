import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/paremiology/presentation/controllers/proverbial_wisdom_controller.dart';

void main() {
  group('ProverbialWisdomController Tests', () {
    late ProverbialWisdomController controller;

    setUp(() {
      controller = ProverbialWisdomController();
    });

    test('Initializes with default proverbial catalogue', () {
      final state = controller.state;
      expect(state.entries.isNotEmpty, isTrue);
      expect(state.selectedTheme, equals(WisdomTheme.patiencePerseverance));
      expect(state.currentEntry, isNotNull);
      expect(state.currentEntry?.canonicalProverbAr, contains('الصَّبْرُ'));
    });

    test('Transitions smoothly across wisdom themes', () {
      controller.selectTheme(WisdomTheme.justiceRetribution);
      expect(controller.state.selectedTheme, equals(WisdomTheme.justiceRetribution));
      expect(controller.state.currentEntry?.theme, equals(WisdomTheme.justiceRetribution));
      expect(controller.state.currentEntry?.canonicalProverbAr, contains('حَفَرَ حُفْرَةً'));
    });

    test('Toggles literal vs figurative breakdown and cultural origins', () {
      controller.toggleLiteralVsFigurative();
      expect(controller.state.showLiteralVsFigurative, isFalse);

      controller.toggleCulturalOrigins();
      expect(controller.state.showCulturalOrigins, isFalse);
    });
  });
}
