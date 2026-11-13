import 'package:flutter/foundation.dart';

import '../data/phonotactics_prosody_repository.dart';
import '../models/phonotactics_prosody_models.dart';

@immutable
class PhonotacticsProsodyState {
  const PhonotacticsProsodyState({
    required this.allLessons,
    required this.allDrills,
    this.selectedCategory,
    this.searchQuery = '',
    this.showIpaTranscriptions = true,
    this.showArticulationTips = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<PhonotacticsLesson> allLessons;
  final List<PhonotacticsDrill> allDrills;
  final PhonotacticsCategory? selectedCategory;
  final String searchQuery;
  final bool showIpaTranscriptions;
  final bool showArticulationTips;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<PhonotacticsLesson> get filteredLessons {
    final q = searchQuery.trim().toLowerCase();
    return allLessons.where((lesson) {
      final matchesCategory =
          selectedCategory == null || lesson.category == selectedCategory;
      if (!matchesCategory) return false;
      if (q.isEmpty) return true;
      return lesson.titleAr.toLowerCase().contains(q) ||
          lesson.titleEn.toLowerCase().contains(q) ||
          lesson.titleDe.toLowerCase().contains(q) ||
          lesson.ruleAr.toLowerCase().contains(q) ||
          lesson.ruleDe.toLowerCase().contains(q) ||
          lesson.germanExamples.any(
            (e) => e.orthography.toLowerCase().contains(q),
          );
    }).toList(growable: false);
  }

  PhonotacticsDrill? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get masteryRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  PhonotacticsProsodyState copyWith({
    PhonotacticsCategory? selectedCategory,
    bool clearCategory = false,
    String? searchQuery,
    bool? showIpaTranscriptions,
    bool? showArticulationTips,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return PhonotacticsProsodyState(
      allLessons: allLessons,
      allDrills: allDrills,
      selectedCategory:
          clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      searchQuery: searchQuery ?? this.searchQuery,
      showIpaTranscriptions:
          showIpaTranscriptions ?? this.showIpaTranscriptions,
      showArticulationTips: showArticulationTips ?? this.showArticulationTips,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class PhonotacticsProsodyController extends ChangeNotifier {
  PhonotacticsProsodyController({
    PhonotacticsProsodyRepository? repository,
  }) : _repository = repository ?? const PhonotacticsProsodyRepository() {
    _state = PhonotacticsProsodyState(
      allLessons: _repository.getLessons(),
      allDrills: _repository.getDrills(),
    );
  }

  final PhonotacticsProsodyRepository _repository;
  late PhonotacticsProsodyState _state;

  PhonotacticsProsodyState get state => _state;

  void selectCategory(PhonotacticsCategory? category) {
    if (category == null) {
      _state = _state.copyWith(clearCategory: true);
    } else {
      _state = _state.copyWith(selectedCategory: category);
    }
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _state = _state.copyWith(searchQuery: query);
    notifyListeners();
  }

  void toggleIpaTranscriptions() {
    _state = _state.copyWith(
      showIpaTranscriptions: !_state.showIpaTranscriptions,
    );
    notifyListeners();
  }

  void toggleArticulationTips() {
    _state = _state.copyWith(
      showArticulationTips: !_state.showArticulationTips,
    );
    notifyListeners();
  }

  void submitAnswer(int optionIndex) {
    final drill = _state.currentDrill;
    if (drill == null || _state.selectedOptionIndex != null) return;
    final isCorrect = optionIndex == drill.correctIndex;
    _state = _state.copyWith(
      selectedOptionIndex: optionIndex,
      answeredCount: _state.answeredCount + 1,
      correctCount: _state.correctCount + (isCorrect ? 1 : 0),
    );
    notifyListeners();
  }

  void nextDrill() {
    if (_state.allDrills.isEmpty) return;
    final nextIdx = (_state.currentDrillIndex + 1) % _state.allDrills.length;
    _state = _state.copyWith(
      currentDrillIndex: nextIdx,
      clearSelectedOption: true,
    );
    notifyListeners();
  }

  void resetDrills() {
    _state = _state.copyWith(
      currentDrillIndex: 0,
      clearSelectedOption: true,
      correctCount: 0,
      answeredCount: 0,
    );
    notifyListeners();
  }
}
