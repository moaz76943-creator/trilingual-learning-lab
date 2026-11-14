import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/comprehension_cloze/controllers/comprehension_cloze_controller.dart';
import 'package:trilingual_learning_lab/features/comprehension_cloze/data/comprehension_cloze_repository.dart';
import 'package:trilingual_learning_lab/features/comprehension_cloze/models/comprehension_cloze_models.dart';
import 'package:trilingual_learning_lab/features/comprehension_cloze/screens/comprehension_cloze_studio_screen.dart';

void main() {
  group('ComprehensionClozeRepository', () {
    const repo = ComprehensionClozeRepository();

    test('covers all 6 PassageDomain values with trilingual passages', () {
      final passages = repo.getPassages();
      expect(passages.length, 6);
      for (final domain in PassageDomain.values) {
        expect(passages.any((p) => p.domain == domain), isTrue);
      }
      for (final p in passages) {
        expect(p.bodyAr, isNotEmpty);
        expect(p.bodyEn, isNotEmpty);
        expect(p.bodyDe, isNotEmpty);
      }
    });

    test('provides valid contextual cloze drills', () {
      final drills = repo.getClozeDrills();
      expect(drills.length, 6);
      for (final d in drills) {
        expect(d.options.length, greaterThanOrEqualTo(3));
        expect(d.correctIndex, inInclusiveRange(0, d.options.length - 1));
      }
    });
  });

  group('ComprehensionClozeController', () {
    test('filters by domain and search query', () {
      final controller = ComprehensionClozeController();
      expect(controller.state.filteredPassages.length, 6);

      controller.selectDomain(PassageDomain.scientificHeritage);
      expect(controller.state.filteredPassages.length, 1);
      expect(
        controller.state.filteredPassages.first.bodyDe,
        contains('Ibn al-Haitham'),
      );

      controller.selectDomain(null);
      controller.updateSearch('Grauwasserrecycling');
      expect(controller.state.filteredPassages.length, 1);
    });

    test('tracks cloze accuracy and resets', () {
      final controller = ComprehensionClozeController();
      final item = controller.state.currentCloze!;
      controller.submitClozeAnswer(item.correctIndex);

      expect(controller.state.answeredCount, 1);
      expect(controller.state.correctCount, 1);
      expect(controller.state.accuracyRatio, 1.0);

      controller.nextCloze();
      expect(controller.state.currentClozeIndex, 1);
      expect(controller.state.selectedOptionIndex, isNull);

      controller.resetCloze();
      expect(controller.state.answeredCount, 0);
      expect(controller.state.correctCount, 0);
      expect(controller.state.currentClozeIndex, 0);
    });
  });

  group('ComprehensionClozeStudioScreen', () {
    testWidgets('renders studio and toggles parallel translations',
        (WidgetTester tester) async {
      final controller = ComprehensionClozeController();
      await tester.pumpWidget(
        MaterialApp(
          home: ComprehensionClozeStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْفَهْمِ الْقِرَائِيِّ وَمَلْءِ الْفَرَاغَاتِ'),
        findsOneWidget,
      );
      expect(find.textContaining('Ibn al-Haitham begründete'), findsOneWidget);

      await tester.tap(find.text('التَّرْجَمَةُ الْمُتَوَازِيَةُ (EN/DE)'));
      await tester.pumpAndSettle();

      expect(controller.state.showParallelTranslations, isFalse);
      expect(find.textContaining('Ibn al-Haitham begründete'), findsNothing);
    });
  });
}
