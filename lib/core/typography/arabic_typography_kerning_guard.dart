import 'package:flutter/widgets.dart';
import 'font_metric_resolver.dart';

/// Guard service analyzing Tashkeel density, preventing clipping, and formatting German compounds.
class ArabicTypographyKerningGuard {
  static final RegExp _tashkeelRegex = RegExp(r'[\u064B-\u0652\u0670]');

  /// Computes the Tashkeel diacritic density ratio (diacritics / total non-space characters).
  static double calculateTashkeelDensity(String text) {
    if (text.isEmpty) return 0.0;
    final totalChars = text.replaceAll(RegExp(r'\s+'), '').length;
    if (totalChars == 0) return 0.0;

    final diacriticMatches = _tashkeelRegex.allMatches(text).length;
    return diacriticMatches / totalChars;
  }

  /// Determines whether the text requires high-strut clipping protection.
  static bool requiresDiacriticClippingProtection(String text) {
    return calculateTashkeelDensity(text) > 0.15;
  }

  /// Inserts soft hyphens (U+00AD) into long German compound nouns at morpheme seams.
  static String formatGermanCompounds(String text) {
    if (text.length < 12) return text;

    final words = text.split(' ');
    final formattedWords = words.map((word) {
      if (word.length >= 14 && !word.contains('-') && !word.contains('\u00AD')) {
        var modified = word;
        const boundaries = [
          'uhr', 'quadrat', 'flasche', 'pumpe', 'muehle',
          'mühle', 'platte', 'stern', 'spiegel', 'zeiger', 'scheibe',
        ];
        for (final b in boundaries) {
          final idx = modified.toLowerCase().indexOf(b);
          if (idx > 3 && idx < modified.length - 2) {
            modified = '${modified.substring(0, idx)}\u00AD${modified.substring(idx)}';
            break;
          }
        }
        return modified;
      }
      return word;
    });

    return formattedWords.join(' ');
  }

  /// Constructs safe TextStyle with calibrated vertical height to eliminate diacritical cutoff.
  static TextStyle createSafeTextStyle({
    required String text,
    required String languageCode,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
    Color? color,
  }) {
    final hasTashkeel = requiresDiacriticClippingProtection(text);
    final metrics = FontMetricResolver.resolve(
      languageCode: languageCode,
      baseFontSize: fontSize,
      hasTashkeel: hasTashkeel,
    );

    return TextStyle(
      fontFamily: metrics.fontFamily,
      fontSize: metrics.fontSize,
      height: metrics.lineHeightMultiplier,
      letterSpacing: metrics.letterSpacing,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
