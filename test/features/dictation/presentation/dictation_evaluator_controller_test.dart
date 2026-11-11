import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/dictation/presentation/controllers/dictation_evaluator_controller.dart';

void main() {
  group('DictationEvaluatorController Orthography Scoring', () {
    late DictationEvaluatorController controller;

    setUp(() {
      controller = DictationEvaluatorController(
        referenceSentence: 'صِنَاعَةُ الأَسْطُرْلاَبِ النُّحَاسِيِّ',
        languageCode: 'ar',
      );
    });

    test('Initializes with default unevaluated state', () {
      expect(controller.isPlaying, isFalse);
      expect(controller.isSlowSpeed, isFalse);
      expect(controller.typedInput, isEmpty);
      expect(controller.lastResult, isNull);
      expect(controller.isEvaluated, isFalse);
    });

    test('Evaluates exact matching sentence scoring 100%', () {
      controller.setTypedInput('صِنَاعَةُ الأَسْطُرْلاَبِ النُّحَاسِيِّ');
      controller.evaluate();

      expect(controller.isEvaluated, isTrue);
      final r = controller.lastResult!;
      expect(r.isPerfect, isTrue);
      expect(r.scorePercentage, equals(100.0));
      expect(r.matchedWords, equals(3));
      expect(r.wordDiffs.every((d) => d.status == WordMatchStatus.exact), isTrue);
    });

    test('Awards partial credit for base letters without Tashkeel', () {
      // Type without diacritics
      controller.setTypedInput('صناعة الاسطرلاب النحاسي');
      controller.evaluate();

      final r = controller.lastResult!;
      expect(r.isPerfect, isFalse);
      expect(r.scorePercentage, greaterThanOrEqualTo(70.0));
      expect(r.wordDiffs.every((d) => d.status == WordMatchStatus.partial), isTrue);
    });

    test('Flags mismatched words giving proper diff status', () {
      controller.setTypedInput('صِنَاعَةُ السَّاعَةِ'); // Wrong word
      controller.evaluate();

      final r = controller.lastResult!;
      expect(r.scorePercentage, lessThan(50.0));
      expect(r.wordDiffs[0].status, equals(WordMatchStatus.exact));
      expect(r.wordDiffs[1].status, equals(WordMatchStatus.mismatched));
    });

    test('Toggles slow speed and resets state', () {
      expect(controller.isSlowSpeed, isFalse);
      controller.toggleSlowSpeed();
      expect(controller.isSlowSpeed, isTrue);

      controller.setTypedInput('test');
      controller.reset();
      expect(controller.typedInput, isEmpty);
      expect(controller.lastResult, isNull);
    });
  });
}
