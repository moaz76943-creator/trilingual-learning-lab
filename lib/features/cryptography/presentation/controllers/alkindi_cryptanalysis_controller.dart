import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Supported target language for cryptanalytic corpus analysis
enum CryptoLanguage {
  arabic(
    nameAr: 'العَرَبِيَّةُ الفُصْحَى',
    nameDe: 'Klassisches Arabisch',
    nameEn: 'Classical Arabic',
    alphabet: 'ابتثجحخدذرزسشصضطظعغفقكلمنهوي',
    // Normalized unigram frequencies in classical Arabic prose (%):
    // ا (12.2%), ل (11.4%), م (7.4%), ي (6.8%), و (5.9%), ن (5.6%), ه (4.2%), ر (4.1%), ب (3.9%), ت (3.6%), ع (3.3%), ف (2.8%), د (2.6%), ك (2.5%), ق (2.2%), س (2.1%), ح (1.8%), ج (1.4%), ص (1.2%), ش (1.1%), ذ (0.9%), ض (0.8%), خ (0.7%), ز (0.6%), ط (0.6%), ث (0.5%), غ (0.4%), ظ (0.2%)
    frequencies: {
      'ا': 12.2, 'ل': 11.4, 'م': 7.4, 'ي': 6.8, 'و': 5.9,
      'ن': 5.6, 'ه': 4.2, 'ر': 4.1, 'ب': 3.9, 'ت': 3.6,
      'ع': 3.3, 'ف': 2.8, 'د': 2.6, 'ك': 2.5, 'ق': 2.2,
      'س': 2.1, 'ح': 1.8, 'ج': 1.4, 'ص': 1.2, 'ش': 1.1,
      'ذ': 0.9, 'ض': 0.8, 'خ': 0.7, 'ز': 0.6, 'ط': 0.6,
      'ث': 0.5, 'غ': 0.4, 'ظ': 0.2,
    },
  ),
  german(
    nameAr: 'الأَلْمَانِيَّةُ (Deutsch)',
    nameDe: 'Standarddeutsch',
    nameEn: 'Standard German',
    alphabet: 'abcdefghijklmnopqrstuvwxyzäöüß',
    frequencies: {
      'e': 17.4, 'n': 9.8, 'i': 7.6, 's': 7.3, 'r': 7.0,
      'a': 6.5, 't': 6.1, 'd': 5.1, 'h': 4.6, 'u': 4.4,
      'l': 3.4, 'c': 3.1, 'g': 3.0, 'm': 2.5, 'o': 2.5,
      'b': 1.9, 'w': 1.9, 'f': 1.7, 'k': 1.2, 'z': 1.1,
      'p': 0.8, 'v': 0.7, 'ä': 0.6, 'ü': 0.6, 'ö': 0.4,
      'j': 0.3, 'q': 0.1, 'x': 0.1, 'y': 0.1, 'ß': 0.3,
    },
  ),
  english(
    nameAr: 'الإِنْجِلِيزِيَّةُ (English)',
    nameDe: 'Englisch',
    nameEn: 'English',
    alphabet: 'abcdefghijklmnopqrstuvwxyz',
    frequencies: {
      'e': 12.7, 't': 9.1, 'a': 8.2, 'o': 7.5, 'i': 7.0,
      'n': 6.7, 's': 6.3, 'h': 6.1, 'r': 6.0, 'd': 4.3,
      'l': 4.0, 'c': 2.8, 'u': 2.8, 'm': 2.4, 'w': 2.4,
      'f': 2.2, 'g': 2.0, 'y': 2.0, 'p': 1.9, 'b': 1.5,
      'v': 1.0, 'k': 0.8, 'j': 0.15, 'x': 0.15, 'q': 0.1,
      'z': 0.07,
    },
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final String alphabet;
  final Map<String, double> frequencies;

  const CryptoLanguage({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.alphabet,
    required this.frequencies,
  });
}

/// Cryptanalysis State representation
class AlKindiCryptanalysisState {
  final CryptoLanguage language;
  final String rawText;
  final String cipherText;
  final int shiftKey; // For Caesar substitution
  final Map<String, String> substitutionKey; // Custom mapping (from -> to)
  final bool autoDetectBestShift;

