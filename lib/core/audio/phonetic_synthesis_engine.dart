import 'package:flutter/foundation.dart';

/// Structured result of an IPA phonetic transcription.
class PhoneticTranscription {
  final String language;
  final String originalText;
  final String ipa;
  final int syllableCount;

  const PhoneticTranscription({
    required this.language,
    required this.originalText,
    required this.ipa,
    required this.syllableCount,
  });

  @override
  String toString() => '[$language] $originalText -> /$ipa/ (syllables: $syllableCount)';
}

/// Side-by-side trilingual phonetic comparison.
class TrilingualPhoneticComparison {
  final PhoneticTranscription arabic;
  final PhoneticTranscription german;
  final PhoneticTranscription english;

  const TrilingualPhoneticComparison({
    required this.arabic,
    required this.german,
    required this.english,
  });
}

/// Offline phonetic synthesis and IPA transcription engine.
class PhoneticSynthesisEngine {
  // Arabic consonant to IPA mapping
  static const Map<String, String> _arabicConsonants = {
    'ء': 'ʔ', 'أ': 'ʔ', 'إ': 'ʔ', 'ؤ': 'ʔ', 'ئ': 'ʔ', 'آ': 'ʔaː',
    'ب': 'b', 'ت': 't', 'ث': 'θ', 'ج': 'd͡ʒ', 'ح': 'ħ', 'خ': 'x',
    'د': 'd', 'ذ': 'ð', 'ر': 'r', 'ز': 'z', 'س': 's', 'ش': 'ʃ',
    'ص': 'sˤ', 'ض': 'dˤ', 'ط': 'tˤ', 'ظ': 'ðˤ', 'ع': 'ʕ', 'غ': 'ɣ',
    'ف': 'f', 'ق': 'q', 'ك': 'k', 'ل': 'l', 'م': 'm', 'ن': 'n',
    'ه': 'h', 'ة': 'h', 'و': 'w', 'ي': 'j', 'ى': 'aː',
  };

  /// Transcribes fully vocalized Arabic text into IPA.
  static PhoneticTranscription transcribeArabic(String vocalizedText) {
    if (vocalizedText.trim().isEmpty) {
      return PhoneticTranscription(
        language: 'ar',
        originalText: vocalizedText,
        ipa: '',
        syllableCount: 0,
      );
    }

    final buffer = StringBuffer();
    int syllables = 0;
    final chars = vocalizedText.split('');

    for (var i = 0; i < chars.length; i++) {
      final c = chars[i];

      // Diacritical marks
      if (c == '\u064E') { // Fatha
        buffer.write('a');
        syllables++;
      } else if (c == '\u064F') { // Damma
        buffer.write('u');
        syllables++;
      } else if (c == '\u0650') { // Kasra
        buffer.write('i');
        syllables++;
      } else if (c == '\u064B') { // Fathatan
        buffer.write('an');
        syllables++;
      } else if (c == '\u064C') { // Dammatan
        buffer.write('un');
        syllables++;
      } else if (c == '\u064D') { // Kasratan
        buffer.write('in');
        syllables++;
      } else if (c == '\u0651') { // Shadda (gemination)
        // Repeat previous consonant if available
        if (buffer.isNotEmpty) {
          final last = buffer.toString().characters.last;
          buffer.write(last);
        }
      } else if (c == '\u0652') { // Sukun
        // Voiceless stop closure
      } else if (c == '\u0670') { // Superscript Alef
        buffer.write('aː');
        syllables++;
      } else if (c == 'ا') {
        // Prolonged vowel or initial support
        if (buffer.isNotEmpty && buffer.toString().endsWith('a')) {
          buffer.write('ː');
        } else {
          buffer.write('aː');
          syllables++;
        }
      } else if (_arabicConsonants.containsKey(c)) {
        buffer.write(_arabicConsonants[c]);
      } else if (c == ' ') {
        buffer.write(' ');
      }
    }

    if (syllables == 0 && buffer.isNotEmpty) syllables = 1;

    return PhoneticTranscription(
      language: 'ar',
      originalText: vocalizedText,
      ipa: buffer.toString().trim(),
      syllableCount: syllables,
    );
  }

