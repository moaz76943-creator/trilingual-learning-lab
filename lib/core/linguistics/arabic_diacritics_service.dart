import 'package:flutter/foundation.dart';

/// Linguistic utility service for normalizing, stripping diacritics (Tashkeel),
/// and performing accent/umlaut-insensitive comparisons across Arabic, German, and English.
class ArabicDiacriticsService {
  // Arabic Tashkeel Unicode ranges:
  // 064B: Fathatan, 064C: Dammatan, 064D: Kasratan, 064E: Fatha, 064F: Damma,
  // 0650: Kasra, 0651: Shadda, 0652: Sukun, 0670: Superscript Alef, 0640: Tatweel (Kashida)
  static final RegExp _tashkeelRegex = RegExp(r'[\u064B-\u0652\u0670\u0640]');

  // Alef variations: أ, إ, آ, ٱ -> ا
  static final RegExp _alefVariationsRegex = RegExp(r'[\u0622\u0623\u0625\u0671]');

  // Taa Marbuta: ة -> ه
  static final RegExp _taaMarbutaRegex = RegExp(r'\u0629');

  // Alef Maksura: ى -> ي
  static final RegExp _alefMaksuraRegex = RegExp(r'\u0649');

  /// Strips all Arabic diacritical marks (Tashkeel) and Tatweel/Kashida.
  static String stripTashkeel(String input) {
    if (input.isEmpty) return '';
    return input.replaceAll(_tashkeelRegex, '');
  }

  /// Normalizes Arabic text for tolerant search and indexing:
  /// - Strips diacritics and tatweel
  /// - Unifies all forms of Alef (أ, إ, آ, ٱ) into plain Alef (ا)
  /// - Unifies Taa Marbuta (ة) into Haa (ه)
  /// - Unifies Alef Maksura (ى) into Yaa (ي)
  /// - Trims redundant whitespace
  static String normalizeArabic(String input) {
    if (input.isEmpty) return '';
    var text = stripTashkeel(input);
    text = text.replaceAll(_alefVariationsRegex, '\u0627'); // ا
    text = text.replaceAll(_taaMarbutaRegex, '\u0647');    // ه
    text = text.replaceAll(_alefMaksuraRegex, '\u064A');   // ي
    return text.trim();
  }

  /// Normalizes German text by expanding Umlauts (ä, ö, ü, ß -> ae, oe, ue, ss)
  /// and lowercasing for search indexing.
  static String normalizeGerman(String input) {
    if (input.isEmpty) return '';
    return input
        .toLowerCase()
        .replaceAll('ä', 'ae')
        .replaceAll('ö', 'oe')
        .replaceAll('ü', 'ue')
        .replaceAll('ß', 'ss')
        .trim();
  }

  /// Normalizes general trilingual input based on content language.
  static String normalizeForSearch(String input) {
    if (input.isEmpty) return '';
    // If text contains Arabic characters (0600-06FF)
    if (RegExp(r'[\u0600-\u06FF]').hasMatch(input)) {
      return normalizeArabic(input);
    }
    // Else lower-case and apply German umlaut expansion
    return normalizeGerman(input);
  }

  /// Determines whether [source] contains [query] in a diacritic-tolerant,
  /// case-insensitive, and accent-tolerant manner.
  static bool matchesTrilingual(String source, String query) {
    if (query.trim().isEmpty) return true;
    if (source.trim().isEmpty) return false;

    final normSource = normalizeForSearch(source);
    final normQuery = normalizeForSearch(query);

    return normSource.contains(normQuery);
  }
}