  const AlKindiCryptanalysisState({
    required this.language,
    required this.rawText,
    required this.cipherText,
    required this.shiftKey,
    required this.substitutionKey,
    required this.autoDetectBestShift,
  });

  factory AlKindiCryptanalysisState.initial() {
    const defaultRaw = 'الْعِلْمُ صَيْدٌ وَالْكِتَابَةُ قَيْدُهُ قَيِّدْ صُيُودَكَ بِالْحِبَالِ الْوَاثِقَةِ';
    return AlKindiCryptanalysisState(
      language: CryptoLanguage.arabic,
      rawText: defaultRaw,
      cipherText: _applyCaesarShift(defaultRaw, 3, CryptoLanguage.arabic),
      shiftKey: 3,
      substitutionKey: const {},
      autoDetectBestShift: false,
    );
  }

  /// Frequency count of each character in cipherText (ignoring spaces/diacritics)
  Map<String, int> get characterCounts {
    final counts = <String, int>{};
    final alpha = language.alphabet;
    final clean = _normalizeText(cipherText, language);

    for (final char in clean.split('')) {
      if (alpha.contains(char)) {
        counts[char] = (counts[char] ?? 0) + 1;
      }
    }
    return counts;
  }

  /// Total count of recognized alphabetic letters in ciphertext
  int get totalLettersCount {
    return characterCounts.values.fold(0, (sum, count) => sum + count);
  }

  /// Empirical unigram frequencies (% of total letters) in ciphertext
  Map<String, double> get empiricalFrequencies {
    final counts = characterCounts;
    final total = totalLettersCount;
    if (total == 0) return {};

    final freqs = <String, double>{};
    for (final entry in counts.entries) {
      freqs[entry.key] = (entry.value / total) * 100.0;
    }
    return freqs;
  }

  /// Calculates Chi-Squared (chi^2) statistic against standard language profile
  /// chi^2 = sum( (observed - expected)^2 / expected )
  double get chiSquaredStatistic {
    final observedCounts = characterCounts;
    final total = totalLettersCount;
    if (total == 0) return 0.0;

    double chi2 = 0.0;
    final stdFreqs = language.frequencies;

    for (final entry in stdFreqs.entries) {
      final expectedCount = (entry.value / 100.0) * total;
      final observedCount = (observedCounts[entry.key] ?? 0).toDouble();
      if (expectedCount > 0) {
        chi2 += math.pow(observedCount - expectedCount, 2) / expectedCount;
      }
    }
    return chi2;
  }

  /// Al-Kindi's Index of Coincidence (IoC):
  /// IoC = sum( f_i * (f_i - 1) ) / ( N * (N - 1) )
  double get indexOfCoincidence {
    final counts = characterCounts;
    final n = totalLettersCount;
    if (n <= 1) return 0.0;

    double sum = 0.0;
    for (final count in counts.values) {
      sum += count * (count - 1);
    }
    return sum / (n * (n - 1));
  }

  /// Top 5 most frequent letters in ciphertext, sorted descending
  List<MapEntry<String, double>> get topObservedLetters {
    final list = empiricalFrequencies.entries.toList();
    list.sort((a, b) => b.value.compareTo(a.value));
    return list.take(5).toList();
  }

  /// Deciphered text applying the inverse of shiftKey
  String get decipheredText {
    final alpha = language.alphabet;
    final alphaLen = alpha.length;
    final clean = _normalizeText(cipherText, language);
    final sb = StringBuffer();

    for (int i = 0; i < clean.length; i++) {
      final char = clean[i];
      final idx = alpha.indexOf(char);
      if (idx != -1) {
        final newIdx = (idx - shiftKey + alphaLen) % alphaLen;
        sb.write(alpha[newIdx]);
      } else {
        sb.write(char);
      }
    }
    return sb.toString();
  }

  AlKindiCryptanalysisState copyWith({
    CryptoLanguage? language,
    String? rawText,
    String? cipherText,
    int? shiftKey,
    Map<String, String>? substitutionKey,
    bool? autoDetectBestShift,
  }) {
    return AlKindiCryptanalysisState(
      language: language ?? this.language,
      rawText: rawText ?? this.rawText,
      cipherText: cipherText ?? this.cipherText,
      shiftKey: shiftKey ?? this.shiftKey,
      substitutionKey: substitutionKey ?? this.substitutionKey,
      autoDetectBestShift: autoDetectBestShift ?? this.autoDetectBestShift,
    );
  }

