import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/false_friends_register/controllers/false_friends_controller.dart';
import 'package:trilingual_learning_lab/features/false_friends_register/data/false_friends_repository.dart';
import 'package:trilingual_learning_lab/features/false_friends_register/models/false_friends_models.dart';
import 'package:trilingual_learning_lab/features/false_friends_register/screens/false_friends_studio_screen.dart';

void main() {
  group('FalseFriendsRepository', () {
    const repo = FalseFriendsRepository();

    test('covers all 6 FalseFriendCategory values with trilingual content', () {
      final entries = repo.getEntries();
      expect(entries.length, greaterThanOrEqualTo(6));
      for (final cat in FalseFriendCategory.values) {
        expect(entries.any((e) => e.category == cat), isTrue);
      }
      for (final e in entries) {
        expect(e.germanTerm, isNotEmpty);
        expect(e.englishLookalike, isNotEmpty);
        expect(e.exampleAr, isNotEmpty);
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

  group('FalseFriendsController', () {
    test('filters by category and search query', () {
      final controller = FalseFriendsController();
      expect(controller.state.filteredEntries.length, 7);

      controller.selectCategory(FalseFriendCategory.verbSemantics);
      expect(controller.state.filteredEntries.length, 1);
      expect(controller.state.filteredEntries.first.germanTerm, 'bekommen');

      controller.selectCategory(null);
      controller.updateSearch('Gymnasium');
      expect(controller.state.filteredEntries.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = FalseFriendsController();
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

  group('FalseFriendsStudioScreen', () {
    testWidgets('renders studio and toggles contextual examples',
        (WidgetTester tester) async {
      final controller = FalseFriendsController();
      await tester.pumpWidget(
        MaterialApp(
          home: FalseFriendsStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْأَلْفَاظِ الْخَادِعَةِ (Falsche Freunde)'),
        findsOneWidget,
      );
      expect(find.textContaining('Stipendium bekommen'), findsOneWidget);

      await tester.tap(find.text('الْأَمْثِلَةُ السِّيَاقِيَّةُ'));
      await tester.pumpAndSettle();

      expect(controller.state.showExamples, isFalse);
      expect(find.textContaining('Stipendium bekommen'), findsNothing);
    });
  });
}
