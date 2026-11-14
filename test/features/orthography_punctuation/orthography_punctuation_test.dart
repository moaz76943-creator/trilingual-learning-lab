import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/orthography_punctuation/controllers/orthography_punctuation_controller.dart';
import 'package:trilingual_learning_lab/features/orthography_punctuation/data/orthography_punctuation_repository.dart';
import 'package:trilingual_learning_lab/features/orthography_punctuation/models/orthography_punctuation_models.dart';
import 'package:trilingual_learning_lab/features/orthography_punctuation/screens/orthography_punctuation_studio_screen.dart';

void main() {
  group('OrthographyPunctuationRepository', () {
    const repo = OrthographyPunctuationRepository();

    test('covers all 6 OrthographyCategory values with trilingual units', () {
      final units = repo.getUnits();
      expect(units.length, 6);
      for (final cat in OrthographyCategory.values) {
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

  group('OrthographyPunctuationController', () {
    test('filters by category and search query', () {
      final controller = OrthographyPunctuationController();
      expect(controller.state.filteredUnits.length, 6);

      controller.selectCategory(OrthographyCategory.szettVsDoubleS);
      expect(controller.state.filteredUnits.length, 1);
      expect(
        controller.state.filteredUnits.first.exampleDe,
        contains('Straße'),
      );

      controller.selectCategory(null);
      controller.updateSearch('Annas');
      expect(controller.state.filteredUnits.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = OrthographyPunctuationController();
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

  group('OrthographyPunctuationStudioScreen', () {
    testWidgets('renders studio and toggles rules',
        (WidgetTester tester) async {
      final controller = OrthographyPunctuationController();
      await tester.pumpWidget(
        MaterialApp(
          home: OrthographyPunctuationStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْإِمْلَاءِ وَالتَّرْقِيمِ وَنِظَامِ الْكِتَابَةِ'),
        findsOneWidget,
      );
      expect(find.textContaining('etwas Neues'), findsOneWidget);

      await tester.tap(find.text('الشَّرْحُ وَالتَّحْلِيلُ'));
      await tester.pumpAndSettle();

      expect(controller.state.showRules, isFalse);
    });
  });
}
