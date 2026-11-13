import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/nominalization_morphology/controllers/nominalization_controller.dart';
import 'package:trilingual_learning_lab/features/nominalization_morphology/data/nominalization_repository.dart';
import 'package:trilingual_learning_lab/features/nominalization_morphology/models/nominalization_models.dart';
import 'package:trilingual_learning_lab/features/nominalization_morphology/screens/nominalization_studio_screen.dart';

void main() {
  group('NominalizationRepository', () {
    const repo = NominalizationRepository();

    test('covers all 6 NominalizationPatternType categories', () {
      final lessons = repo.getLessons();
      expect(lessons.length, 6);
      for (final type in NominalizationPatternType.values) {
        expect(lessons.any((l) => l.type == type), isTrue);
      }
      for (final l in lessons) {
        expect(l.verbalFormAr, isNotEmpty);
        expect(l.nominalFormAr, isNotEmpty);
        expect(l.verbalFormEn, isNotEmpty);
        expect(l.nominalFormEn, isNotEmpty);
        expect(l.verbalFormDe, isNotEmpty);
        expect(l.nominalFormDe, isNotEmpty);
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

  group('NominalizationController', () {
    test('filters by type and search query', () {
      final controller = NominalizationController();
      expect(controller.state.filteredLessons.length, 6);

      controller.selectType(NominalizationPatternType.clausalNominalization);
      expect(controller.state.filteredLessons.length, 1);
      expect(
        controller.state.filteredLessons.first.nominalFormDe,
        contains('vor Beginn'),
      );

      controller.selectType(null);
      controller.updateSearch('Klarheit');
      expect(controller.state.filteredLessons.length, 1);
    });

    test('tracks drill mastery percentage and resets', () {
      final controller = NominalizationController();
      final drill = controller.state.currentDrill!;
      controller.submitAnswer(drill.correctIndex);

      expect(controller.state.answeredCount, 1);
      expect(controller.state.correctCount, 1);
      expect(controller.state.masteryPercentage, 1.0);

      controller.nextDrill();
      expect(controller.state.currentDrillIndex, 1);
      expect(controller.state.selectedOptionIndex, isNull);

      controller.resetDrills();
      expect(controller.state.answeredCount, 0);
      expect(controller.state.correctCount, 0);
      expect(controller.state.currentDrillIndex, 0);
    });
  });

  group('NominalizationStudioScreen', () {
    testWidgets('renders studio and toggles nominal vs verbal style',
        (WidgetTester tester) async {
      final controller = NominalizationController();
      await tester.pumpWidget(
        MaterialApp(
          home: NominalizationStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْمَصَادِرِ وَالِاسْمِيَّةِ وَالِاشْتِقَاقِ'),
        findsOneWidget,
      );
      expect(find.textContaining('Das sorgfältige Lesen'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(controller.state.showNominalStyle, isFalse);
      expect(find.textContaining('Der Student liest den Text'), findsOneWidget);
    });
  });
}
