import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/hermeneutics/presentation/controllers/semantic_paraphrase_controller.dart';

void main() {
  group('SemanticParaphraseController Tests', () {
    late SemanticParaphraseController controller;

    setUp(() {
      controller = SemanticParaphraseController();
    });

    test('Initializes with default hermeneutic catalogue across equivalence paradigms', () {
      final state = controller.state;
      expect(state.units.isNotEmpty, isTrue);
      expect(state.selectedEquivalence, equals(EquivalenceType.dynamicExegetical));
      expect(state.currentUnit, isNotNull);
      expect(state.currentUnit?.originalTermAr, contains('الرَّأْفَةُ'));
    });

    test('Transitions smoothly across equivalence types', () {
      controller.selectEquivalence(EquivalenceType.conceptualVoid);
      expect(controller.state.selectedEquivalence, equals(EquivalenceType.conceptualVoid));
      expect(controller.state.currentUnit?.equivalenceType, equals(EquivalenceType.conceptualVoid));
      expect(controller.state.currentUnit?.originalTermAr, contains('التَّقْوَى'));
    });

    test('Toggles exegetical notes and nuance breakdowns', () {
      controller.toggleExegeticalNotes();
      expect(controller.state.showExegeticalNotes, isFalse);

      controller.toggleNuanceBreakdown();
      expect(controller.state.showNuanceBreakdown, isFalse);

      controller.setInvarianceThreshold(0.95);
      expect(controller.state.targetInvarianceThreshold, equals(0.95));
    });
  });
}
