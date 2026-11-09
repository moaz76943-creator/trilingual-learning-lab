import 'package:flutter/widgets.dart';

/// Service managing bidirectional text directionality, directional insets,
/// and icon mirroring for seamless Arabic (RTL) and German/English (LTR) rendering.
class TrilingualDirectionalityService {
  static final RegExp _arabicScriptRegex = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]');

  /// Determines if a string predominantly contains Arabic script.
  static bool isArabicScript(String text) {
    if (text.isEmpty) return false;
    return _arabicScriptRegex.hasMatch(text);
  }

  /// Resolves the primary [TextDirection] for a given language code or sample text.
  static TextDirection resolveDirection(String langCodeOrText) {
    final lower = langCodeOrText.trim().toLowerCase();
    if (lower == 'ar' || lower.startsWith('ar_') || lower.startsWith('ar-')) {
      return TextDirection.rtl;
    }
    if (isArabicScript(langCodeOrText)) {
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }

  /// Resolves directional padding ensuring proper start/end mirroring in RTL.
  static EdgeInsetsDirectional resolveDirectionalPadding({
    double start = 0.0,
    double top = 0.0,
    double end = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsetsDirectional.only(
      start: start,
      top: top,
      end: end,
      bottom: bottom,
    );
  }

  /// Converts start/end padding to absolute [EdgeInsets] based on an explicit [TextDirection].
  static EdgeInsets resolveAbsolutePadding({
    required TextDirection direction,
    double start = 0.0,
    double top = 0.0,
    double end = 0.0,
    double bottom = 0.0,
  }) {
    if (direction == TextDirection.rtl) {
      return EdgeInsets.only(
        left: end,
        top: top,
        right: start,
        bottom: bottom,
      );
    } else {
      return EdgeInsets.only(
        left: start,
        top: top,
        right: end,
        bottom: bottom,
      );
    }
  }

  /// Resolves horizontal alignment according to start/center/end and direction.
  static Alignment resolveAlignment({
    required TextDirection direction,
    required bool alignStart,
  }) {
    if (alignStart) {
      return direction == TextDirection.rtl ? Alignment.centerRight : Alignment.centerLeft;
    } else {
      return direction == TextDirection.rtl ? Alignment.centerLeft : Alignment.centerRight;
    }
  }

  /// Checks if an icon should be mirrored horizontally when rendered under [TextDirection.rtl].
  static bool shouldMirrorIcon(String iconName, TextDirection direction) {
    if (direction != TextDirection.rtl) return false;

    const directionalIconKeywords = [
      'arrow_forward',
      'arrow_back',
      'chevron_right',
      'chevron_left',
      'navigate_next',
      'navigate_before',
      'forward',
      'back',
      'redo',
      'undo',
      'reply',
    ];

    final lowerName = iconName.toLowerCase();
    return directionalIconKeywords.any((keyword) => lowerName.contains(keyword));
  }
}
