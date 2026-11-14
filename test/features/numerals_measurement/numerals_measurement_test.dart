import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/numerals_measurement/controllers/numerals_measurement_controller.dart';
import 'package:trilingual_learning_lab/features/numerals_measurement/data/numerals_measurement_repository.dart';
import 'package:trilingual_learning_lab/features/numerals_measurement/models/numerals_measurement_models.dart';
import 'package:trilingual_learning_lab/features/numerals_measurement/screens/numerals_measurement_studio_screen.dart';

void main() {
  group('NumeralsMeasurementRepository', () {
    const repo = NumeralsMeasurementRepository();

    test('covers all 6 NumeralCategory values with trilingual units', () {
      final units = repo.getUnits();
      expect(units.length, 6);
      for (final cat in NumeralCategory.values) {
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

  group('NumeralsMeasurementController', () {
    test('filters by category and search query', () {
      final controller = NumeralsMeasurementController();
      expect(controller.state.filteredUnits.length, 6);

      controller.selectCategory(NumeralCategory.clockTimeAsymmetry);
      expect(controller.state.filteredUnits.length, 1);
      expect(
        controller.state.filteredUnits.first.exampleDe,
        contains('halb drei'),
      );

      controller.selectCategory(null);
      controller.updateSearch('Liter');
      expect(controller.state.filteredUnits.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = NumeralsMeasurementController();
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

  group('NumeralsMeasurementStudioScreen', () {
    testWidgets('renders studio and toggles rules',
        (WidgetTester tester) async {
      final controller = NumeralsMeasurementController();
      await tester.pumpWidget(
        MaterialApp(
          home: NumeralsMeasurementStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْأَعْدَادِ وَالتَّوْقِيتِ وَالْمَقَادِيرِ'),
        findsOneWidget,
      );
      expect(find.textContaining('drei Bücher'), findsOneWidget);

      await tester.tap(find.text('الشَّرْحُ وَالتَّحْلِيلُ'));
      await tester.pumpAndSettle();

      expect(controller.state.showRules, isFalse);
    });
  });
}
