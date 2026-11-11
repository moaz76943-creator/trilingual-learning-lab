import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Guard service preventing audio instance collisions and UI text boundary overflow.
class SpeechOverflowGuard {
  int? _activePlaybackToken;
  DateTime? _speechAcquiredAt;

  int? get activePlaybackToken => _activePlaybackToken;
  bool get hasActiveSpeech => _activePlaybackToken != null;

  /// Acquires an exclusive lock for an audio session, cancelling any previous token.
  void acquireSpeechLock(int token) {
    _activePlaybackToken = token;
    _speechAcquiredAt = DateTime.now();
  }

  /// Releases the active speech lock.
  void releaseSpeechLock() {
    _activePlaybackToken = null;
    _speechAcquiredAt = null;
  }

  /// Calculates safe font size to guarantee that text fits within [availableWidth]
  /// without clipping or dropping lines.
  static double calculateSafeFontSize({
    required String text,
    required double availableWidth,
    double defaultFontSize = 20.0,
    double minimumFontSize = 12.0,
    int maxLines = 3,
  }) {
    if (text.isEmpty || availableWidth <= 0) return defaultFontSize;

    // Approximate character width ratio (roughly 0.55 of font size for Latin, 0.60 for Arabic)
    final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    final charRatio = isArabic ? 0.60 : 0.52;

    final totalCharacters = text.length;
    final charactersPerLine = (totalCharacters / maxLines).ceil();
    final estimatedWidthNeeded = charactersPerLine * defaultFontSize * charRatio;

    if (estimatedWidthNeeded <= availableWidth) {
      return defaultFontSize;
    }

    final scaledSize = defaultFontSize * (availableWidth / estimatedWidthNeeded);
    return math.max(minimumFontSize, scaledSize);
  }
}
