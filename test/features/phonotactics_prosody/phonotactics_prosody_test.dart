import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/phonotactics_prosody/controllers/phonotactics_prosody_controller.dart';
import 'package:trilingual_learning_lab/features/phonotactics_prosody/data/phonotactics_prosody_repository.dart';
import 'package:trilingual_learning_lab/features/phonotactics_prosody/models/phonotactics_prosody_models.dart';
import 'package:trilingual_learning_lab/features/phonotactics_prosody/screens/phonotactics_prosody_studio_screen.dart';

void main() {
  group('PhonotacticsProsodyRepository', () {
    const repo = PhonotacticsProsodyRepository();

    test('covers all 6 PhonotacticsCategory values with IPA examples', () {
      final lessons = repo.getLessons();
      expect(lessons.length, 6);
      for (final category in PhonotacticsCategory.values) {
        expect(lessons.any((l) => l.category == category), isTrue);
      }
      for (final l in lessons) {
        expect(l.arabicExamples, isNotEmpty);
        expect(l.englishExamples, isNotEmpty);
        expect(l.germanExamples, isNotEmpty);
      }
    });

    test('provides valid drill questions', () {
      final drills = repo.getDrills();
      expect(drills.length, 6);
      for (final d in drills) {
        expect(d.options.length, greaterThanOrEqualTo(3));
        expect(d.correctIndex, inInclusiveRange(0, d.options.length - 1));
      }
    });
  });

  group('PhonotacticsProsodyController', () {
    test('filters by category and search query', () {
      final controller = PhonotacticsProsodyController();
      expect(controller.state.filteredLessons.length, 6);

      controller.selectCategory(PhonotacticsCategory.allophonicDistribution);
      expect(controller.state.filteredLessons.length, 1);
      expect(
        controller.state.filteredLessons.first.germanExamples.first.orthography,
        contains('Buch'),
      );

      controller.selectCategory(null);
      controller.updateSearchQuery('Knacklaut');
      expect(controller.state.filteredLessons.length, 1);
    });

    test('tracks drill mastery ratio and resets', () {
      final controller = PhonotacticsProsodyController();
      final drill = controller.state.currentDrill!;
      controller.submitAnswer(drill.correctIndex);

      expect(controller.state.answeredCount, 1);
      expect(controller.state.correctCount, 1);
      expect(controller.state.masteryRatio, 1.0);

      controller.nextDrill();
      expect(controller.state.currentDrillIndex, 1);
      expect(controller.state.selectedOptionIndex, isNull);

      controller.resetDrills();
      expect(controller.state.answeredCount, 0);
      expect(controller.state.correctCount, 0);
      expect(controller.state.currentDrillIndex, 0);
    });
  });

  group('PhonotacticsProsodyStudioScreen', () {
    testWidgets('renders studio and toggles IPA transcriptions',
        (WidgetTester tester) async {
      final controller = PhonotacticsProsodyController();
      await tester.pumpWidget(
        MaterialApp(
          home: PhonotacticsProsodyStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الصَّوْتِيَّاتِ وَالْإِدْغَامِ وَالنَّبْرِ'),
        findsOneWidget,
      );
      expect(find.textContaining('[taːk]'), findsOneWidget);

      await tester.tap(find.text('النَّقْلُ الصَّوْتِيُّ (IPA)'));
      await tester.pumpAndSettle();

      expect(controller.state.showIpaTranscriptions, isFalse);
      expect(find.textContaining('[taːk]'), findsNothing);
    });
  });
}
