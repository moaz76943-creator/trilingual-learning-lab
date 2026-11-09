import 'package:flutter/foundation.dart';

enum QuizQuestionType {
  multipleChoice,
  verbCloze,
  translationMatch,
}

/// A structured assessment question.
class QuizQuestion {
  final String id;
  final String prompt;
  final String correctAnswer;
  final List<String> options;
  final QuizQuestionType type;
  final String explanationAr;
  final String explanationDe;
  final String explanationEn;

  const QuizQuestion({
    required this.id,
    required this.prompt,
    required this.correctAnswer,
    required this.options,
    required this.type,
    required this.explanationAr,
    required this.explanationDe,
    required this.explanationEn,
  });
}

/// Evaluation outcome for an answered question.
class QuizEvaluationResult {
  final String questionId;
  final bool isCorrect;
  final String selectedAnswer;
  final String correctAnswer;
  final int scoreDelta;

  const QuizEvaluationResult({
    required this.questionId,
    required this.isCorrect,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.scoreDelta,
  });
}

/// Engine evaluating quiz questions, scoring sessions, and building questions.
class QuizEvaluatorEngine {
  /// Evaluates user's [selectedAnswer] against the [question].
  static QuizEvaluationResult evaluate({
    required QuizQuestion question,
    required String selectedAnswer,
  }) {
    final cleanSelected = selectedAnswer.trim();
    final cleanCorrect = question.correctAnswer.trim();
    final isCorrect = cleanSelected == cleanCorrect;

    return QuizEvaluationResult(
      questionId: question.id,
      isCorrect: isCorrect,
      selectedAnswer: cleanSelected,
      correctAnswer: cleanCorrect,
      scoreDelta: isCorrect ? 10 : 0,
    );
  }

  /// Calculates session score percentage (0.0 to 100.0).
  static double calculateSessionScore(List<QuizEvaluationResult> results) {
    if (results.isEmpty) return 0.0;
    final correctCount = results.where((r) => r.isCorrect).length;
    return (correctCount / results.length) * 100.0;
  }

  /// Factory constructing a multiple-choice vocabulary question with shuffled distractors.
  static QuizQuestion createVocabularyQuestion({
    required String id,
    required String promptTerm,
    required String correctTranslation,
    required List<String> distractors,
    required String explanationAr,
    required String explanationDe,
    required String explanationEn,
  }) {
    final allOptions = <String>[correctTranslation, ...distractors];
    // Deterministic pseudo-shuffle based on question ID length to guarantee option variety
    allOptions.sort((a, b) => (a.length + id.length).compareTo(b.length));

    return QuizQuestion(
      id: id,
      prompt: promptTerm,
      correctAnswer: correctTranslation,
      options: allOptions,
      type: QuizQuestionType.multipleChoice,
      explanationAr: explanationAr,
      explanationDe: explanationDe,
      explanationEn: explanationEn,
    );
  }
}
