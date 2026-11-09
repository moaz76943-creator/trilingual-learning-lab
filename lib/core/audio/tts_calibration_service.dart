import 'package:flutter/foundation.dart';

/// Language-specific acoustic profile configuring speech synthesis.
class TtsLanguageProfile {
  final String languageCode;
  final double speechRate;
  final double pitch;
  final double volume;
  final int prePauseMs;
  final int postPauseMs;

  const TtsLanguageProfile({
    required this.languageCode,
    required this.speechRate,
    required this.pitch,
    this.volume = 1.0,
    this.prePauseMs = 100,
    this.postPauseMs = 250,
  });

  TtsLanguageProfile copyWith({
    double? speechRate,
    double? pitch,
    double? volume,
    int? prePauseMs,
    int? postPauseMs,
  }) {
    return TtsLanguageProfile(
      languageCode: languageCode,
      speechRate: speechRate ?? this.speechRate,
      pitch: pitch ?? this.pitch,
      volume: volume ?? this.volume,
      prePauseMs: prePauseMs ?? this.prePauseMs,
      postPauseMs: postPauseMs ?? this.postPauseMs,
    );
  }
}

/// Service managing acoustic speech calibration profiles, text preparation,
/// and estimated synthesis durations.
class TtsCalibrationService {
  final Map<String, TtsLanguageProfile> _profiles = {};

  TtsCalibrationService() {
    _registerDefaultProfiles();
  }

  void _registerDefaultProfiles() {
    // Arabic: Slower cadence (0.80) to allow precise diacritic/vowel articulation
    _profiles['ar'] = const TtsLanguageProfile(
      languageCode: 'ar',
      speechRate: 0.80,
      pitch: 0.95,
      prePauseMs: 150,
      postPauseMs: 300,
    );

    // German: Moderate cadence (0.85) accommodating compound word phonology
    _profiles['de'] = const TtsLanguageProfile(
      languageCode: 'de',
      speechRate: 0.85,
      pitch: 1.0,
      prePauseMs: 100,
      postPauseMs: 250,
    );

    // English: Standard clear conversational pace (0.90)
    _profiles['en'] = const TtsLanguageProfile(
      languageCode: 'en',
      speechRate: 0.90,
      pitch: 1.0,
      prePauseMs: 100,
      postPauseMs: 200,
    );
  }

  /// Retrieves profile for [languageCode] (fallback to English if unmapped).
  TtsLanguageProfile getProfile(String languageCode) {
    final key = languageCode.toLowerCase().split('-').first.split('_').first;
    return _profiles[key] ?? _profiles['en']!;
  }

  /// Updates or overrides a specific language profile.
  void setProfile(TtsLanguageProfile profile) {
    final key = profile.languageCode.toLowerCase().split('-').first.split('_').first;
    _profiles[key] = profile;
  }

  /// Prepares raw text for synthesis by smoothing whitespace and punctuation.
  String prepareTextForSynthesis(String text, String languageCode) {
    if (text.trim().isEmpty) return '';

    var clean = text.replaceAll(RegExp(r'\s+'), ' ').trim();

    // Standardize comma and colon pauses
    clean = clean.replaceAll('،', '، ');
    clean = clean.replaceAll(';', '; ');
    clean = clean.replaceAll(':', ': ');

    return clean.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Estimates playback duration based on word count, average syllables, and speech rate.
  Duration estimateDuration(String text, String languageCode) {
    final clean = prepareTextForSynthesis(text, languageCode);
    if (clean.isEmpty) return Duration.zero;

    final profile = getProfile(languageCode);
    final words = clean.split(' ').where((w) => w.isNotEmpty).length;

    // Base milliseconds per word at 1.0 speech rate (~300ms/word)
    const baseMsPerWord = 320.0;
    final effectiveMsPerWord = baseMsPerWord / profile.speechRate;
    final totalMs = (words * effectiveMsPerWord) + profile.prePauseMs + profile.postPauseMs;

    return Duration(milliseconds: totalMs.round());
  }
}
