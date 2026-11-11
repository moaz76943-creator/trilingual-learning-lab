import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/audio/pronunciation_accuracy_scorer.dart';
import 'package:trilingual_learning_lab/core/audio/voice_amplitude_visualizer.dart';

void main() {
  group('VoiceAmplitudeVisualizer & PronunciationAccuracyScorer Tests', () {
    test('VoiceAmplitudeVisualizer updates amplitudes with exponential smoothing', () {
      final controller = VoiceAmplitudeVisualizerController(barCount: 20, smoothingFactor: 0.5);

      expect(controller.barCount, equals(20));
      expect(controller.amplitudes.length, equals(20));
      expect(controller.isActive, isFalse);

      // Inject strong sound energy (0.85)
      controller.updateSoundLevel(0.85);

      expect(controller.isActive, isTrue);
      // Amplitudes must rise above baseline resting 0.08
      expect(controller.amplitudes.any((a) => a > 0.15), isTrue);

      controller.reset();
      expect(controller.isActive, isFalse);
    });

    test('PronunciationAccuracyScorer awards high score for accurate duration and pacing', () {
      final result = PronunciationAccuracyScorer.evaluate(
        referenceDurationMs: 2000,
        learnerDurationMs: 2050, // 2.5% variation -> perfect duration
        expectedSyllables: 6,
        detectedPauseCount: 0,
        languageCode: 'ar',
      );

      expect(result.isPassing, isTrue);
      expect(result.overallScore, greaterThanOrEqualTo(90.0));
      expect(result.diagnosticAr, contains('مُمْتَازٌ'));
    });

    test('PronunciationAccuracyScorer flags rushed speech correctly', () {
      final result = PronunciationAccuracyScorer.evaluate(
        referenceDurationMs: 2000,
        learnerDurationMs: 1000, // Half duration -> rushed
        expectedSyllables: 6,
        detectedPauseCount: 0,
        languageCode: 'de',
      );

      expect(result.durationScore, lessThan(75.0));
      expect(result.diagnosticDe, contains('schnelles'));
    });

    test('PronunciationAccuracyScorer flags drawn-out sluggish speech correctly', () {
      final result = PronunciationAccuracyScorer.evaluate(
        referenceDurationMs: 1500,
        learnerDurationMs: 3200, // More than double duration
        expectedSyllables: 4,
        detectedPauseCount: 4,
        languageCode: 'en',
      );

      expect(result.durationScore, lessThan(70.0));
      expect(result.diagnosticEn, contains('slow'));
    });
  });
}
