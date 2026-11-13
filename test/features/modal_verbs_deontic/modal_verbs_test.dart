import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/modal_verbs_deontic/controllers/modal_verbs_controller.dart';
import 'package:trilingual_learning_lab/features/modal_verbs_deontic/data/modal_verbs_repository.dart';
import 'package:trilingual_learning_lab/features/modal_verbs_deontic/models/modal_verbs_models.dart';
import 'package:trilingual_learning_lab/features/modal_verbs_deontic/screens/modal_verbs_studio_screen.dart';

void main() {
  group('ModalVerbsRepository', () {
    const repo = ModalVerbsRepository();

    test('covers all 6 ModalAxisCategory values', () {
      final units = repo.getUnits();
      expect(units.length, 6);
      for (final axis in ModalAxisCategory.values) {
        expect(units.any((u) => u.axis == axis), isTrue);
      }
      for (final u in units) {
        expect(u.deonticOrBaseAr, isNotEmpty);
        expect(u.deonticOrBaseEn, isNotEmpty);
        expect(u.deonticOrBaseDe, isNotEmpty);
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

  group('ModalVerbsController', () {
    test('filters by axis and search query', () {
      final controller = ModalVerbsController();
      expect(controller.state.filteredUnits.length, 6);

      controller.selectAxis(ModalAxisCategory.negationAsymmetry);
      expect(controller.state.filteredUnits.length, 1);
      expect(
        controller.state.filteredUnits.first.deonticOrBaseDe,
        contains('darf'),
      );

      controller.selectAxis(null);
      controller.updateSearch('Ersatzinfinitiv');
      expect(controller.state.filteredUnits.length, 1);
    });

    test('tracks drill mastery ratio and resets', () {
      final controller = ModalVerbsController();
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

  group('ModalVerbsStudioScreen', () {
    testWidgets('renders studio and toggles contrastive form',
        (WidgetTester tester) async {
      final controller = ModalVerbsController();
      await tester.pumpWidget(
        MaterialApp(
          home: ModalVerbsStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ أَفْعَالِ الْوُجُوبِ وَالِاحْتِمَالِ وَالْإِذْنِ'),
        findsOneWidget,
      );
      expect(find.textContaining('sein Licht brennt'), findsOneWidget);

      await tester.tap(find.text('الصِّيغَةُ الْمُقَابِلَةُ (Epistemic)'));
      await tester.pumpAndSettle();

      expect(controller.state.showContrastiveForm, isFalse);
      expect(find.textContaining('sein Licht brennt'), findsNothing);
    });
  });
}
