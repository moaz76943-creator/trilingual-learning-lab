import 'package:flutter/widgets.dart';

/// Strut and font metric configuration tailored to trilingual rendering requirements.
class ResolvedFontMetrics {
  final String fontFamily;
  final double fontSize;
  final double lineHeightMultiplier;
  final double letterSpacing;
  final StrutStyle strutStyle;
  final TextDirection textDirection;

  const ResolvedFontMetrics({
    required this.fontFamily,
    required this.fontSize,
    required this.lineHeightMultiplier,
    required this.letterSpacing,
    required this.strutStyle,
    required this.textDirection,
  });
}

/// Service resolving font families, strut heights, and kerning constraints across AR, DE, EN.
class FontMetricResolver {
  static const String arabicFontFamily = 'Amiri';
  static const String latinFontFamily = 'Inter';

  /// Resolves font metrics preventing vertical clipping and cursive ligature detachment.
  static ResolvedFontMetrics resolve({
    required String languageCode,
    double baseFontSize = 16.0,
    bool hasTashkeel = false,
  }) {
    final lang = languageCode.toLowerCase().trim();

    if (lang == 'ar' || lang.startsWith('ar_') || lang.startsWith('ar-')) {
      // Arabic requires increased line height (1.6 to 1.85) to accommodate stacked Tashkeel
      final heightMultiplier = hasTashkeel ? 1.85 : 1.55;

      return ResolvedFontMetrics(
        fontFamily: arabicFontFamily,
        fontSize: baseFontSize * 1.12, // Arabic script visually renders smaller at identical point sizes
        lineHeightMultiplier: heightMultiplier,
        letterSpacing: 0.0, // Strictly zero letter-spacing: positive spacing breaks Arabic cursive connections!
        strutStyle: StrutStyle(
          fontFamily: arabicFontFamily,
          fontSize: baseFontSize * 1.12,
          height: heightMultiplier,
          forceStrutHeight: true,
        ),
        textDirection: TextDirection.rtl,
      );
    } else {
      // German and English (LTR)
      return ResolvedFontMetrics(
        fontFamily: latinFontFamily,
        fontSize: baseFontSize,
        lineHeightMultiplier: 1.35,
        letterSpacing: -0.2,
        strutStyle: StrutStyle(
          fontFamily: latinFontFamily,
          fontSize: baseFontSize,
          height: 1.35,
          forceStrutHeight: true,
        ),
        textDirection: TextDirection.ltr,
      );
    }
  }
}
