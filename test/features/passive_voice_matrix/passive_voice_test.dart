import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/passive_voice_matrix/controllers/passive_voice_controller.dart';
import 'package:trilingual_learning_lab/features/passive_voice_matrix/data/passive_voice_repository.dart';
import 'package:trilingual_learning_lab/features/passive_voice_matrix/models/passive_voice_models.dart';
import 'package:trilingual_learning_lab/features/passive_voice_matrix/screens/passive_voice_studio_screen.dart';

void main() {
  group('PassiveVoiceRepository', () {
    const repo = PassiveVoiceRepository();

    test('covers all 6 PassiveConstructionType values', () {
      final units = repo.getUnits();
      expect(units.length, 6);
      for (final type in PassiveConstructionType.values) {
        expect(units.any((u) => u.type == type), isTrue);
      }
      for (final u in units) {
        expect(u.passiveFormAr, isNotEmpty);
        expect(u.passiveFormEn, isNotEmpty);
        expect(u.passiveFormDe, isNotEmpty);
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

  group('PassiveVoiceController', () {
    test('filters by type and search query', () {
      final controller = PassiveVoiceController();
      expect(controller.state.filteredUnits.length, 6);

      controller.selectType(PassiveConstructionType.arabicMajhulVocalization);
      expect(controller.state.filteredUnits.length, 1);
      expect(
        controller.state.filteredUnits.first.passiveFormDe,
        contains('worden'),
      );

      controller.selectType(null);
      controller.updateSearch('sich lassen');
      expect(controller.state.filteredUnits.length, 1);
    });

    test('tracks drill accuracy and resets', () {
      final controller = PassiveVoiceController();
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

  group('PassiveVoiceStudioScreen', () {
    testWidgets('renders studio and toggles active vs passive mode',
        (WidgetTester tester) async {
      final controller = PassiveVoiceController();
      await tester.pumpWidget(
        MaterialApp(
          home: PassiveVoiceStudioScreen(controller: controller),
        ),
      );

      expect(
        find.text('مُخْتَبَرُ الْمَبْنِيِّ لِلْمَجْهُولِ وَوَسَائِطِ الْحَدَثِ'),
        findsOneWidget,
      );
      expect(find.textContaining('wird um acht Uhr geöffnet'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(controller.state.showPassiveTransformation, isFalse);
      expect(find.textContaining('Der Bibliothekar öffnet'), findsOneWidget);
    });
  });
}
