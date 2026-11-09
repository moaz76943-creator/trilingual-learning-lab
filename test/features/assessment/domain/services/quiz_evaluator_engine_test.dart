import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/assessment/domain/services/quiz_evaluator_engine.dart';

void main() {
  group('QuizEvaluatorEngine Assessment Mechanics', () {
    late QuizQuestion sampleQuestion;

    setUp(() {
      sampleQuestion = QuizEvaluatorEngine.createVocabularyQuestion(
        id: 'q_astrolabe_001',
        promptTerm: 'الأَسْطُرْلاَبُ النُّحَاسِيُّ',
        correctTranslation: 'Das Messingastrolabium',
        distractors: [
          'Die Sonnenuhr',
          'Das Wasserrad',
          'Die Papiermühle',
        ],
        explanationAr: 'الأَسْطُرْلاَبُ هُوَ آلاَةٌ فَلَكِيَّةٌ نُحَاسِيَّةٌ لِقِيَاسِ حَرَكَةِ النُّجُومِ.',
        explanationDe: 'Das Astrolabium ist ein historisches astronomisches Messgerät.',
        explanationEn: 'The astrolabe is a historic astronomical computing instrument.',
      );
    });

    test('Creates question containing correct answer and all distractors', () {
      expect(sampleQuestion.options.length, equals(4));
      expect(sampleQuestion.options.contains('Das Messingastrolabium'), isTrue);
      expect(sampleQuestion.options.contains('Die Sonnenuhr'), isTrue);
      expect(sampleQuestion.correctAnswer, equals('Das Messingastrolabium'));
    });

    test('Evaluates correct answer giving positive score delta', () {
      final result = QuizEvaluatorEngine.evaluate(
        question: sampleQuestion,
        selectedAnswer: 'Das Messingastrolabium',
      );

      expect(result.isCorrect, isTrue);
      expect(result.scoreDelta, equals(10));
      expect(result.selectedAnswer, equals(result.correctAnswer));
    });

    test('Evaluates incorrect answer giving zero score delta', () {
      final result = QuizEvaluatorEngine.evaluate(
        question: sampleQuestion,
        selectedAnswer: 'Die Sonnenuhr',
      );

      expect(result.isCorrect, isFalse);
      expect(result.scoreDelta, equals(0));
      expect(result.correctAnswer, equals('Das Messingastrolabium'));
    });

    test('Calculates overall session score percentage accurately', () {
      final results = [
        const QuizEvaluationResult(
          questionId: 'q1',
          isCorrect: true,
          selectedAnswer: 'A',
          correctAnswer: 'A',
          scoreDelta: 10,
        ),
        const QuizEvaluationResult(
          questionId: 'q2',
          isCorrect: true,
          selectedAnswer: 'B',
          correctAnswer: 'B',
          scoreDelta: 10,
        ),
        const QuizEvaluationResult(
          questionId: 'q3',
          isCorrect: false,
          selectedAnswer: 'C',
          correctAnswer: 'D',
          scoreDelta: 0,
        ),
        const QuizEvaluationResult(
          questionId: 'q4',
          isCorrect: true,
          selectedAnswer: 'E',
          correctAnswer: 'E',
          scoreDelta: 10,
        ),
      ];

      final score = QuizEvaluatorEngine.calculateSessionScore(results);
      expect(score, equals(75.0)); // 3 out of 4 = 75%
    });
  });
}
