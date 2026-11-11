import 'dart:async';
import 'package:flutter/foundation.dart';
import 'speech_overflow_guard.dart';

/// Representation of an individual word subtitle cue with millisecond offsets.
class SubtitleWordCue {
  final int index;
  final String word;
  final int startMs;
  final int endMs;

  const SubtitleWordCue({
    required this.index,
    required this.word,
    required this.startMs,
    required this.endMs,
  });

  bool isActiveAt(int positionMs) => positionMs >= startMs && positionMs < endMs;
}

/// Dissected trilingual synchronization timeline.
class SubtitleTrack {
  final String languageCode;
  final String fullText;
  final int totalDurationMs;
  final List<SubtitleWordCue> cues;

  const SubtitleTrack({
    required this.languageCode,
    required this.fullText,
    required this.totalDurationMs,
    required this.cues,
  });

  SubtitleWordCue? getActiveCue(int positionMs) {
    for (final cue in cues) {
      if (cue.isActiveAt(positionMs)) return cue;
    }
    return null;
  }
}

/// Service computing syllable-weighted speech timelines and synchronizing highlighted subtitles.
class AudioSubtitleSynchronizer extends ChangeNotifier {
  final SpeechOverflowGuard overflowGuard;
  SubtitleTrack? _activeTrack;
  int _currentPositionMs = 0;
  int _activeCueIndex = -1;
  bool _isPlaying = false;
  int _playbackToken = 0;
  Timer? _playbackTimer;

  AudioSubtitleSynchronizer({SpeechOverflowGuard? guard})
      : overflowGuard = guard ?? SpeechOverflowGuard();

  SubtitleTrack? get activeTrack => _activeTrack;
  int get currentPositionMs => _currentPositionMs;
  int get activeCueIndex => _activeCueIndex;
  bool get isPlaying => _isPlaying;

  /// Builds a syllable-weighted subtitle track for [text] in [languageCode].
  static SubtitleTrack buildTrack({
    required String text,
    required String languageCode,
    double speechRate = 1.0,
  }) {
    final words = text.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) {
      return SubtitleTrack(
        languageCode: languageCode,
        fullText: text,
        totalDurationMs: 0,
        cues: const [],
      );
    }

    final cues = <SubtitleWordCue>[];
    int currentOffsetMs = 100; // 100ms pre-roll breathing pause

    // Compute syllable-weighted duration per word
    for (var i = 0; i < words.length; i++) {
      final word = words[i];
      final syllableCount = _estimateSyllables(word, languageCode);

      // Base: 180ms per syllable at 1.0 rate + 40ms inter-word gap
      final duration = ((syllableCount * 180.0 + 40.0) / speechRate).round();
      final endMs = currentOffsetMs + duration;

      cues.add(SubtitleWordCue(
        index: i,
        word: word,
        startMs: currentOffsetMs,
        endMs: endMs,
      ));

      currentOffsetMs = endMs + 30; // 30ms inter-word micro-pause
    }

    return SubtitleTrack(
      languageCode: languageCode,
      fullText: text,
      totalDurationMs: currentOffsetMs + 150,
      cues: cues,
    );
  }

  static int _estimateSyllables(String word, String lang) {
    if (lang == 'ar') {
      // In Arabic, each Tashkeel vowel constitutes a syllable core
      final tashkeelCount = RegExp(r'[\u064B-\u0650\u0670]').allMatches(word).length;
      return tashkeelCount > 0 ? tashkeelCount : (word.length / 2).ceil().clamp(1, 6);
    } else {
      final vowelCount = RegExp(r'[aeiouyäöüAEIOUYÄÖÜ]').allMatches(word).length;
      return vowelCount > 0 ? vowelCount : 1;
    }
  }

  /// Begins synchronized simulated playback with monotonic race protection.
  void playTrack(SubtitleTrack track) {
    stop(); // Cancel any existing audio instances

    final currentToken = ++_playbackToken;
    _activeTrack = track;
    _currentPositionMs = 0;
    _activeCueIndex = -1;
    _isPlaying = true;
    notifyListeners();

    // Register active speech with overflow guard
    overflowGuard.acquireSpeechLock(currentToken);

    const tickIntervalMs = 25;
    _playbackTimer = Timer.periodic(const Duration(milliseconds: tickIntervalMs), (timer) {
      if (!_isPlaying || _playbackToken != currentToken) {
        timer.cancel();
        return;
      }

      _currentPositionMs += tickIntervalMs;

      if (_activeTrack != null) {
        final cue = _activeTrack!.getActiveCue(_currentPositionMs);
        final newIndex = cue?.index ?? -1;

        if (newIndex != _activeCueIndex) {
          _activeCueIndex = newIndex;
          notifyListeners();
        }

        if (_currentPositionMs >= _activeTrack!.totalDurationMs) {
          stop();
        }
      }
    });
  }

  /// Halts playback and resets token state.
  void stop() {
    _playbackToken++;
    _playbackTimer?.cancel();
    _playbackTimer = null;
    _isPlaying = false;
    _activeCueIndex = -1;
    overflowGuard.releaseSpeechLock();
    notifyListeners();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
