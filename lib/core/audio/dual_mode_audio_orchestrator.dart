import 'package:flutter/foundation.dart';
import 'audio_lifecycle_coordinator.dart';
import 'local_audio_cache_manager.dart';
import 'tts_calibration_service.dart';

enum AudioSourceMode {
  cachedAssetFile,
  synthesizedTts,
  visualOnlyFallback,
}

/// Outcome container for an audio dispatch request.
class AudioDispatchResult {
  final AudioSourceMode mode;
  final bool isSuccessful;
  final String? audioPath;
  final String? synthesizedText;
  final String? message;

  const AudioDispatchResult({
    required this.mode,
    required this.isSuccessful,
    this.audioPath,
    this.synthesizedText,
    this.message,
  });
}

/// Orchestrator seamlessly routing audio between local asset cache, calibrated TTS, and visual fallback.
class DualModeAudioOrchestrator extends ChangeNotifier {
  final LocalAudioCacheManager cacheManager;
  final TtsCalibrationService ttsService;
  final AudioLifecycleCoordinator lifecycleCoordinator;

  DualModeAudioOrchestrator({
    required this.cacheManager,
    required this.ttsService,
    required this.lifecycleCoordinator,
  });

  /// Dispatches audio playback for [text] in [languageCode] with multi-tier fallback.
  Future<AudioDispatchResult> dispatchAudio({
    required String text,
    required String languageCode,
    bool forceTts = false,
  }) async {
    // 1. Check audio lifecycle focus
    if (lifecycleCoordinator.shouldPausePlayback) {
      return const AudioDispatchResult(
        mode: AudioSourceMode.visualOnlyFallback,
        isSuccessful: false,
        message: 'Playback paused due to audio focus loss or headset unplugged.',
      );
    }

    final cacheKey = LocalAudioCacheManager.generateCacheKey(text, languageCode);

    // 2. Tier 1: Local cached or bundled asset file
    if (!forceTts && cacheManager.hasKey(cacheKey)) {
      final path = cacheManager.getFilePath(cacheKey);
      if (path != null) {
        return AudioDispatchResult(
          mode: AudioSourceMode.cachedAssetFile,
          isSuccessful: true,
          audioPath: path,
        );
      }
    }

    // 3. Tier 2: Synthesized TTS with calibrated acoustics
    try {
      final preparedText = ttsService.prepareTextForSynthesis(text, languageCode);
      if (preparedText.isNotEmpty) {
        return AudioDispatchResult(
          mode: AudioSourceMode.synthesizedTts,
          isSuccessful: true,
          synthesizedText: preparedText,
        );
      }
    } catch (_) {}

    // 4. Tier 3: Visual-only fallback
    return const AudioDispatchResult(
      mode: AudioSourceMode.visualOnlyFallback,
      isSuccessful: true,
      message: 'Audio unavailable; visual phonetic fallback active.',
    );
  }
}
