import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/temporal_aspect/presentation/controllers/temporal_aspect_controller.dart';

void main() {
  group('TemporalAspectController Tests', () {
    late TemporalAspectController controller;

    setUp(() {
      controller = TemporalAspectController();
    });

    test('Initializes with default aspectual scenarios', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedCategory, equals(AspectualCategory.telicVsAtelic));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.sentenceAr, contains('أَتَمَّ البَاحِثُ'));
    });

    test('Transitions smoothly across aspectual categories', () {
      controller.selectCategory(AspectualCategory.habitualIterative);
      expect(controller.state.selectedCategory, equals(AspectualCategory.habitualIterative));
      expect(controller.state.currentScenario?.category, equals(AspectualCategory.habitualIterative));
      expect(controller.state.currentScenario?.sentenceAr, contains('يَعْتَادُونَ'));
    });

    test('Toggles timeline and aspectual contrast views', () {
      controller.toggleAktionsartTimeline();
      expect(controller.state.showAktionsartTimeline, isFalse);

      controller.toggleAspectualContrast();
      expect(controller.state.showAspectualContrast, isFalse);
    });
  });
}