  /// Transcribes German text into standard IPA phonemes.
  static PhoneticTranscription transcribeGerman(String germanText) {
    if (germanText.trim().isEmpty) {
      return PhoneticTranscription(
        language: 'de',
        originalText: germanText,
        ipa: '',
        syllableCount: 0,
      );
    }

    var ipa = germanText.toLowerCase();

    // Multigraph substitutions
    ipa = ipa.replaceAll('tsch', 't͡ʃ');
    ipa = ipa.replaceAll('sch', 'ʃ');
    ipa = ipa.replaceAll('ch', 'ç');
    ipa = ipa.replaceAll('ck', 'k');
    ipa = ipa.replaceAll('tz', 't͡s');
    ipa = ipa.replaceAll('ph', 'f');
    ipa = ipa.replaceAll('qu', 'kv');

    // Diphthongs
    ipa = ipa.replaceAll('ei', 'aɪ');
    ipa = ipa.replaceAll('ey', 'aɪ');
    ipa = ipa.replaceAll('ai', 'aɪ');
    ipa = ipa.replaceAll('eu', 'ɔʏ');
    ipa = ipa.replaceAll('äu', 'ɔʏ');
    ipa = ipa.replaceAll('au', 'aʊ');
    ipa = ipa.replaceAll('ie', 'iː');

    // Umlauts and special characters
    ipa = ipa.replaceAll('ä', 'ɛː');
    ipa = ipa.replaceAll('ö', 'øː');
    ipa = ipa.replaceAll('ü', 'yː');
    ipa = ipa.replaceAll('ß', 's');
    ipa = ipa.replaceAll('z', 't͡s');
    ipa = ipa.replaceAll('v', 'f');
    ipa = ipa.replaceAll('w', 'v');
    ipa = ipa.replaceAll('j', 'j');

    // Estimate syllables based on vowel sounds
    final vowelMatches = RegExp(r'[aeiouyɛøaɪɔʏaʊiː]').allMatches(ipa);
    final syllables = vowelMatches.isEmpty ? 1 : vowelMatches.length;

    return PhoneticTranscription(
      language: 'de',
      originalText: germanText,
      ipa: ipa.trim(),
      syllableCount: syllables,
    );
  }

  /// Transcribes English scientific and vocabulary terms into IPA phonemes.
  static PhoneticTranscription transcribeEnglish(String englishText) {
    if (englishText.trim().isEmpty) {
      return PhoneticTranscription(
        language: 'en',
        originalText: englishText,
        ipa: '',
        syllableCount: 0,
      );
    }

    var ipa = englishText.toLowerCase();

    // Multigraphs
    ipa = ipa.replaceAll('th', 'θ');
    ipa = ipa.replaceAll('sh', 'ʃ');
    ipa = ipa.replaceAll('ch', 't͡ʃ');
    ipa = ipa.replaceAll('ph', 'f');
    ipa = ipa.replaceAll('ee', 'iː');
    ipa = ipa.replaceAll('oo', 'uː');
    ipa = ipa.replaceAll('ea', 'iː');
    ipa = ipa.replaceAll('ou', 'aʊ');
    ipa = ipa.replaceAll('ow', 'aʊ');

    final vowelMatches = RegExp(r'[aeiouyθʃ]').allMatches(ipa);
    final syllables = vowelMatches.isEmpty ? 1 : vowelMatches.length;

    return PhoneticTranscription(
      language: 'en',
      originalText: englishText,
      ipa: ipa.trim(),
      syllableCount: syllables,
    );
  }

  /// Builds a side-by-side trilingual phonetic comparison for vocabulary items.
  static TrilingualPhoneticComparison compare({
    required String arVocalized,
    required String deText,
    required String enText,
  }) {
    return TrilingualPhoneticComparison(
      arabic: transcribeArabic(arVocalized),
      german: transcribeGerman(deText),
      english: transcribeEnglish(enText),
    );
  }
}
