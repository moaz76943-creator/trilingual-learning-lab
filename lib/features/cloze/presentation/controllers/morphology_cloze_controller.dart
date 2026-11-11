import 'package:flutter/foundation.dart';
import '../../../../core/linguistics/arabic_diacritics_service.dart';

enum ClozeEvaluationTier {
  exact,      // 100%: Matches target word verbatim with diacritics
  normalized, // 90%: Correct base word, minor diacritic/case difference
  rootMatch,  // 60%: Correct root radicals, incorrect grammatical template
  mismatched, // 0%: Incorrect word
}

/// A trilingual sentence cloze exercise challenge.
class MorphologyClozeExercise {
  final String id;
  final String sentenceArBefore;
  final String targetWordAr; // e.g. "فَرَّغَ"
  final String sentenceArAfter;
  final String rootAr;       // e.g. "ف - ر - غ"
  final String templateAr;   // e.g. "فَعَّلَ (التكثير/التعدية)"
  final String translationDe;
  final String targetWordDe; // e.g. "feilte aus"
  final String translationEn;
  final String targetWordEn; // e.g. "pierced"

  const MorphologyClozeExercise({
    required this.id,
    required this.sentenceArBefore,
    required this.targetWordAr,
    required this.sentenceArAfter,
    required this.rootAr,
    required this.templateAr,
    required this.translationDe,
    required this.targetWordDe,
    required this.translationEn,
    required this.targetWordEn,
  });
}

/// Evaluation result for a cloze attempt.
class ClozeEvaluationResult {
  final ClozeEvaluationTier tier;
  final double scoreEarned;
  final String feedbackAr;
  final String feedbackDe;
  final String feedbackEn;

  const ClozeEvaluationResult({
    required this.tier,
    required this.scoreEarned,
    required this.feedbackAr,
    required this.feedbackDe,
    required this.feedbackEn,
  });
}

/// Controller governing the interactive morphology cloze exercise flow.
class MorphologyClozeController extends ChangeNotifier {
  final List<MorphologyClozeExercise> _exercises;
  int _currentIndex = 0;
  String _userAnswer = '';
  ClozeEvaluationResult? _lastResult;
  bool _showRootHint = false;
  double _totalScore = 0.0;
  int _completedCount = 0;

  MorphologyClozeController({
    required List<MorphologyClozeExercise> exercises,
  }) : _exercises = List.unmodifiable(exercises);

  int get currentIndex => _currentIndex;
  int get totalExercises => _exercises.length;
  String get userAnswer => _userAnswer;
  ClozeEvaluationResult? get lastResult => _lastResult;
  bool get showRootHint => _showRootHint;
  double get totalScore => _totalScore;
  int get completedCount => _completedCount;
  bool get isEvaluated => _lastResult != null;

  MorphologyClozeExercise? get currentExercise {
    if (_exercises.isEmpty || _currentIndex >= _exercises.length) return null;
    return _exercises[_currentIndex];
  }

  void setUserAnswer(String answer) {
    _userAnswer = answer;
    _lastResult = null; // Clear evaluation on edit
    notifyListeners();
  }

  void toggleRootHint() {
    _showRootHint = !_showRootHint;
    notifyListeners();
  }

  /// Evaluates learner's cloze submission using multi-tier morphological matching.
  void submitAnswer() {
    final exercise = currentExercise;
    if (exercise == null || _userAnswer.trim().isEmpty) return;

    final rawInput = _userAnswer.trim();
    final target = exercise.targetWordAr.trim();

    // 1. Exact match
    if (rawInput == target) {
      _lastResult = const ClozeEvaluationResult(
        tier: ClozeEvaluationTier.exact,
        scoreEarned: 10.0,
        feedbackAr: 'إِجَابَةٌ نَمُوذَجِيَّةٌ تَامَّةُ الضَّبْطِ وَالتَّشْكِيلِ!',
        feedbackDe: 'Perfekte morphologische Antwort mit vollständiger Vokalisierung!',
        feedbackEn: 'Perfect morphological answer with complete vocalization!',
      );
    } else {
      // 2. Normalized match (diacritic-tolerant)
      final normInput = ArabicDiacriticsService.normalizeArabic(rawInput);
      final normTarget = ArabicDiacriticsService.normalizeArabic(target);

      if (normInput == normTarget) {
        _lastResult = const ClozeEvaluationResult(
          tier: ClozeEvaluationTier.normalized,
          scoreEarned: 9.0,
          feedbackAr: 'صَحِيحٌ! الكَلِمَةُ صَحِيحَةٌ مَعَ فَرْقٍ طَفِيفٍ فِي التَّشْكِيلِ.',
          feedbackDe: 'Richtig! Das Stammwort stimmt, geringe Abweichung in der Vokalisierung.',
          feedbackEn: 'Correct! The stem word matches, minor difference in diacritics.',
        );
      } else {
        // 3. Root check
        final cleanRootLetters = exercise.rootAr.replaceAll(RegExp(r'[^\w\u0600-\u06FF]'), '');
        bool containsAllRadicals = true;
        for (final radical in cleanRootLetters.split('')) {
          if (!normInput.contains(radical)) {
            containsAllRadicals = false;
            break;
          }
        }

        if (containsAllRadicals && normInput.length >= 3) {
          _lastResult = ClozeEvaluationResult(
            tier: ClozeEvaluationTier.rootMatch,
            scoreEarned: 6.0,
            feedbackAr: 'الجَذْرُ صَحِيحٌ (${exercise.rootAr})، لَكِنَّ الوَزْنَ المَطْلُوبَ هُوَ: ${exercise.templateAr}.',
            feedbackDe: 'Richtige Wurzel (${exercise.rootAr}), aber das geforderte Schema ist ${exercise.templateAr}.',
            feedbackEn: 'Correct root (${exercise.rootAr}), but the required template is ${exercise.templateAr}.',
          );
        } else {
          // 4. Mismatch
          _lastResult = ClozeEvaluationResult(
            tier: ClozeEvaluationTier.mismatched,
            scoreEarned: 0.0,
            feedbackAr: 'إِجَابَةٌ غَيْرُ صَحِيحَةٍ. الكَلِمَةُ المَطْلُوبَةُ: $target.',
            feedbackDe: 'Leider falsch. Das gesuchte Wort ist: $target.',
            feedbackEn: 'Incorrect. The target word is: $target.',
          );
        }
      }
    }

    _totalScore += _lastResult!.scoreEarned;
    _completedCount++;
    notifyListeners();
  }

  void nextExercise() {
    if (_currentIndex < _exercises.length - 1) {
      _currentIndex++;
      _userAnswer = '';
      _lastResult = null;
      _showRootHint = false;
      notifyListeners();
    }
  }

  void reset() {
    _currentIndex = 0;
    _userAnswer = '';
    _lastResult = null;
    _showRootHint = false;
    _totalScore = 0.0;
    _completedCount = 0;
    notifyListeners();
  }
}
