import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/srs_mastery_engine/controllers/srs_mastery_controller.dart';
import 'package:trilingual_learning_lab/features/srs_mastery_engine/data/srs_seed_repository.dart';
import 'package:trilingual_learning_lab/features/srs_mastery_engine/models/srs_models.dart';
import 'package:trilingual_learning_lab/features/srs_mastery_engine/screens/srs_mastery_studio_screen.dart';
import 'package:trilingual_learning_lab/features/srs_mastery_engine/services/sm2_scheduler_service.dart';

void main() {
  group('Sm2SchedulerService & SrsReviewCard Serialization', () {
    const scheduler = Sm2SchedulerService();
    const repo = SrsSeedRepository();

    test('progresses intervals on Good/Easy and resets on Again', () {
      final initial = repo.loadInitialDeck(todayEpochDays: 1000).first;

      final afterFirstGood = scheduler.scheduleNext(
        card: initial,
        grade: RecallGrade.good,
        currentEpochDays: 1000,
      );
      expect(afterFirstGood.repetitions, 1);
      expect(afterFirstGood.intervalDays, 1);
      expect(afterFirstGood.dueEpochDays, 1001);

      final afterSecondGood = scheduler.scheduleNext(
        card: afterFirstGood,
        grade: RecallGrade.good,
        currentEpochDays: 1001,
      );
      expect(afterSecondGood.repetitions, 2);
      expect(afterSecondGood.intervalDays, 6);
      expect(afterSecondGood.dueEpochDays, 1007);

      final afterLapse = scheduler.scheduleNext(
        card: afterSecondGood,
        grade: RecallGrade.again,
        currentEpochDays: 1007,
      );
      expect(afterLapse.repetitions, 0);
      expect(afterLapse.intervalDays, 1);
      expect(afterLapse.lapses, 1);
    });

    test('round-trips SrsReviewCard through JSON cleanly', () {
      final original = repo.loadInitialDeck(todayEpochDays: 5000).first;
      final roundTripped = SrsReviewCard.fromJson(original.toJson());
      expect(roundTripped.id, original.id);
      expect(roundTripped.domain, original.domain);
      expect(roundTripped.easeFactor, original.easeFactor);
      expect(roundTripped.dueEpochDays, original.dueEpochDays);
    });
  });

  group('SrsMasteryController', () {
    test('processes due queue and advances day cleanly', () {
      final controller = SrsMasteryController(initialEpochDays: 20000);
      expect(controller.state.dueQueue.length, 6);

      controller.revealAnswer();
      expect(controller.state.isAnswerRevealed, isTrue);

      controller.submitRecallGrade(RecallGrade.good);
      expect(controller.state.reviewedTodayCount, 1);
      expect(controller.state.dueQueue.length, 5);
      expect(controller.state.isAnswerRevealed, isFalse);

      controller.advanceDayForSimulation();
      expect(controller.state.currentEpochDays, 20001);
      expect(controller.state.dueQueue.length, 6);
    });
  });

  group('SrsMasteryStudioScreen', () {
    testWidgets('reveals answer and grades card in UI',
        (WidgetTester tester) async {
      final controller = SrsMasteryController(initialEpochDays: 20000);
      await tester.pumpWidget(
        MaterialApp(
          home: SrsMasteryStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُحَرِّكُ التَّكْرَارِ الْمُتَبَاعِدِ (SM-2)'),
        findsOneWidget,
      );

      await tester.tap(find.text('إِظْهَارُ الْإِجَابَةِ الثُّلَاثِيَّةِ'));
      await tester.pumpAndSettle();

      expect(find.text('جَيِّدٌ'), findsOneWidget);

      await tester.tap(find.text('جَيِّدٌ'));
      await tester.pumpAndSettle();

      expect(controller.state.reviewedTodayCount, 1);
      expect(controller.state.dueQueue.length, 5);
    });
  });
}