  static String _normalizeText(String input, CryptoLanguage lang) {
    if (lang == CryptoLanguage.arabic) {
      // Remove diacritics/tashkeel and normalize hamzas for cryptanalysis
      return input
          .replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), '') // Strip tashkeel
          .replaceAll(RegExp(r'[إأآ]'), 'ا')
          .replaceAll('ى', 'ي')
          .replaceAll('ة', 'ه');
    } else {
      return input.toLowerCase();
    }
  }

  static String _applyCaesarShift(String input, int shift, CryptoLanguage lang) {
    final alpha = lang.alphabet;
    final alphaLen = alpha.length;
    final normalized = _normalizeText(input, lang);
    final sb = StringBuffer();

    for (int i = 0; i < normalized.length; i++) {
      final char = normalized[i];
      final idx = alpha.indexOf(char);
      if (idx != -1) {
        final shifted = (idx + shift) % alphaLen;
        sb.write(alpha[shifted]);
      } else {
        sb.write(char);
      }
    }
    return sb.toString();
  }
}

/// Controller orchestrating Al-Kindi's Cryptanalytic Frequency Studio
class AlKindiCryptanalysisController extends ChangeNotifier {
  AlKindiCryptanalysisState _state = AlKindiCryptanalysisState.initial();

  AlKindiCryptanalysisState get state => _state;

  void setLanguage(CryptoLanguage language) {
    String sampleRaw;
    switch (language) {
      case CryptoLanguage.arabic:
        sampleRaw = 'الْعِلْمُ صَيْدٌ وَالْكِتَابَةُ قَيْدُهُ قَيِّدْ صُيُودَكَ بِالْحِبَالِ الْوَاثِقَةِ';
        break;
      case CryptoLanguage.german:
        sampleRaw = 'wissen ist macht und die bildung schuetzt die freiheit des menschen';
        break;
      case CryptoLanguage.english:
        sampleRaw = 'knowledge is power and wisdom guides the seekers of true science';
        break;
    }

    final cipher = AlKindiCryptanalysisState._applyCaesarShift(
      sampleRaw,
      _state.shiftKey,
      language,
    );

    _state = _state.copyWith(
      language: language,
      rawText: sampleRaw,
      cipherText: cipher,
    );
    notifyListeners();
  }

  void setCipherText(String text) {
    _state = _state.copyWith(cipherText: text);
    notifyListeners();
  }

  void setShiftKey(int key) {
    final maxShift = _state.language.alphabet.length - 1;
    final clamped = key.clamp(0, maxShift);
    _state = _state.copyWith(shiftKey: clamped);
    notifyListeners();
  }

  /// Automatically breaks Caesar cipher by evaluating all shifts and minimizing chi-squared
  int autoDetectBestShift() {
    final alpha = _state.language.alphabet;
    final alphaLen = alpha.length;
    int bestShift = 0;
    double lowestChi2 = double.infinity;

    for (int testShift = 0; testShift < alphaLen; testShift++) {
      // Create a test state with this shift and decipher
      final testState = _state.copyWith(shiftKey: testShift);
      final deciphered = testState.decipheredText;

      // Evaluate deciphered text chi-squared against target language frequencies
      final counts = <String, int>{};
      int total = 0;
      for (final char in deciphered.split('')) {
        if (alpha.contains(char)) {
          counts[char] = (counts[char] ?? 0) + 1;
          total++;
        }
      }

      if (total > 0) {
        double chi2 = 0.0;
        for (final entry in _state.language.frequencies.entries) {
          final expected = (entry.value / 100.0) * total;
          final observed = (counts[entry.key] ?? 0).toDouble();
          if (expected > 0) {
            chi2 += math.pow(observed - expected, 2) / expected;
          }
        }

        if (chi2 < lowestChi2) {
          lowestChi2 = chi2;
          bestShift = testShift;
        }
      }
    }

    setShiftKey(bestShift);
    return bestShift;
  }

  void reset() {
    _state = AlKindiCryptanalysisState.initial();
    notifyListeners();
  }
}
