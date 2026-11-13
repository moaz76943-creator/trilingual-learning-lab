import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/discourse_connectives/controllers/discourse_connectives_controller.dart';
import 'package:trilingual_learning_lab/features/discourse_connectives/data/discourse_connectives_repository.dart';
import 'package:trilingual_learning_lab/features/discourse_connectives/models/discourse_connectives_models.dart';
import 'package:trilingual_learning_lab/features/discourse_connectives/screens/discourse_connectives_studio_screen.dart';

void main() {
  group('DiscourseConnectivesRepository', () {
    const repo = DiscourseConnectivesRepository();

    test('covers all 6 DiscourseRelationType categories', () {
      final triplets = repo.getTriplets();
      expect(triplets.length, 6);
      for (final rel in DiscourseRelationType.values) {
        expect(triplets.any((t) => t.relation == rel), isTrue);
      }
      for (final t in triplets) {
        expect(t.subordinatingAr, isNotEmpty);
        expect(t.subordinatingEn, isNotEmpty);
        expect(t.subordinatingDe, isNotEmpty);
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

  group('DiscourseConnectivesController', () {
    test('filters by relation and search query', () {
      final controller = DiscourseConnectivesController();
      expect(controller.state.filteredTriplets.length, 6);

      controller.selectRelation(DiscourseRelationType.concessive);
      expect(controller.state.filteredTriplets.length, 1);
      expect(
        controller.state.filteredTriplets.first.subordinatingDe,
        contains('obwohl'),
      );

      controller.selectRelation(null);
      controller.updateSearch('sodass');
      expect(controller.state.filteredTriplets.length, 1);
    });

    test('tracks drill mastery and resets cleanly', () {
      final controller = DiscourseConnectivesController();
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

  group('DiscourseConnectivesStudioScreen', () {
    testWidgets('renders studio and toggles adverbial variant',
        (WidgetTester tester) async {
      final controller = DiscourseConnectivesController();
      await tester.pumpWidget(
        MaterialApp(
          home: DiscourseConnectivesStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الرَّوَابِطِ النَّصِّيَّةِ وَتَمَاسُكِ الْفَقْرَةِ'),
        findsOneWidget,
      );
      expect(find.textContaining('wegen seines Fleißes'), findsOneWidget);

      await tester.tap(find.text('الْبَدِيلُ الظَّرْفِيُّ / الْجَرُّ'));
      await tester.pumpAndSettle();

      expect(controller.state.showAdverbialAndPrepVariant, isFalse);
      expect(find.textContaining('wegen seines Fleißes'), findsNothing);
    });
  });
}
