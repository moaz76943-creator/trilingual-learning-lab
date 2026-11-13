import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/complementation/presentation/controllers/five_objects_controller.dart';

void main() {
  group('FiveObjectsController Tests', () {
    late FiveObjectsController controller;

    setUp(() {
      controller = FiveObjectsController();
    });

    test('Initializes with default five objects catalogue', () {
      final state = controller.state;
      expect(state.scenarios.isNotEmpty, isTrue);
      expect(state.selectedCategory, equals(ComplementCategory.absoluteCognateMutlaq));
      expect(state.currentScenario, isNotNull);
      expect(state.currentScenario?.complementWordAr, contains('صَبْراً'));
    });

    test('Transitions smoothly across all five object categories', () {
      controller.selectCategory(ComplementCategory.causalPurposiveLiAjlihi);
      expect(controller.state.selectedCategory, equals(ComplementCategory.causalPurposiveLiAjlihi));
      expect(controller.state.currentScenario?.category, equals(ComplementCategory.causalPurposiveLiAjlihi));
      expect(controller.state.currentScenario?.complementWordAr, contains('رَغْبَةً'));

      controller.selectCategory(ComplementCategory.comitativeMaahu);
      expect(controller.state.selectedCategory, equals(ComplementCategory.comitativeMaahu));
      expect(controller.state.currentScenario?.complementWordAr, contains('وَسَيَلَانَ'));
    });

    test('Toggles syntactic parsing and unified verse demo views', () {
      controller.toggleSyntacticParsing();
      expect(controller.state.showSyntacticParsing, isFalse);

      controller.toggleUnifiedVerseDemo();
      expect(controller.state.showUnifiedVerseDemo, isFalse);
    });
  });
}
