import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/imperative_requests/controllers/imperative_requests_controller.dart';
import 'package:trilingual_learning_lab/features/imperative_requests/data/imperative_requests_repository.dart';
import 'package:trilingual_learning_lab/features/imperative_requests/models/imperative_requests_models.dart';
import 'package:trilingual_learning_lab/features/imperative_requests/screens/imperative_requests_studio_screen.dart';

void main() {
  group('ImperativeRequestsRepository', () {
    const repo = ImperativeRequestsRepository();

    test('covers all 6 ImperativeCategory values with trilingual units', () {
      final units = repo.getUnits();
      expect(units.length, 6);
      for (final cat in ImperativeCategory.values) {
        expect(units.any((u) => u.category == cat), isTrue);
      }
      for (final u in units) {
        expect(u.exampleAr, isNotEmpty);
        expect(u.exampleEn, isNotEmpty);
        expect(u.exampleDe, isNotEmpty);
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

  group('ImperativeRequestsController', () {
    test('filters by category and search query', () {
      final controller = ImperativeRequestsController();
      expect(controller.state.filteredUnits.length, 6);

      controller.selectCategory(ImperativeCategory.hollowDefectiveSeparable);
      expect(controller.state.filteredUnits.length, 1);
      expect(
        controller.state.filteredUnits.first.exampleDe,
        contains('Sprich die Wahrheit'),
      );

      controller.selectCategory(null);
      controller.updateSearch('Könnten Sie');
      expect(controller.state.filteredUnits.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = ImperativeRequestsController();
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

  group('ImperativeRequestsStudioScreen', () {
    testWidgets('renders studio and toggles rules',
        (WidgetTester tester) async {
      final controller = ImperativeRequestsController();
      await tester.pumpWidget(
        MaterialApp(
          home: ImperativeRequestsStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْأَمْرِ وَالنَّهْيِ وَالطَّلَبِ الْمُؤَدَّبِ'),
        findsOneWidget,
      );
      expect(find.textContaining('Schreib die Zusammenfassung'), findsOneWidget);

      await tester.tap(find.text('الشَّرْحُ وَالتَّحْلِيلُ'));
      await tester.pumpAndSettle();

      expect(controller.state.showRules, isFalse);
    });
  });
}
