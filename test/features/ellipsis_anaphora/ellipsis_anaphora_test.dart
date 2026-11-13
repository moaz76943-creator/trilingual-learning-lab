import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/ellipsis_anaphora/controllers/ellipsis_anaphora_controller.dart';
import 'package:trilingual_learning_lab/features/ellipsis_anaphora/data/ellipsis_anaphora_repository.dart';
import 'package:trilingual_learning_lab/features/ellipsis_anaphora/models/ellipsis_anaphora_models.dart';
import 'package:trilingual_learning_lab/features/ellipsis_anaphora/screens/ellipsis_anaphora_studio_screen.dart';

void main() {
  group('EllipsisAnaphoraRepository', () {
    const repo = EllipsisAnaphoraRepository();

    test('covers all 6 EllipsisPhenomenonType categories', () {
      final studies = repo.getCaseStudies();
      expect(studies.length, 6);
      for (final type in EllipsisPhenomenonType.values) {
        expect(studies.any((s) => s.type == type), isTrue);
      }
      for (final s in studies) {
        expect(s.surfaceAr, isNotEmpty);
        expect(s.recoveredAr, isNotEmpty);
        expect(s.surfaceEn, isNotEmpty);
        expect(s.recoveredEn, isNotEmpty);
        expect(s.surfaceDe, isNotEmpty);
        expect(s.recoveredDe, isNotEmpty);
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

  group('EllipsisAnaphoraController', () {
    test('filters by type and search query across languages', () {
      final controller = EllipsisAnaphoraController();
      expect(controller.state.filteredCases.length, 6);

      controller.selectType(EllipsisPhenomenonType.sluicing);
      expect(controller.state.filteredCases.length, 1);
      expect(controller.state.filteredCases.first.surfaceDe, contains('warum'));

      controller.selectType(null);
      controller.setSearchQuery('Ergänzungsstrich');
      expect(controller.state.filteredCases.length, 1);
    });

    test('handles drill scoring and reset', () {
      final controller = EllipsisAnaphoraController();
      final q = controller.state.currentDrill!;
      controller.answerDrill(q.correctIndex);

      expect(controller.state.correctCount, 1);
      expect(controller.state.totalAnswered, 1);
      expect(controller.state.accuracy, 1.0);

      controller.nextDrill();
      expect(controller.state.currentDrillIndex, 1);
      expect(controller.state.selectedOptionIndex, isNull);

      controller.resetDrills();
      expect(controller.state.correctCount, 0);
      expect(controller.state.totalAnswered, 0);
      expect(controller.state.currentDrillIndex, 0);
    });
  });

  group('EllipsisAnaphoraStudioScreen', () {
    testWidgets('toggles between surface elided and recovered full forms',
        (WidgetTester tester) async {
      final controller = EllipsisAnaphoraController();
      await tester.pumpWidget(
        MaterialApp(
          home: EllipsisAnaphoraStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْحَذْفِ وَالتَّقْدِيرِ وَالْإِحَالَةِ'),
        findsOneWidget,
      );
      expect(find.textContaining('Amina [—]'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(find.textContaining('Amina wrote a linguistic paper'), findsOneWidget);
    });
  });
}
