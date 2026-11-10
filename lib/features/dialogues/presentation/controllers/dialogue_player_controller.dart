import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../../data/adapters/content_schema_adapter.dart';
import '../../domain/services/dialogue_turn_orchestrator.dart';

enum DialoguePlaybackState {
  stopped,
  playing,
  paused,
}

/// Controller governing audio synchronization, turn flow, and role-play in dialogues.
class DialoguePlayerController extends ChangeNotifier {
  final CanonicalDialogue dialogue;
  late final DialogueTurnOrchestrator _orchestrator;
  DialoguePlaybackState _playbackState = DialoguePlaybackState.stopped;
  Timer? _autoPlayTimer;
  bool _isCompleted = false;

  DialoguePlayerController({
    required this.dialogue,
    DialogueMode initialMode = DialogueMode.study,
    String? userRoleSpeaker,
  }) {
    _orchestrator = DialogueTurnOrchestrator(
      dialogue: dialogue,
      initialMode: initialMode,
      userRoleSpeaker: userRoleSpeaker,
    );
  }

  DialogueTurnOrchestrator get orchestrator => _orchestrator;
  DialogueMode get mode => _orchestrator.mode;
  int get currentTurnIndex => _orchestrator.currentIndex;
  int get totalTurns => _orchestrator.totalTurns;
  CanonicalDialogueTurn? get currentTurn => _orchestrator.currentTurn;
  TurnSessionState? get currentTurnState => _orchestrator.currentTurnState;
  DialoguePlaybackState get playbackState => _playbackState;
  bool get isCompleted => _isCompleted || _orchestrator.isFinished;
  double get progressFraction => _orchestrator.progressFraction;
  String? get userRoleSpeaker => _orchestrator.userRoleSpeaker;

  /// Sets interactive dialogue mode (study, autoPlay, rolePlay).
  void setMode(DialogueMode mode, {String? userRoleSpeaker}) {
    pause();
    _orchestrator.setMode(mode, userRoleSpeaker: userRoleSpeaker);
    notifyListeners();
  }

  /// Toggles visibility of speech in current turn (e.g. in role-play).
  void toggleReveal() {
    _orchestrator.toggleReveal();
    notifyListeners();
  }

  /// Plays or pauses speech in current turn or auto-play sequence.
  void togglePlayPause() {
    if (_playbackState == DialoguePlaybackState.playing) {
      pause();
    } else {
      play();
    }
  }

  void play() {
    _playbackState = DialoguePlaybackState.playing;
    notifyListeners();

    if (_orchestrator.mode == DialogueMode.autoPlay) {
      _startAutoPlayLoop();
    }
  }

  void pause() {
    _playbackState = DialoguePlaybackState.paused;
    _autoPlayTimer?.cancel();
    notifyListeners();
  }

  void stop() {
    _playbackState = DialoguePlaybackState.stopped;
    _autoPlayTimer?.cancel();
    _orchestrator.reset();
    notifyListeners();
  }

  void _startAutoPlayLoop() {
    _autoPlayTimer?.cancel();
    // Simulate natural speaking delay before advancing
    _autoPlayTimer = Timer(const Duration(milliseconds: 2500), () {
      if (_playbackState != DialoguePlaybackState.playing) return;

      final hasNext = _orchestrator.nextTurn();
      if (hasNext) {
        notifyListeners();
        _startAutoPlayLoop();
      } else {
        _isCompleted = true;
        _playbackState = DialoguePlaybackState.stopped;
        notifyListeners();
      }
    });
  }

  /// Manually advances to next dialogue turn.
  bool nextTurn() {
    pause();
    final hasNext = _orchestrator.nextTurn();
    if (!hasNext) {
      _isCompleted = true;
    }
    notifyListeners();
    return hasNext;
  }

  /// Manually retreats to previous dialogue turn.
  bool previousTurn() {
    pause();
    final hasPrev = _orchestrator.previousTurn();
    notifyListeners();
    return hasPrev;
  }

  /// Jumps directly to a specific turn.
  void jumpToTurn(int index) {
    pause();
    _orchestrator.jumpToTurn(index);
    notifyListeners();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    super.dispose();
  }
}
