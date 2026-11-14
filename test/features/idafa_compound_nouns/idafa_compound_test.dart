import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/idafa_compound_nouns/controllers/idafa_compound_controller.dart';
import 'package:trilingual_learning_lab/features/idafa_compound_nouns/data/idafa_compound_repository.dart';
import 'package:trilingual_learning_lab/features/idafa_compound_nouns/models/idafa_compound_models.dart';
import 'package:trilingual_learning_lab/features/idafa_compound_nouns/screens/idafa_compound_studio_screen.dart';

void main() {
  group('IdafaCompoundRepository', () {
    const repo = IdafaCompoundRepository();

    test('covers all 6 CompoundIdafaCategory values with trilingual units', () {
      final units = repo.getUnits();
      expect(units.length, 6);
      for (final cat in CompoundIdafaCategory.values) {
        expect(units.any((u) => u.category == cat), isTrue);
      }
      for (final u in units) {
        expect(u.exampleAr, isNotEmpty);
        expect(u.exampleEn, isNotEmpty);
        expect(u.exampleDe, isNotEmpty);
      }
    });

    test('provides valid drill items', () {
      final drills = repo.getDrills();
      expect(drills.length, 6);
      for (final d in drills) {
        expect(d.options.length, greaterThanOrEqualTo(3));
        expect(d.correctIndex, inInclusiveRange(0, d.options.length - 1));
      }
    });
  });

  group('IdafaCompoundController', () {
    test('filters by category and search query', () {
      final controller = IdafaCompoundController();
      expect(controller.state.filteredUnits.length, 6);

      controller.selectCategory(CompoundIdafaCategory.idafaVsKomposita);
      expect(controller.state.filteredUnits.length, 1);
      expect(
        controller.state.filteredUnits.first.exampleDe,
        contains('Wörterbuch'),
      );

      controller.selectCategory(null);
      controller.updateSearch('Prüfungstag');
      expect(controller.state.filteredUnits.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = IdafaCompoundController();
      final drill = controller.state.currentDrill!;
      controller.submitAnswer(drill.correctIndex);

      expect(controller.state.answeredCount, 1);
      expect(controller.state.correctCount, 1);
      expect(controller.state.accuracyRatio, 1.0);

      controller.nextDrill();
      expect(controller.state.currentDrillIndex, 1);
      expect(controller.state.selectedOptionIndex, isNull);

      controller.resetDrills();
      expect(controller.state.answeredCount, 0);
      expect(controller.state.correctCount, 0);
      expect(controller.state.currentDrillIndex, 0);
    });
  });

  group('IdafaCompoundStudioScreen', () {
    testWidgets('renders studio and toggles rules',
        (WidgetTester tester) async {
      final controller = IdafaCompoundController();
      await tester.pumpWidget(
        MaterialApp(
          home: IdafaCompoundStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْإِضَافَةِ وَالْمُرَكَّبَاتِ الِاسْمِيَّةِ'),
        findsOneWidget,
      );
      expect(find.textContaining('Wörterbuch'), findsOneWidget);

      await tester.tap(find.text('الشَّرْحُ وَالتَّحْلِيلُ'));
      await tester.pumpAndSettle();

      expect(controller.state.showRules, isFalse);
    });
  });
}
