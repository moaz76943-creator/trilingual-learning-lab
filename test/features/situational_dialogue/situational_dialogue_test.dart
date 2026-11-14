import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/situational_dialogue/controllers/situational_dialogue_controller.dart';
import 'package:trilingual_learning_lab/features/situational_dialogue/data/situational_dialogue_repository.dart';
import 'package:trilingual_learning_lab/features/situational_dialogue/models/situational_dialogue_models.dart';
import 'package:trilingual_learning_lab/features/situational_dialogue/screens/situational_dialogue_studio_screen.dart';

void main() {
  group('SituationalDialogueRepository', () {
    const repo = SituationalDialogueRepository();

    test('covers all 6 DialogueContextDomain categories with multi-turn dialogues', () {
      final scenarios = repo.getScenarios();
      expect(scenarios.length, 6);
      for (final domain in DialogueContextDomain.values) {
        expect(scenarios.any((s) => s.domain == domain), isTrue);
      }
      for (final s in scenarios) {
        expect(s.turns.length, greaterThanOrEqualTo(2));
        for (final t in s.turns) {
          expect(t.lineAr, isNotEmpty);
          expect(t.lineEn, isNotEmpty);
          expect(t.lineDe, isNotEmpty);
        }
      }
    });

    test('provides valid roleplay challenges', () {
      final challenges = repo.getChallenges();
      expect(challenges.length, 6);
      for (final c in challenges) {
        expect(c.options.length, greaterThanOrEqualTo(3));
        expect(c.correctIndex, inInclusiveRange(0, c.options.length - 1));
      }
    });
  });

  group('SituationalDialogueController', () {
    test('filters by domain and search query', () {
      final controller = SituationalDialogueController();
      expect(controller.state.filteredScenarios.length, 6);

      controller.selectDomain(DialogueContextDomain.pharmacyAndCare);
      expect(controller.state.filteredScenarios.length, 1);
      expect(
        controller.state.filteredScenarios.first.turns.first.lineDe,
        contains('Augentropfen'),
      );

      controller.selectDomain(null);
      controller.updateSearch('Gleis');
      expect(controller.state.filteredScenarios.length, 1);
    });

    test('tracks roleplay accuracy and resets', () {
      final controller = SituationalDialogueController();
      final challenge = controller.state.currentChallenge!;
      controller.submitResponse(challenge.correctIndex);

      expect(controller.state.answeredCount, 1);
      expect(controller.state.correctCount, 1);
      expect(controller.state.accuracyRatio, 1.0);

      controller.nextChallenge();
      expect(controller.state.currentChallengeIndex, 1);
      expect(controller.state.selectedOptionIndex, isNull);

      controller.resetChallenges();
      expect(controller.state.answeredCount, 0);
      expect(controller.state.correctCount, 0);
      expect(controller.state.currentChallengeIndex, 0);
    });
  });

  group('SituationalDialogueStudioScreen', () {
    testWidgets('renders studio and toggles German dialogue lines',
        (WidgetTester tester) async {
      final controller = SituationalDialogueController();
      await tester.pumpWidget(
        MaterialApp(
          home: SituationalDialogueStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْمُحَادَثَاتِ الْحَيَّةِ وَالْحِوَارِ الْمَوْقِفِيِّ'),
        findsOneWidget,
      );
      expect(find.textContaining('Sprachwörterbuchs'), findsOneWidget);

      await tester.tap(find.text('النَّصُّ الْأَلْمَانِيُّ'));
      await tester.pumpAndSettle();

      expect(controller.state.showGermanLine, isFalse);
      expect(find.textContaining('Sprachwörterbuchs'), findsNothing);
    });
  });
}
