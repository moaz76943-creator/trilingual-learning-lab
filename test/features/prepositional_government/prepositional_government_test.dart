import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/prepositional_government/controllers/prepositional_government_controller.dart';
import 'package:trilingual_learning_lab/features/prepositional_government/data/prepositional_government_repository.dart';
import 'package:trilingual_learning_lab/features/prepositional_government/models/prepositional_government_models.dart';
import 'package:trilingual_learning_lab/features/prepositional_government/screens/prepositional_government_studio_screen.dart';

void main() {
  group('PrepositionalGovernmentRepository', () {
    const repo = PrepositionalGovernmentRepository();

    test('covers all 6 PrepositionDomain categories', () {
      final pairs = repo.getPairs();
      expect(pairs.length, 6);
      for (final domain in PrepositionDomain.values) {
        expect(pairs.any((p) => p.domain == domain), isTrue);
      }
      for (final p in pairs) {
        expect(p.patternAAr, isNotEmpty);
        expect(p.patternBAr, isNotEmpty);
        expect(p.patternADe, isNotEmpty);
        expect(p.patternBDe, isNotEmpty);
        expect(p.patternAEn, isNotEmpty);
        expect(p.patternBEn, isNotEmpty);
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

  group('PrepositionalGovernmentController', () {
    test('filters by domain and search query', () {
      final controller = PrepositionalGovernmentController();
      expect(controller.state.filteredPairs.length, 6);

      controller.selectDomain(PrepositionDomain.wechselpraepositionen);
      expect(controller.state.filteredPairs.length, 1);
      expect(
        controller.state.filteredPairs.first.patternADe,
        contains('auf dem Schreibtisch'),
      );

      controller.selectDomain(null);
      controller.updateSearch('teilnehmen');
      expect(controller.state.filteredPairs.length, 1);
    });

    test('tracks drill accuracy and resets cleanly', () {
      final controller = PrepositionalGovernmentController();
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

  group('PrepositionalGovernmentStudioScreen', () {
    testWidgets('renders studio title and toggles contrast pattern B',
        (WidgetTester tester) async {
      final controller = PrepositionalGovernmentController();
      await tester.pumpWidget(
        MaterialApp(
          home: PrepositionalGovernmentStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ حُرُوفِ الْجَرِّ وَالتَّعَدِّي اللُّغَوِيِّ'),
        findsOneWidget,
      );
      expect(find.textContaining('auf den Schreibtisch'), findsOneWidget);

      await tester.tap(find.text('إِظْهَارُ النَّمَطِ الْمُقَابِلِ (B)'));
      await tester.pumpAndSettle();

      expect(controller.state.showContrastPatternB, isFalse);
      expect(find.textContaining('auf den Schreibtisch'), findsNothing);
    });
  });
}
