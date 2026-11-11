import 'package:flutter/foundation.dart';
import '../../../../core/audio/phonetic_synthesis_engine.dart';

enum ReaderThemeMode {
  parchment, // Warm heritage amber/cream
  darkSlate, // Midnight deep contrast
  cleanWhite, // Modern daylight ivory
}

/// A parsed sentence unit within a long-form article.
class ReaderSentenceChunk {
  final int index;
  final String textAr;
  final String textDe;
  final String textEn;

  const ReaderSentenceChunk({
    required this.index,
    required this.textAr,
    required this.textDe,
    required this.textEn,
  });
}

/// Gloss lookup card data for a tapped word.
class WordGlossData {
  final String tappedWord;
  final String languageCode;
  final String ipaPhonetics;
  final String translationDe;
  final String translationEn;
  final String? rootAr;

  const WordGlossData({
    required this.tappedWord,
    required this.languageCode,
    required this.ipaPhonetics,
    required this.translationDe,
    required this.translationEn,
    this.rootAr,
  });
}

/// Controller governing the interactive trilingual reading studio.
class ReaderSessionController extends ChangeNotifier {
  final String articleId;
  final String titleAr;
  final String titleDe;
  final String titleEn;
  final List<ReaderSentenceChunk> _sentences = [];

  int _activeSentenceIndex = 0;
  bool _isNarrationPlaying = false;
  ReaderThemeMode _themeMode = ReaderThemeMode.parchment;
  double _fontScale = 1.0; // 0.8x to 1.5x
  WordGlossData? _activeWordGloss;

  ReaderSessionController({
    required this.articleId,
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
    required List<ReaderSentenceChunk> sentences,
    int initialSentenceIndex = 0,
    ReaderThemeMode initialTheme = ReaderThemeMode.parchment,
  })  : _themeMode = initialTheme,
        _activeSentenceIndex = initialSentenceIndex {
    _sentences.addAll(sentences);
  }

  List<ReaderSentenceChunk> get sentences => List.unmodifiable(_sentences);
  int get activeSentenceIndex => _activeSentenceIndex;
  bool get isNarrationPlaying => _isNarrationPlaying;
  ReaderThemeMode get themeMode => _themeMode;
  double get fontScale => _fontScale;
  WordGlossData? get activeWordGloss => _activeWordGloss;
  int get totalSentences => _sentences.length;

  ReaderSentenceChunk? get currentSentence {
    if (_sentences.isEmpty || _activeSentenceIndex >= _sentences.length) return null;
    return _sentences[_activeSentenceIndex];
  }

  double get readingProgressPercentage {
    if (_sentences.isEmpty) return 0.0;
    return ((_activeSentenceIndex + 1) / _sentences.length) * 100.0;
  }

  /// Sets active sentence index.
  void selectSentence(int index) {
    if (index >= 0 && index < _sentences.length && _activeSentenceIndex != index) {
      _activeSentenceIndex = index;
      notifyListeners();
    }
  }

  /// Toggles synchronized audio narration.
  void toggleNarration() {
    _isNarrationPlaying = !_isNarrationPlaying;
    notifyListeners();
  }

  /// Advances to next sentence.
  bool nextSentence() {
    if (_activeSentenceIndex < _sentences.length - 1) {
      _activeSentenceIndex++;
      notifyListeners();
      return true;
    }
    _isNarrationPlaying = false;
    notifyListeners();
    return false;
  }

  /// Returns to previous sentence.
  bool previousSentence() {
    if (_activeSentenceIndex > 0) {
      _activeSentenceIndex--;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Sets visual theme.
  void setThemeMode(ReaderThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  /// Adjusts reading font scale.
  void setFontScale(double scale) {
    final clamped = scale.clamp(0.8, 1.5);
    if (_fontScale != clamped) {
      _fontScale = clamped;
      notifyListeners();
    }
  }

  /// Looks up instant lexical gloss for a tapped word.
  void lookupWordGloss(String word, String languageCode) {
    final clean = word.replaceAll(RegExp(r'[^\w\u0600-\u06FF]+'), '').trim();
    if (clean.isEmpty) return;

    final phonetics = PhoneticSynthesisEngine.transcribeArabic(clean);

    _activeWordGloss = WordGlossData(
      tappedWord: clean,
      languageCode: languageCode,
      ipaPhonetics: phonetics.ipa,
      translationDe: 'Wortbedeutung / Übersetzung',
      translationEn: 'Lexical meaning / translation',
      rootAr: languageCode == 'ar' ? 'ف - ع - ل' : null,
    );

    notifyListeners();
  }

  /// Clears active gloss popup.
  void clearGloss() {
    _activeWordGloss = null;
    notifyListeners();
  }
}
