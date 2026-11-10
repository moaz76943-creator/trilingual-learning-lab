import 'package:flutter/foundation.dart';
import '../../domain/services/quiz_evaluator_engine.dart';

enum QuizSessionState {
  initial,
  answering,
  evaluated,
  completed,
}

/// Controller governing the live interactive quiz examination flow.
class QuizSessionController extends ChangeNotifier {
  final List<QuizQuestion> _questions;
  int _currentIndex = 0;
  String? _selectedOption;
  QuizEvaluationResult? _lastResult;
  final List<QuizEvaluationResult> _results = [];
  QuizSessionState _state = QuizSessionState.initial;

  QuizSessionController({required List<QuizQuestion> questions})
      : _questions = List.unmodifiable(questions);

  QuizSessionState get state => _state;
  int get currentIndex => _currentIndex;
  int get totalQuestions => _questions.length;
  String? get selectedOption => _selectedOption;
  QuizEvaluationResult? get lastResult => _lastResult;
  List<QuizEvaluationResult> get results => List.unmodifiable(_results);

  QuizQuestion? get currentQuestion {
    if (_questions.isEmpty || _currentIndex >= _questions.length) return null;
    return _questions[_currentIndex];
  }

  int get currentScore {
    return _results.fold(0, (sum, r) => sum + r.scoreDelta);
  }

  double get scorePercentage {
    return QuizEvaluatorEngine.calculateSessionScore(_results);
  }

  double get progressPercentage {
    if (_questions.isEmpty) return 0.0;
    return ((_currentIndex) / _questions.length) * 100.0;
  }

  /// Starts the quiz session.
  void start() {
    if (_questions.isEmpty) return;
    _currentIndex = 0;
    _selectedOption = null;
    _lastResult = null;
    _results.clear();
    _state = QuizSessionState.answering;
    notifyListeners();
  }

  /// Selects an option tile prior to submission.
  void selectOption(String option) {
    if (_state != QuizSessionState.answering) return;
    _selectedOption = option;
    notifyListeners();
  }

  /// Submits the selected answer and evaluates correctness.
  void submitAnswer() {
    if (_state != QuizSessionState.answering || _selectedOption == null || currentQuestion == null) {
      return;
    }

    final question = currentQuestion!;
    final result = QuizEvaluatorEngine.evaluate(
      question: question,
      selectedAnswer: _selectedOption!,
    );

    _lastResult = result;
    _results.add(result);
    _state = QuizSessionState.evaluated;
    notifyListeners();
  }

  /// Advances to the next question or finishes the exam.
  void nextQuestion() {
    if (_state != QuizSessionState.evaluated) return;

    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      _selectedOption = null;
      _lastResult = null;
      _state = QuizSessionState.answering;
    } else {
      _state = QuizSessionState.completed;
    }
    notifyListeners();
  }
}
