import 'package:flutter/foundation.dart';

enum AudioFocusState {
  gain,
  loss,
  lossTransient,
  lossTransientCanDuck,
}

/// Service managing audio focus changes, headphone disconnections, and system interruptions.
class AudioLifecycleCoordinator extends ChangeNotifier {
  AudioFocusState _focusState = AudioFocusState.gain;
  double _volumeDuckMultiplier = 1.0;
  bool _shouldPausePlayback = false;

  AudioFocusState get focusState => _focusState;
  double get volumeDuckMultiplier => _volumeDuckMultiplier;
  bool get shouldPausePlayback => _shouldPausePlayback;

  /// Handles incoming audio focus change from platform channels.
  void handleAudioFocusChange(AudioFocusState newState) {
    _focusState = newState;

    switch (newState) {
      case AudioFocusState.gain:
        _volumeDuckMultiplier = 1.0;
        _shouldPausePlayback = false;
        break;
      case AudioFocusState.loss:
        _volumeDuckMultiplier = 0.0;
        _shouldPausePlayback = true;
        break;
      case AudioFocusState.lossTransient:
        _volumeDuckMultiplier = 0.0;
        _shouldPausePlayback = true;
        break;
      case AudioFocusState.lossTransientCanDuck:
        _volumeDuckMultiplier = 0.30; // Duck volume to 30% for background alerts
        _shouldPausePlayback = false;
        break;
    }

    notifyListeners();
  }

  /// Handles headphones unplugged event (becoming noisy).
  void handleBecomingNoisy() {
    _shouldPausePlayback = true;
    notifyListeners();
  }
}
