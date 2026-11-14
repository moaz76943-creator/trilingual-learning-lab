import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/nominal_agreement_declension/controllers/nominal_agreement_controller.dart';
import 'package:trilingual_learning_lab/features/nominal_agreement_declension/data/nominal_agreement_repository.dart';
import 'package:trilingual_learning_lab/features/nominal_agreement_declension/models/nominal_agreement_models.dart';
import 'package:trilingual_learning_lab/features/nominal_agreement_declension/screens/nominal_agreement_studio_screen.dart';

void main() {
  group('NominalAgreementRepository', () {
    const repo = NominalAgreementRepository();

    test('covers all 6 DeclensionAgreementAxis values', () {
      final lessons = repo.getLessons();
      expect(lessons.length, 6);
      for (final axis in DeclensionAgreementAxis.values) {
        expect(lessons.any((l) => l.axis == axis), isTrue);
      }
      for (final l in lessons) {
        expect(l.exampleAr, isNotEmpty);
        expect(l.exampleEn, isNotEmpty);
        expect(l.exampleDe, isNotEmpty);
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

  group('NominalAgreementController', () {
    test('filters by axis and search query', () {
      final controller = NominalAgreementController();
      expect(controller.state.filteredLessons.length, 6);

      controller.selectAxis(DeclensionAgreementAxis.weakDefiniteDeclension);
      expect(controller.state.filteredLessons.length, 1);
      expect(
        controller.state.filteredLessons.first.exampleDe,
        contains('neuen Artikel'),
      );

      controller.selectAxis(null);
      controller.updateSearch('Handschriften');
      expect(controller.state.filteredLessons.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = NominalAgreementController();
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

  group('NominalAgreementStudioScreen', () {
    testWidgets('renders studio and toggles grammar rules',
        (WidgetTester tester) async {
      final controller = NominalAgreementController();
      await tester.pumpWidget(
        MaterialApp(
          home: NominalAgreementStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ النَّعْتِ وَالتَّصْرِيفِ الِاسْمِيِّ وَالتَّعْرِيفِ'),
        findsOneWidget,
      );
      expect(find.textContaining('begutachteten Fachzeitschrift'), findsOneWidget);

      await tester.tap(find.text('الشَّرْحُ النَّحْوِيُّ'));
      await tester.pumpAndSettle();

      expect(controller.state.showRules, isFalse);
    });
  });
}
