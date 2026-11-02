import 'package:flutter/foundation.dart';

class QuizQuestion {
  final String conceptId;
  final String promptArabic;
  final String correctAnswer;
  final List<String> choices;

  const QuizQuestion({
    required this.conceptId,
    required this.promptArabic,
    required this.correctAnswer,
    required this.choices,
  });
}

class QuizSessionController extends ChangeNotifier {
  final List<QuizQuestion> questions;
  int _currentIndex = 0;
  int _score = 0;
  int _streak = 0;
  final List<String> _incorrectConceptIds = [];

  QuizSessionController({required this.questions});

  int get currentIndex => _currentIndex;
  int get score => _score;
  int get streak => _streak;
  bool get isCompleted => _currentIndex >= questions.length;
  QuizQuestion? get currentQuestion => isCompleted ? null : questions[_currentIndex];
  List<String> get incorrectConcepts => List.unmodifiable(_incorrectConceptIds);

  bool submitAnswer(String selectedChoice) {
    if (isCompleted) return false;
    final isCorrect = currentQuestion!.correctAnswer == selectedChoice;

    if (isCorrect) {
      _score += 10 + (_streak * 2);
      _streak += 1;
    } else {
      _streak = 0;
      _incorrectConceptIds.add(currentQuestion!.conceptId);
    }

    _currentIndex += 1;
    notifyListeners();
    return isCorrect;
  }
}
