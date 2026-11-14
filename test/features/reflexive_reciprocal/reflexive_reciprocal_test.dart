import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/reflexive_reciprocal/controllers/reflexive_reciprocal_controller.dart';
import 'package:trilingual_learning_lab/features/reflexive_reciprocal/data/reflexive_reciprocal_repository.dart';
import 'package:trilingual_learning_lab/features/reflexive_reciprocal/models/reflexive_reciprocal_models.dart';
import 'package:trilingual_learning_lab/features/reflexive_reciprocal/screens/reflexive_reciprocal_studio_screen.dart';

void main() {
  group('ReflexiveReciprocalRepository', () {
    const repo = ReflexiveReciprocalRepository();

    test('covers all 6 ReflexiveCategory values with trilingual units', () {
      final units = repo.getUnits();
      expect(units.length, 6);
      for (final cat in ReflexiveCategory.values) {
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

  group('ReflexiveReciprocalController', () {
    test('filters by category and search query', () {
      final controller = ReflexiveReciprocalController();
      expect(controller.state.filteredUnits.length, 6);

      controller.selectCategory(ReflexiveCategory.akkusativVsDativReflexive);
      expect(controller.state.filteredUnits.length, 1);
      expect(
        controller.state.filteredUnits.first.exampleDe,
        contains('mir diese Regel'),
      );

      controller.selectCategory(null);
      controller.updateSearch('einander');
      expect(controller.state.filteredUnits.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = ReflexiveReciprocalController();
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

  group('ReflexiveReciprocalStudioScreen', () {
    testWidgets('renders studio and toggles rules',
        (WidgetTester tester) async {
      final controller = ReflexiveReciprocalController();
      await tester.pumpWidget(
        MaterialApp(
          home: ReflexiveReciprocalStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْأَفْعَالِ الِانْعِكَاسِيَّةِ وَالْمُطَاوَعَةِ'),
        findsOneWidget,
      );
      expect(find.textContaining('wasche mir die Hände'), findsOneWidget);

      await tester.tap(find.text('الشَّرْحُ وَالتَّحْلِيلُ'));
      await tester.pumpAndSettle();

      expect(controller.state.showRules, isFalse);
    });
  });
}
