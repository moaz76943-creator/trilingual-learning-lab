import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/audio/audio_lifecycle_coordinator.dart';
import 'package:trilingual_learning_lab/core/audio/dual_mode_audio_orchestrator.dart';
import 'package:trilingual_learning_lab/core/audio/local_audio_cache_manager.dart';
import 'package:trilingual_learning_lab/core/audio/tts_calibration_service.dart';

void main() {
  group('AudioLifecycleCoordinator & DualModeAudioOrchestrator Tests', () {
    late AudioLifecycleCoordinator coordinator;
    late LocalAudioCacheManager cache;
    late TtsCalibrationService tts;
    late DualModeAudioOrchestrator orchestrator;

    setUp(() {
      coordinator = AudioLifecycleCoordinator();
      cache = LocalAudioCacheManager();
      tts = TtsCalibrationService();
      orchestrator = DualModeAudioOrchestrator(
        cacheManager: cache,
        ttsService: tts,
        lifecycleCoordinator: coordinator,
      );
    });

    test('AudioLifecycleCoordinator handles audio focus state changes and ducking', () {
      expect(coordinator.focusState, equals(AudioFocusState.gain));
      expect(coordinator.shouldPausePlayback, isFalse);
      expect(coordinator.volumeDuckMultiplier, equals(1.0));

      // Transient loss can duck
      coordinator.handleAudioFocusChange(AudioFocusState.lossTransientCanDuck);
      expect(coordinator.volumeDuckMultiplier, equals(0.30));
      expect(coordinator.shouldPausePlayback, isFalse);

      // Complete focus loss
      coordinator.handleAudioFocusChange(AudioFocusState.loss);
      expect(coordinator.shouldPausePlayback, isTrue);
      expect(coordinator.volumeDuckMultiplier, equals(0.0));

      // Regain focus
      coordinator.handleAudioFocusChange(AudioFocusState.gain);
      expect(coordinator.shouldPausePlayback, isFalse);
      expect(coordinator.volumeDuckMultiplier, equals(1.0));
    });

    test('AudioLifecycleCoordinator pauses playback on headset disconnection', () {
      expect(coordinator.shouldPausePlayback, isFalse);
      coordinator.handleBecomingNoisy();
      expect(coordinator.shouldPausePlayback, isTrue);
    });

    test('DualModeAudioOrchestrator falls back from missing asset to synthesized TTS', () async {
      final result = await orchestrator.dispatchAudio(
        text: 'الأَسْطُرْلاَبُ',
        languageCode: 'ar',
      );

      // Asset was not in cache, so it falls back to synthesized TTS cleanly
      expect(result.isSuccessful, isTrue);
      expect(result.mode, equals(AudioSourceMode.synthesizedTts));
      expect(result.synthesizedText, isNotNull);
    });

    test('DualModeAudioOrchestrator dispatches cached file when available', () async {
      const text = 'Das Messingastrolabium';
      final key = LocalAudioCacheManager.generateCacheKey(text, 'de');
      cache.put(key: key, filePath: '/assets/audio/de_astrolabe.mp3', byteSize: 2048);

      final result = await orchestrator.dispatchAudio(
        text: text,
        languageCode: 'de',
      );

      expect(result.isSuccessful, isTrue);
      expect(result.mode, equals(AudioSourceMode.cachedAssetFile));
      expect(result.audioPath, equals('/assets/audio/de_astrolabe.mp3'));
    });

    test('DualModeAudioOrchestrator halts playback when audio focus is lost', () async {
      coordinator.handleAudioFocusChange(AudioFocusState.loss);

      final result = await orchestrator.dispatchAudio(
        text: 'Test',
        languageCode: 'en',
      );

      expect(result.isSuccessful, isFalse);
      expect(result.mode, equals(AudioSourceMode.visualOnlyFallback));
      expect(result.message, contains('paused'));
    });
  });
}
