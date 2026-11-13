import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/apposition_coordination/controllers/apposition_coordination_controller.dart';
import 'package:trilingual_learning_lab/features/apposition_coordination/data/apposition_coordination_repository.dart';
import 'package:trilingual_learning_lab/features/apposition_coordination/models/apposition_coordination_models.dart';
import 'package:trilingual_learning_lab/features/apposition_coordination/screens/apposition_coordination_studio_screen.dart';

void main() {
  group('AppositionCoordinationRepository', () {
    const repo = AppositionCoordinationRepository();

    test('covers all 6 AppositionCoordinationType categories', () {
      final items = repo.getItems();
      expect(items.length, 6);
      for (final type in AppositionCoordinationType.values) {
        expect(items.any((item) => item.type == type), isTrue);
      }
      for (final item in items) {
        expect(item.exampleAr, isNotEmpty);
        expect(item.exampleEn, isNotEmpty);
        expect(item.exampleDe, isNotEmpty);
      }
    });

    test('provides valid drill items with in-bounds correctIndex', () {
      final drills = repo.getDrills();
      expect(drills.length, 6);
      for (final d in drills) {
        expect(d.options.length, greaterThanOrEqualTo(3));
        expect(d.correctIndex, inInclusiveRange(0, d.options.length - 1));
      }
    });
  });

  group('AppositionCoordinationController', () {
    test('filters by type and search query', () {
      final controller = AppositionCoordinationController();
      expect(controller.state.filteredItems.length, 6);

      controller.selectType(AppositionCoordinationType.rectifyingCoordination);
      expect(controller.state.filteredItems.length, 1);
      expect(
        controller.state.filteredItems.first.exampleDe,
        contains('sondern'),
      );

      controller.selectType(null);
      controller.updateSearchQuery('nämlich');
      expect(controller.state.filteredItems.length, 1);
    });

    test('computes mastery score and resets cleanly', () {
      final controller = AppositionCoordinationController();
      final drill = controller.state.currentDrill!;
      controller.submitAnswer(drill.correctIndex);

      expect(controller.state.answeredCount, 1);
      expect(controller.state.correctCount, 1);
      expect(controller.state.masteryScore, 1.0);

      controller.nextDrill();
      expect(controller.state.currentDrillIndex, 1);
      expect(controller.state.selectedOptionIndex, isNull);

      controller.resetDrills();
      expect(controller.state.answeredCount, 0);
      expect(controller.state.correctCount, 0);
      expect(controller.state.currentDrillIndex, 0);
    });
  });

  group('AppositionCoordinationStudioScreen', () {
    testWidgets('renders studio title and toggles grammar notes',
        (WidgetTester tester) async {
      final controller = AppositionCoordinationController();
      await tester.pumpWidget(
        MaterialApp(
          home: AppositionCoordinationStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْبَدَلِ وَالْعَطْفِ وَالِاعْتِرَاضِ'),
        findsOneWidget,
      );
      expect(find.textContaining('Dativ'), findsWidgets);

      await tester.tap(find.text('الشَّرْحُ النَّحْوِيُّ'));
      await tester.pumpAndSettle();

      expect(controller.state.showGrammarNotes, isFalse);
    });
  });
}
