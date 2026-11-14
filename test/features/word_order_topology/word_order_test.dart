import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/word_order_topology/controllers/word_order_controller.dart';
import 'package:trilingual_learning_lab/features/word_order_topology/data/word_order_repository.dart';
import 'package:trilingual_learning_lab/features/word_order_topology/models/word_order_models.dart';
import 'package:trilingual_learning_lab/features/word_order_topology/screens/word_order_studio_screen.dart';

void main() {
  group('WordOrderRepository', () {
    const repo = WordOrderRepository();

    test('covers all 6 WordOrderTopic values with trilingual patterns', () {
      final patterns = repo.getPatterns();
      expect(patterns.length, 6);
      for (final topic in WordOrderTopic.values) {
        expect(patterns.any((p) => p.topic == topic), isTrue);
      }
      for (final p in patterns) {
        expect(p.sentenceAr, isNotEmpty);
        expect(p.sentenceEn, isNotEmpty);
        expect(p.sentenceDe, isNotEmpty);
        expect(p.slotBreakdownDe, isNotEmpty);
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

  group('WordOrderController', () {
    test('filters by topic and search query', () {
      final controller = WordOrderController();
      expect(controller.state.filteredPatterns.length, 6);

      controller.selectTopic(WordOrderTopic.tekamoloVsMpt);
      expect(controller.state.filteredPatterns.length, 1);
      expect(
        controller.state.filteredPatterns.first.sentenceDe,
        contains('mit dem Zug nach Berlin'),
      );

      controller.selectTopic(null);
      controller.updateSearch('Satzklammer');
      expect(controller.state.filteredPatterns.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = WordOrderController();
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

  group('WordOrderStudioScreen', () {
    testWidgets('renders studio and toggles topological slot breakdown',
        (WidgetTester tester) async {
      final controller = WordOrderController();
      await tester.pumpWidget(
        MaterialApp(
          home: WordOrderStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ رُتْبَةِ الْكَلِمَاتِ وَالْقَوْسِ الْفِعْلِيِّ'),
        findsOneWidget,
      );
      expect(find.textContaining('Linke Klammer: lernt'), findsOneWidget);

      await tester.tap(find.text('تَقْسِيمُ الْحُقُولِ (Felder)'));
      await tester.pumpAndSettle();

      expect(controller.state.showSlotBreakdown, isFalse);
      expect(find.textContaining('Linke Klammer: lernt'), findsNothing);
    });
  });
}
