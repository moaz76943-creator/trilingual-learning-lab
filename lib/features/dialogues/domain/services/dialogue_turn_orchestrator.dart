import 'package:flutter/foundation.dart';
import '../../../../data/adapters/content_schema_adapter.dart';

enum DialogueMode {
  study,     // Step-by-step progression with manual reveal
  autoPlay,  // Automated progression through lines
  rolePlay,  // User plays one speaker; prompt is hidden until recalled
}

/// State tracking for an individual turn within the session.
class TurnSessionState {
  final int index;
  bool isRevealed;
  bool isCompleted;

  TurnSessionState({
    required this.index,
    this.isRevealed = true,
    this.isCompleted = false,
  });
}

/// Orchestrator governing interactive turn flow, mode switching, and dialogue progress.
class DialogueTurnOrchestrator {
  final CanonicalDialogue dialogue;
  DialogueMode _mode = DialogueMode.study;
  int _currentIndex = 0;
  String? _userRoleSpeaker; // Speaker name chosen by user in role-play mode
  late final List<TurnSessionState> _turnStates;

  DialogueTurnOrchestrator({
    required this.dialogue,
    DialogueMode initialMode = DialogueMode.study,
    String? userRoleSpeaker,
  }) {
    _mode = initialMode;
    _userRoleSpeaker = userRoleSpeaker;
    _turnStates = List.generate(
      dialogue.turns.length,
      (i) => TurnSessionState(index: i),
    );
    _applyModeConstraints();
  }

  DialogueMode get mode => _mode;
  int get currentIndex => _currentIndex;
  int get totalTurns => dialogue.turns.length;
  bool get isFinished => _currentIndex >= dialogue.turns.length - 1 && (_turnStates.isNotEmpty && _turnStates.last.isCompleted);
  String? get userRoleSpeaker => _userRoleSpeaker;

  CanonicalDialogueTurn? get currentTurn {
    if (_currentIndex < 0 || _currentIndex >= dialogue.turns.length) return null;
    return dialogue.turns[_currentIndex];
  }

  TurnSessionState? get currentTurnState {
    if (_currentIndex < 0 || _currentIndex >= _turnStates.length) return null;
    return _turnStates[_currentIndex];
  }

  double get progressFraction {
    if (dialogue.turns.isEmpty) return 0.0;
    final completedCount = _turnStates.where((s) => s.isCompleted).length;
    return completedCount / dialogue.turns.length;
  }

  void setMode(DialogueMode mode, {String? userRoleSpeaker}) {
    _mode = mode;
    _userRoleSpeaker = userRoleSpeaker;
    _applyModeConstraints();
  }

  void _applyModeConstraints() {
    for (var i = 0; i < dialogue.turns.length; i++) {
      final turn = dialogue.turns[i];
      if (_mode == DialogueMode.rolePlay && _userRoleSpeaker != null) {
        // If this turn belongs to the user's role, start with hidden speech
        final isUserSpeaker = turn.speaker.ar == _userRoleSpeaker ||
            turn.speaker.de == _userRoleSpeaker ||
            turn.speaker.en == _userRoleSpeaker;
        _turnStates[i].isRevealed = !isUserSpeaker;
      } else {
        _turnStates[i].isRevealed = true;
      }
    }
  }

  /// Toggles visibility of hidden speech in role-play or study mode.
  void toggleReveal() {
    final state = currentTurnState;
    if (state != null) {
      state.isRevealed = !state.isRevealed;
    }
  }

  /// Advances to next turn, marking current as completed.
  bool nextTurn() {
    if (currentTurnState != null) {
      currentTurnState!.isCompleted = true;
    }

    if (_currentIndex < dialogue.turns.length - 1) {
      _currentIndex++;
      return true;
    }
    return false;
  }

  /// Moves back to previous turn.
  bool previousTurn() {
    if (_currentIndex > 0) {
      _currentIndex--;
      return true;
    }
    return false;
  }

  /// Jumps directly to a specific turn index.
  void jumpToTurn(int index) {
    if (index >= 0 && index < dialogue.turns.length) {
      _currentIndex = index;
    }
  }

  /// Resets session back to initial turn.
  void reset() {
    _currentIndex = 0;
    for (final s in _turnStates) {
      s.isCompleted = false;
    }
    _applyModeConstraints();
  }
}
