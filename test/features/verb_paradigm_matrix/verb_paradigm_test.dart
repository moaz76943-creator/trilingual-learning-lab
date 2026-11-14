import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/verb_paradigm_matrix/controllers/verb_paradigm_controller.dart';
import 'package:trilingual_learning_lab/features/verb_paradigm_matrix/data/verb_paradigm_repository.dart';
import 'package:trilingual_learning_lab/features/verb_paradigm_matrix/models/verb_paradigm_models.dart';
import 'package:trilingual_learning_lab/features/verb_paradigm_matrix/screens/verb_paradigm_studio_screen.dart';

void main() {
  group('VerbParadigmRepository', () {
    const repo = VerbParadigmRepository();

    test('covers all 6 VerbMorphologyAxis values with trilingual paradigms', () {
      final entries = repo.getEntries();
      expect(entries.length, 6);
      for (final axis in VerbMorphologyAxis.values) {
        expect(entries.any((e) => e.axis == axis), isTrue);
      }
      for (final e in entries) {
        expect(e.arabicForms, isNotEmpty);
        expect(e.englishForms, isNotEmpty);
        expect(e.germanForms, isNotEmpty);
      }
    });

    test('provides valid conjugation drill questions', () {
      final drills = repo.getDrills();
      expect(drills.length, 6);
      for (final d in drills) {
        expect(d.options.length, greaterThanOrEqualTo(3));
        expect(d.correctIndex, inInclusiveRange(0, d.options.length - 1));
      }
    });
  });

  group('VerbParadigmController', () {
    test('filters by axis and search query', () {
      final controller = VerbParadigmController();
      expect(controller.state.filteredEntries.length, 6);

      controller.selectAxis(VerbMorphologyAxis.habenVsSeinPerfekt);
      expect(controller.state.filteredEntries.length, 1);
      expect(
        controller.state.filteredEntries.first.germanForms,
        contains('ist gereist'),
      );

      controller.selectAxis(null);
      controller.updateSearch('spricht');
      expect(controller.state.filteredEntries.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = VerbParadigmController();
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

  group('VerbParadigmStudioScreen', () {
    testWidgets('renders studio and toggles morphology rules',
        (WidgetTester tester) async {
      final controller = VerbParadigmController();
      await tester.pumpWidget(
        MaterialApp(
          home: VerbParadigmStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ تَصْرِيفِ الْأَفْعَالِ وَالْمِيزَانِ الصَّرْفِيِّ'),
        findsOneWidget,
      );
      expect(find.textContaining('ist geblieben'), findsOneWidget);

      await tester.tap(find.text('الشَّرْحُ الصَّرْفِيُّ'));
      await tester.pumpAndSettle();

      expect(controller.state.showMorphologyRules, isFalse);
    });
  });
}
