import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/causative_valency/controllers/causative_valency_controller.dart';
import 'package:trilingual_learning_lab/features/causative_valency/data/causative_valency_repository.dart';
import 'package:trilingual_learning_lab/features/causative_valency/models/causative_valency_models.dart';
import 'package:trilingual_learning_lab/features/causative_valency/screens/causative_valency_studio_screen.dart';

void main() {
  group('CausativeValencyRepository', () {
    const repo = CausativeValencyRepository();

    test('covers all 6 CausativeCategory values with trilingual units', () {
      final units = repo.getUnits();
      expect(units.length, 6);
      for (final cat in CausativeCategory.values) {
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

  group('CausativeValencyController', () {
    test('filters by category and search query', () {
      final controller = CausativeValencyController();
      expect(controller.state.filteredUnits.length, 6);

      controller.selectCategory(CausativeCategory.germanLassenDualUse);
      expect(controller.state.filteredUnits.length, 1);
      expect(
        controller.state.filteredUnits.first.exampleDe,
        contains('reparieren lassen'),
      );

      controller.selectCategory(null);
      controller.updateSearch('Schreibtisch');
      expect(controller.state.filteredUnits.length, 0);

      controller.updateSearch('Tisch');
      expect(controller.state.filteredUnits.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = CausativeValencyController();
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

  group('CausativeValencyStudioScreen', () {
    testWidgets('renders studio and toggles rules',
        (WidgetTester tester) async {
      final controller = CausativeValencyController();
      await tester.pumpWidget(
        MaterialApp(
          home: CausativeValencyStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ التَّعْدِيَةِ وَالسَّبَبِيَّةِ وَالتَّكْلِيفِ'),
        findsOneWidget,
      );
      expect(find.textContaining('reparieren lassen'), findsOneWidget);

      await tester.tap(find.text('الشَّرْحُ وَالتَّحْلِيلُ'));
      await tester.pumpAndSettle();

      expect(controller.state.showRules, isFalse);
    });
  });
}
