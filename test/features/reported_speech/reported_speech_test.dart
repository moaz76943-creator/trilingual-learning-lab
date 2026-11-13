import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/reported_speech/controllers/reported_speech_controller.dart';
import 'package:trilingual_learning_lab/features/reported_speech/data/reported_speech_repository.dart';
import 'package:trilingual_learning_lab/features/reported_speech/models/reported_speech_models.dart';
import 'package:trilingual_learning_lab/features/reported_speech/screens/reported_speech_studio_screen.dart';

void main() {
  group('ReportedSpeechRepository', () {
    const repo = ReportedSpeechRepository();

    test('covers all 6 ReportedSpeechCategory values with trilingual data', () {
      final scenarios = repo.getScenarios();
      expect(scenarios.length, greaterThanOrEqualTo(6));
      for (final category in ReportedSpeechCategory.values) {
        expect(
          scenarios.any((s) => s.category == category),
          isTrue,
          reason: 'Missing scenario for ${category.id}',
        );
      }
      for (final s in scenarios) {
        expect(s.directAr.trim(), isNotEmpty);
        expect(s.indirectAr.trim(), isNotEmpty);
        expect(s.directEn.trim(), isNotEmpty);
        expect(s.indirectEn.trim(), isNotEmpty);
        expect(s.directDe.trim(), isNotEmpty);
        expect(s.indirectDe.trim(), isNotEmpty);
      }
    });

    test('provides valid diagnostic drills with in-bounds correctIndex', () {
      final drills = repo.getDrills();
      expect(drills.length, greaterThanOrEqualTo(6));
      for (final d in drills) {
        expect(d.options.length, greaterThanOrEqualTo(3));
        expect(d.correctIndex, inInclusiveRange(0, d.options.length - 1));
      }
    });
  });

  group('ReportedSpeechController', () {
    test('filters by category and multilingual search query', () {
      final controller = ReportedSpeechController();
      expect(controller.state.filteredScenarios.length, 6);

      controller.selectCategory(ReportedSpeechCategory.konjunktivEvidential);
      expect(controller.state.filteredScenarios.length, 1);
      expect(
        controller.state.filteredScenarios.first.indirectDe,
        contains('hätten'),
      );

      controller.selectCategory(null);
      controller.updateSearchQuery('Konjunktiv');
      expect(controller.state.filteredScenarios, isNotEmpty);

      controller.updateSearchQuery('الْمَخْطُوطَةَ');
      expect(controller.state.filteredScenarios.length, 1);
    });

    test('tracks drill mastery ratio and supports reset', () {
      final controller = ReportedSpeechController();
      final firstDrill = controller.state.currentDrill!;
      controller.submitDrillAnswer(firstDrill.correctIndex);

      expect(controller.state.answeredCount, 1);
      expect(controller.state.correctAnswers, 1);
      expect(controller.state.masteryRatio, 1.0);

      controller.nextDrill();
      expect(controller.state.currentDrillIndex, 1);
      expect(controller.state.selectedOptionIndex, isNull);

      controller.resetDrills();
      expect(controller.state.answeredCount, 0);
      expect(controller.state.correctAnswers, 0);
      expect(controller.state.currentDrillIndex, 0);
    });
  });

  group('ReportedSpeechStudioScreen', () {
    testWidgets('renders trilingual studio and toggles direct/indirect mode',
        (WidgetTester tester) async {
      final controller = ReportedSpeechController();
      await tester.pumpWidget(
        MaterialApp(
          home: ReportedSpeechStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْكَلَامِ الْمَنْقُولِ وَالْإِحَالَةِ'),
        findsOneWidget,
      );
      expect(find.textContaining('bewahre'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(find.textContaining('bewahrt'), findsOneWidget);
    });
  });
}
