import 'dart:math' as math;
import 'package:flutter/foundation.dart';

/// Controller governing audio waveform amplitude generation, smoothing, and live visualizer state.
class VoiceAmplitudeVisualizerController extends ChangeNotifier {
  final int barCount;
  final double smoothingFactor; // Alpha for exponential moving average (0.1 to 0.9)
  late List<double> _amplitudes;
  bool _isActive = false;

  VoiceAmplitudeVisualizerController({
    this.barCount = 28,
    this.smoothingFactor = 0.35,
  }) {
    _amplitudes = List.filled(barCount, 0.08); // Baseline idle height
  }

  List<double> get amplitudes => List.unmodifiable(_amplitudes);
  bool get isActive => _isActive;

  /// Updates raw amplitude stream with new sound energy input (0.0 to 1.0).
  void updateSoundLevel(double rawEnergy) {
    final energy = rawEnergy.clamp(0.05, 1.0);
    _isActive = energy > 0.10;

    for (var i = 0; i < barCount; i++) {
      // Simulate frequency-band variation based on position and energy
      final phase = (i / barCount) * math.pi;
      final targetHeight = energy * math.sin(phase) + (0.10 * math.cos(i.toDouble()));
      final clampedTarget = targetHeight.clamp(0.06, 1.0);

      // Exponential moving average: A_t = alpha * target + (1 - alpha) * A_{t-1}
      _amplitudes[i] = (smoothingFactor * clampedTarget) + ((1.0 - smoothingFactor) * _amplitudes[i]);
    }

    notifyListeners();
  }

  /// Sets synthetic rhythm pulse during audio playback based on track progress.
  void setProgressPulse(double progressFraction) {
    _isActive = progressFraction > 0.0 && progressFraction < 1.0;

    for (var i = 0; i < barCount; i++) {
      final wave = math.sin((i * 0.4) + (progressFraction * math.pi * 8));
      final height = (0.20 + 0.65 * wave.abs()).clamp(0.08, 1.0);
      _amplitudes[i] = (0.4 * height) + (0.6 * _amplitudes[i]);
    }

    notifyListeners();
  }

  /// Resets visualizer to resting baseline.
  void reset() {
    _isActive = false;
    _amplitudes = List.filled(barCount, 0.08);
    notifyListeners();
  }
}
