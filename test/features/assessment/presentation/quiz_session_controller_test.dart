import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/assessment/domain/services/quiz_evaluator_engine.dart';
import 'package:trilingual_learning_lab/features/assessment/presentation/controllers/quiz_session_controller.dart';

void main() {
  group('QuizSessionController Live Examination Lifecycle', () {
    late List<QuizQuestion> sampleQuestions;
    late QuizSessionController controller;

    setUp(() {
      sampleQuestions = [
        const QuizQuestion(
          id: 'q1',
          prompt: 'الأَسْطُرْلاَبُ',
          correctAnswer: 'Das Astrolabium',
          options: ['Das Astrolabium', 'Die Sonnenuhr', 'Das Wasserrad'],
          type: QuizQuestionType.multipleChoice,
          explanationAr: 'آلاَةٌ فَلَكِيَّةٌ نُحَاسِيَّةٌ حِسَابِيَّةٌ.',
          explanationDe: 'Ein astronomisches Recheninstrument.',
          explanationEn: 'An astronomical computing instrument.',
        ),
        const QuizQuestion(
          id: 'q2',
          prompt: 'العِضَادَةُ',
          correctAnswer: 'Die Alhidade',
          options: ['Die Alhidade', 'Die Rete', 'Die Mutter'],
          type: QuizQuestionType.multipleChoice,
          explanationAr: 'مِسْطَرَةُ التَّصْوِيبِ الدَّوَّارَةُ.',
          explanationDe: 'Die drehbare Visierschiene.',
          explanationEn: 'The rotating sighting rule.',
        ),
      ];

      controller = QuizSessionController(questions: sampleQuestions);
    });

    test('Initializes into answering state upon start()', () {
      expect(controller.state, equals(QuizSessionState.initial));
      controller.start();

      expect(controller.state, equals(QuizSessionState.answering));
      expect(controller.currentIndex, equals(0));
      expect(controller.totalQuestions, equals(2));
      expect(controller.selectedOption, isNull);
    });

    test('Selects option and submits correct answer with positive score delta', () {
      controller.start();
      controller.selectOption('Das Astrolabium');
      expect(controller.selectedOption, equals('Das Astrolabium'));

      controller.submitAnswer();

      expect(controller.state, equals(QuizSessionState.evaluated));
      expect(controller.lastResult, isNotNull);
      expect(controller.lastResult!.isCorrect, isTrue);
      expect(controller.currentScore, equals(10));
    });

    test('Submits incorrect answer with zero score delta and advances to completion', () {
      controller.start();

      // Question 1: Correct
      controller.selectOption('Das Astrolabium');
      controller.submitAnswer();
      controller.nextQuestion();

      expect(controller.currentIndex, equals(1));
      expect(controller.state, equals(QuizSessionState.answering));

      // Question 2: Incorrect
      controller.selectOption('Die Rete'); // Wrong
      controller.submitAnswer();

      expect(controller.lastResult!.isCorrect, isFalse);
      expect(controller.currentScore, equals(10));

      controller.nextQuestion();
      expect(controller.state, equals(QuizSessionState.completed));
      expect(controller.scorePercentage, equals(50.0)); // 1 out of 2 = 50%
    });
  });
}
