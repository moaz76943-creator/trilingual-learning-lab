import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/interrogative_syntax/controllers/interrogative_syntax_controller.dart';
import 'package:trilingual_learning_lab/features/interrogative_syntax/data/interrogative_syntax_repository.dart';
import 'package:trilingual_learning_lab/features/interrogative_syntax/models/interrogative_syntax_models.dart';
import 'package:trilingual_learning_lab/features/interrogative_syntax/screens/interrogative_syntax_studio_screen.dart';

void main() {
  group('InterrogativeSyntaxRepository', () {
    const repo = InterrogativeSyntaxRepository();

    test('covers all 6 InterrogativeCategory values with trilingual units', () {
      final units = repo.getUnits();
      expect(units.length, 6);
      for (final cat in InterrogativeCategory.values) {
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

  group('InterrogativeSyntaxController', () {
    test('filters by category and search query', () {
      final controller = InterrogativeSyntaxController();
      expect(controller.state.filteredUnits.length, 6);

      controller.selectCategory(InterrogativeCategory.negativeQuestionsBalaDoch);
      expect(controller.state.filteredUnits.length, 1);
      expect(
        controller.state.filteredUnits.first.exampleDe,
        contains('Doch'),
      );

      controller.selectCategory(null);
      controller.updateSearch('Wohin');
      expect(controller.state.filteredUnits.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = InterrogativeSyntaxController();
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

  group('InterrogativeSyntaxStudioScreen', () {
    testWidgets('renders studio and toggles rules',
        (WidgetTester tester) async {
      final controller = InterrogativeSyntaxController();
      await tester.pumpWidget(
        MaterialApp(
          home: InterrogativeSyntaxStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الِاسْتِفْهَامِ وَالتَّصْدِيقِ وَالتَّصَوُّرِ'),
        findsOneWidget,
      );
      expect(find.textContaining('Doch, ich habe'), findsOneWidget);

      await tester.tap(find.text('الشَّرْحُ وَالتَّحْلِيلُ'));
      await tester.pumpAndSettle();

      expect(controller.state.showRules, isFalse);
    });
  });
}
