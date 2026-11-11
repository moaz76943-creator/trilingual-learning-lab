import '../linguistics/arabic_diacritics_service.dart';

/// Service dissecting trilingual text into normalized, stem-level search tokens.
class MorphologicalSearchTokenizer {
  // Punctuation and separation symbols
  static final RegExp _separatorRegex = RegExp(r'[^\w\u0600-\u06FF]+');

  // Arabic prefixes to detach for stem matching
  static const List<String> _arabicPrefixes = [
    'ال', 'وال', 'فال', 'كال', 'بال', 'لل',
    'و', 'ف', 'ب', 'ك', 'ل',
  ];

  /// Tokenizes Arabic text into root/stem candidates and normalized forms.
  static Set<String> tokenizeArabic(String text) {
    final tokens = <String>{};
    if (text.trim().isEmpty) return tokens;

    final words = text.split(_separatorRegex).where((w) => w.isNotEmpty);

    for (final word in words) {
      final stripped = ArabicDiacriticsService.stripTashkeel(word);
      final normalized = ArabicDiacriticsService.normalizeArabic(stripped);
      if (normalized.isEmpty) continue;

      tokens.add(normalized);

      // Attempt prefix stripping for words longer than 4 characters
      if (normalized.length >= 4) {
        for (final prefix in _arabicPrefixes) {
          if (normalized.startsWith(prefix)) {
            final stem = normalized.substring(prefix.length);
            if (stem.length >= 3) {
              tokens.add(stem);
            }
            break; // Strip longest matching prefix
          }
        }
      }
    }

    return tokens;
  }

  /// Tokenizes German text with umlaut normalization and compound extraction.
  static Set<String> tokenizeGerman(String text) {
    final tokens = <String>{};
    if (text.trim().isEmpty) return tokens;

    final words = text.split(_separatorRegex).where((w) => w.isNotEmpty);

    for (final word in words) {
      final normalized = ArabicDiacriticsService.normalizeGerman(word);
      if (normalized.isEmpty) continue;

      tokens.add(normalized);

      // Extract common compound boundary words if length > 8
      if (normalized.length > 8) {
        const commonCompounds = [
          'uhr', 'quadrat', 'flasche', 'rad', 'pumpe', 'muehle',
          'platte', 'stern', 'spiegel', 'zeiger', 'rohr', 'scheibe',
        ];

        for (final sub in commonCompounds) {
          if (normalized.contains(sub) && normalized != sub) {
            tokens.add(sub);
          }
        }
      }
    }

    return tokens;
  }

  /// Tokenizes English text with basic suffix stemming.
  static Set<String> tokenizeEnglish(String text) {
    final tokens = <String>{};
    if (text.trim().isEmpty) return tokens;

    final words = text.toLowerCase().split(_separatorRegex).where((w) => w.isNotEmpty);

    for (final word in words) {
      if (word.isEmpty) continue;
      tokens.add(word);

      // Basic plural / tense suffix stripping
      if (word.endsWith('ies') && word.length > 4) {
        tokens.add('${word.substring(0, word.length - 3)}y');
      } else if (word.endsWith('es') && word.length > 4) {
        tokens.add(word.substring(0, word.length - 2));
      } else if (word.endsWith('s') && !word.endsWith('ss') && word.length > 3) {
        tokens.add(word.substring(0, word.length - 1));
      } else if (word.endsWith('ing') && word.length > 5) {
        tokens.add(word.substring(0, word.length - 3));
      } else if (word.endsWith('ed') && word.length > 4) {
        tokens.add(word.substring(0, word.length - 2));
      }
    }

    return tokens;
  }

  /// Automatically detects language and returns unified token set.
  static Set<String> tokenize(String text) {
    if (RegExp(r'[\u0600-\u06FF]').hasMatch(text)) {
      return tokenizeArabic(text);
    } else {
      final deTokens = tokenizeGerman(text);
      final enTokens = tokenizeEnglish(text);
      return {...deTokens, ...enTokens};
    }
  }
}
