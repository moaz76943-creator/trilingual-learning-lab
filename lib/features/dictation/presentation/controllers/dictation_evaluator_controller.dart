import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import '../../../../core/linguistics/arabic_diacritics_service.dart';

enum WordMatchStatus {
  exact,      // Matches perfectly including diacritics and case
  partial,    // Base letters match but diacritics or case differ
  mismatched, // Completely different or missing word
}

/// Diff result for an individual evaluated word.
class WordDiffItem {
  final String referenceWord;
  final String? typedWord;
  final WordMatchStatus status;

  const WordDiffItem({
    required this.referenceWord,
    this.typedWord,
    required this.status,
  });
}

/// Result of complete dictation sentence evaluation.
class DictationEvaluationResult {
  final double scorePercentage;
  final bool isPerfect;
  final List<WordDiffItem> wordDiffs;
  final int totalReferenceWords;
  final int matchedWords;

  const DictationEvaluationResult({
    required this.scorePercentage,
    required this.isPerfect,
    required this.wordDiffs,
    required this.totalReferenceWords,
    required this.matchedWords,
  });
}

/// Controller governing audio dictation sessions and orthographic evaluation.
class DictationEvaluatorController extends ChangeNotifier {
  final String referenceSentence;
  final String languageCode; // 'ar', 'de', 'en'
  bool _isPlaying = false;
  bool _isSlowSpeed = false;
  String _typedInput = '';
  DictationEvaluationResult? _lastResult;

  DictationEvaluatorController({
    required this.referenceSentence,
    required this.languageCode,
  });

  bool get isPlaying => _isPlaying;
  bool get isSlowSpeed => _isSlowSpeed;
  String get typedInput => _typedInput;
  DictationEvaluationResult? get lastResult => _lastResult;
  bool get isEvaluated => _lastResult != null;

  /// Toggles slow playback speed (e.g. 0.75x for clear Tashkeel articulation).
  void toggleSlowSpeed() {
    _isSlowSpeed = !_isSlowSpeed;
    notifyListeners();
  }

  /// Updates learner typed input.
  void setTypedInput(String text) {
    _typedInput = text;
    _lastResult = null; // Reset evaluation on new edit
    notifyListeners();
  }

  /// Simulates audio playback state toggle.
  void togglePlay() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  /// Evaluates typed sentence against reference sentence with detailed diffs.
  void evaluate() {
    final refWords = referenceSentence.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    final typedWords = _typedInput.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();

    final diffs = <WordDiffItem>[];
    int exactMatches = 0;
    int partialMatches = 0;

    final maxWords = math.max(refWords.length, typedWords.length);

    for (var i = 0; i < refWords.length; i++) {
      final ref = refWords[i];
      final typed = i < typedWords.length ? typedWords[i] : null;

      if (typed == null) {
        diffs.add(WordDiffItem(
          referenceWord: ref,
          typedWord: null,
          status: WordMatchStatus.mismatched,
        ));
        continue;
      }

      // Check exact match
      if (ref == typed) {
        diffs.add(WordDiffItem(
          referenceWord: ref,
          typedWord: typed,
          status: WordMatchStatus.exact,
        ));
        exactMatches++;
      } else {
        // Check partial match (diacritic-insensitive or case-insensitive)
        final normRef = ArabicDiacriticsService.normalizeForSearch(ref);
        final normTyped = ArabicDiacriticsService.normalizeForSearch(typed);

        if (normRef == normTyped) {
          diffs.add(WordDiffItem(
            referenceWord: ref,
            typedWord: typed,
            status: WordMatchStatus.partial,
          ));
          partialMatches++;
        } else {
          diffs.add(WordDiffItem(
            referenceWord: ref,
            typedWord: typed,
            status: WordMatchStatus.mismatched,
          ));
        }
      }
    }

    final totalWords = refWords.length;
    final totalEffectiveMatches = exactMatches + (partialMatches * 0.75);
    final score = totalWords > 0
        ? ((totalEffectiveMatches / totalWords) * 100.0).clamp(0.0, 100.0)
        : 0.0;

    _lastResult = DictationEvaluationResult(
      scorePercentage: score,
      isPerfect: score >= 99.0,
      wordDiffs: diffs,
      totalReferenceWords: totalWords,
      matchedWords: exactMatches + partialMatches,
    );

    notifyListeners();
  }

  /// Resets dictation exercise.
  void reset() {
    _typedInput = '';
    _lastResult = null;
    _isPlaying = false;
    notifyListeners();
  }
}
