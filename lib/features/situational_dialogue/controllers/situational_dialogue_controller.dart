import 'package:flutter/foundation.dart';

import '../data/situational_dialogue_repository.dart';
import '../models/situational_dialogue_models.dart';

@immutable
class SituationalDialogueState {
  const SituationalDialogueState({
    required this.allScenarios,
    required this.allChallenges,
    this.selectedDomain,
    this.searchQuery = '',
    this.showPragmaticNotes = true,
    this.showGermanLine = true,
    this.currentChallengeIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<SituationalDialogueScenario> allScenarios;
  final List<RoleplayTurnChallenge> allChallenges;
  final DialogueContextDomain? selectedDomain;
  final String searchQuery;
  final bool showPragmaticNotes;
  final bool showGermanLine;
  final int currentChallengeIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<SituationalDialogueScenario> get filteredScenarios {
    final q = searchQuery.trim().toLowerCase();
    return allScenarios.where((s) {
      final matchesDomain = selectedDomain == null || s.domain == selectedDomain;
      if (!matchesDomain) return false;
      if (q.isEmpty) return true;
      return s.titleAr.toLowerCase().contains(q) ||
          s.titleEn.toLowerCase().contains(q) ||
          s.titleDe.toLowerCase().contains(q) ||
          s.turns.any(
            (t) =>
                t.lineAr.toLowerCase().contains(q) ||
                t.lineEn.toLowerCase().contains(q) ||
                t.lineDe.toLowerCase().contains(q),
          );
    }).toList(growable: false);
  }

  RoleplayTurnChallenge? get currentChallenge {
    if (allChallenges.isEmpty) return null;
    final idx = currentChallengeIndex.clamp(0, allChallenges.length - 1);
    return allChallenges[idx];
  }

  double get accuracyRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  SituationalDialogueState copyWith({
    DialogueContextDomain? selectedDomain,
    bool clearDomain = false,
    String? searchQuery,
    bool? showPragmaticNotes,
    bool? showGermanLine,
    int? currentChallengeIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return SituationalDialogueState(
      allScenarios: allScenarios,
      allChallenges: allChallenges,
      selectedDomain:
          clearDomain ? null : (selectedDomain ?? this.selectedDomain),
      searchQuery: searchQuery ?? this.searchQuery,
      showPragmaticNotes: showPragmaticNotes ?? this.showPragmaticNotes,
      showGermanLine: showGermanLine ?? this.showGermanLine,
      currentChallengeIndex:
          currentChallengeIndex ?? this.currentChallengeIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class SituationalDialogueController extends ChangeNotifier {
  SituationalDialogueController({
    SituationalDialogueRepository? repository,
  }) : _repository = repository ?? const SituationalDialogueRepository() {
    _state = SituationalDialogueState(
      allScenarios: _repository.getScenarios(),
      allChallenges: _repository.getChallenges(),
    );
  }

  final SituationalDialogueRepository _repository;
  late SituationalDialogueState _state;

  SituationalDialogueState get state => _state;

  void selectDomain(DialogueContextDomain? domain) {
    if (domain == null) {
      _state = _state.copyWith(clearDomain: true);
    } else {
      _state = _state.copyWith(selectedDomain: domain);
    }
    notifyListeners();
  }

  void updateSearch(String query) {
    _state = _state.copyWith(searchQuery: query);
    notifyListeners();
  }

  void togglePragmaticNotes() {
    _state = _state.copyWith(showPragmaticNotes: !_state.showPragmaticNotes);
    notifyListeners();
  }

  void toggleGermanLine() {
    _state = _state.copyWith(showGermanLine: !_state.showGermanLine);
    notifyListeners();
  }

  void submitResponse(int optionIndex) {
    final challenge = _state.currentChallenge;
    if (challenge == null || _state.selectedOptionIndex != null) return;
    final isCorrect = optionIndex == challenge.correctIndex;
    _state = _state.copyWith(
      selectedOptionIndex: optionIndex,
      answeredCount: _state.answeredCount + 1,
      correctCount: _state.correctCount + (isCorrect ? 1 : 0),
    );
    notifyListeners();
  }

  void nextChallenge() {
    if (_state.allChallenges.isEmpty) return;
    final nextIdx =
        (_state.currentChallengeIndex + 1) % _state.allChallenges.length;
    _state = _state.copyWith(
      currentChallengeIndex: nextIdx,
      clearSelectedOption: true,
    );
    notifyListeners();
  }

  void resetChallenges() {
    _state = _state.copyWith(
      currentChallengeIndex: 0,
      clearSelectedOption: true,
      correctCount: 0,
      answeredCount: 0,
    );
    notifyListeners();
  }
}
