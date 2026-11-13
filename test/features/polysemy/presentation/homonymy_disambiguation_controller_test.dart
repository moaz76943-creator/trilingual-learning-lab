import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/polysemy/presentation/controllers/homonymy_disambiguation_controller.dart';

void main() {
  group('HomonymyDisambiguationController Tests', () {
    late HomonymyDisambiguationController controller;

    setUp(() {
      controller = HomonymyDisambiguationController();
    });

    test('Initializes with default polysemy catalogue', () {
      final state = controller.state;
      expect(state.units.isNotEmpty, isTrue);
      expect(state.selectedCategory, equals(AmbiguityCategory.homonymicPolysemy));
      expect(state.currentUnit, isNotNull);
      expect(state.currentUnit?.targetLemmaAr, contains('العَيْنُ'));
    });

    test('Transitions smoothly across ambiguity categories', () {
      controller.selectCategory(AmbiguityCategory.rhetoricalTawriya);
      expect(controller.state.selectedCategory, equals(AmbiguityCategory.rhetoricalTawriya));
      expect(controller.state.currentUnit?.category, equals(AmbiguityCategory.rhetoricalTawriya));
      expect(controller.state.currentUnit?.targetLemmaAr, contains('الجَدُّ'));
    });

    test('Switches active sense correctly', () {
      controller.setActiveSense(1);
      expect(controller.state.activeSenseIndex, equals(1));
    });

    test('Toggles selectional cues and comparative grid', () {
      controller.toggleSelectionalCues();
      expect(controller.state.showSelectionalCues, isFalse);

      controller.toggleComparativeGrid();
      expect(controller.state.showComparativeGrid, isFalse);
    });
  });
}
