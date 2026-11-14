import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/nonfinite_clauses/controllers/nonfinite_clauses_controller.dart';
import 'package:trilingual_learning_lab/features/nonfinite_clauses/data/nonfinite_clauses_repository.dart';
import 'package:trilingual_learning_lab/features/nonfinite_clauses/models/nonfinite_clauses_models.dart';
import 'package:trilingual_learning_lab/features/nonfinite_clauses/screens/nonfinite_clauses_studio_screen.dart';

void main() {
  group('NonFiniteClausesRepository', () {
    const repo = NonFiniteClausesRepository();

    test('covers all 6 NonFiniteCategory values with trilingual units', () {
      final units = repo.getUnits();
      expect(units.length, 6);
      for (final cat in NonFiniteCategory.values) {
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

  group('NonFiniteClausesController', () {
    test('filters by category and search query', () {
      final controller = NonFiniteClausesController();
      expect(controller.state.filteredUnits.length, 6);

      controller.selectCategory(NonFiniteCategory.purposeUmZuVsDamit);
      expect(controller.state.filteredUnits.length, 1);
      expect(
        controller.state.filteredUnits.first.exampleDe,
        contains('damit'),
      );

      controller.selectCategory(null);
      controller.updateSearch('Linksattribut');
      expect(controller.state.filteredUnits.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = NonFiniteClausesController();
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

  group('NonFiniteClausesStudioScreen', () {
    testWidgets('renders studio and toggles rules',
        (WidgetTester tester) async {
      final controller = NonFiniteClausesController();
      await tester.pumpWidget(
        MaterialApp(
          home: NonFiniteClausesStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْمَصْدَرِ الْمُؤَوَّلِ وَالْجُمَلِ غَيْرِ الْمُصَرَّفَةِ'),
        findsOneWidget,
      );
      expect(find.textContaining('zu verstehen'), findsOneWidget);

      await tester.tap(find.text('الشَّرْحُ وَالتَّحْلِيلُ'));
      await tester.pumpAndSettle();

      expect(controller.state.showRules, isFalse);
    });
  });
}
