import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/cloze/presentation/controllers/morphology_cloze_controller.dart';

void main() {
  group('MorphologyClozeController Multi-Tier Scoring Tests', () {
    late List<MorphologyClozeExercise> sampleExercises;
    late MorphologyClozeController controller;

    setUp(() {
      sampleExercises = [
        const MorphologyClozeExercise(
          id: 'cloze_1',
          sentenceArBefore: 'حَاذِقُ النُّحَاسِ',
          targetWordAr: 'فَرَّغَ',
          sentenceArAfter: 'الصَّفِيحَةَ بِالمِبْرَدِ.',
          rootAr: 'ف - ر - غ',
          templateAr: 'فَعَّلَ',
          translationDe: 'Der Kunsthandwerker feilte die Platte aus.',
          targetWordDe: 'feilte aus',
          translationEn: 'The artisan pierced the plate.',
          targetWordEn: 'pierced',
        ),
      ];

      controller = MorphologyClozeController(exercises: sampleExercises);
    });

    test('Initializes with default state', () {
      expect(controller.currentIndex, equals(0));
      expect(controller.totalExercises, equals(1));
      expect(controller.userAnswer, isEmpty);
      expect(controller.lastResult, isNull);
      expect(controller.isEvaluated, isFalse);
      expect(controller.showRootHint, isFalse);
    });

    test('Evaluates exact match with full 10.0 score', () {
      controller.setUserAnswer('فَرَّغَ');
      controller.submitAnswer();

      expect(controller.isEvaluated, isTrue);
      final r = controller.lastResult!;
      expect(r.tier, equals(ClozeEvaluationTier.exact));
      expect(r.scoreEarned, equals(10.0));
      expect(controller.totalScore, equals(10.0));
    });

    test('Evaluates normalized match without Tashkeel with 9.0 score', () {
      controller.setUserAnswer('فرغ'); // Without shadda/fatha
      controller.submitAnswer();

      final r = controller.lastResult!;
      expect(r.tier, equals(ClozeEvaluationTier.normalized));
      expect(r.scoreEarned, equals(9.0));
    });

    test('Recognizes correct root but wrong template giving partial credit', () {
      controller.setUserAnswer('فارغ'); // Active participle instead of past form II
      controller.submitAnswer();

      final r = controller.lastResult!;
      expect(r.tier, equals(ClozeEvaluationTier.rootMatch));
      expect(r.scoreEarned, equals(6.0));
      expect(r.feedbackAr, contains('ف - ر - غ'));
    });

    test('Rejects mismatched word with zero score', () {
      controller.setUserAnswer('كَبَّرَ'); // Entirely different verb
      controller.submitAnswer();

      final r = controller.lastResult!;
      expect(r.tier, equals(ClozeEvaluationTier.mismatched));
      expect(r.scoreEarned, equals(0.0));
    });

    test('Toggles root hint visibility', () {
      expect(controller.showRootHint, isFalse);
      controller.toggleRootHint();
      expect(controller.showRootHint, isTrue);
    });
  });
}
