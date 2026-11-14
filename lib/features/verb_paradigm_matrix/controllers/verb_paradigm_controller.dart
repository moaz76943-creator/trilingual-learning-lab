import 'package:flutter/foundation.dart';

import '../data/verb_paradigm_repository.dart';
import '../models/verb_paradigm_models.dart';

@immutable
class VerbParadigmState {
  const VerbParadigmState({
    required this.allEntries,
    required this.allDrills,
    this.selectedAxis,
    this.searchQuery = '',
    this.showMorphologyRules = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<VerbParadigmEntry> allEntries;
  final List<VerbParadigmDrill> allDrills;
  final VerbMorphologyAxis? selectedAxis;
  final String searchQuery;
  final bool showMorphologyRules;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<VerbParadigmEntry> get filteredEntries {
    final q = searchQuery.trim().toLowerCase();
    return allEntries.where((e) {
      final matchesAxis = selectedAxis == null || e.axis == selectedAxis;
      if (!matchesAxis) return false;
      if (q.isEmpty) return true;
      return e.titleAr.toLowerCase().contains(q) ||
          e.titleEn.toLowerCase().contains(q) ||
          e.titleDe.toLowerCase().contains(q) ||
          e.germanForms.toLowerCase().contains(q) ||
          e.arabicForms.toLowerCase().contains(q) ||
          e.englishForms.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  VerbParadigmDrill? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get accuracyRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  VerbParadigmState copyWith({
    VerbMorphologyAxis? selectedAxis,
    bool clearAxis = false,
    String? searchQuery,
    bool? showMorphologyRules,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return VerbParadigmState(
      allEntries: allEntries,
      allDrills: allDrills,
      selectedAxis: clearAxis ? null : (selectedAxis ?? this.selectedAxis),
      searchQuery: searchQuery ?? this.searchQuery,
      showMorphologyRules: showMorphologyRules ?? this.showMorphologyRules,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class VerbParadigmController extends ChangeNotifier {
  VerbParadigmController({VerbParadigmRepository? repository})
      : _repository = repository ?? const VerbParadigmRepository() {
    _state = VerbParadigmState(
      allEntries: _repository.getEntries(),
      allDrills: _repository.getDrills(),
    );
  }

  final VerbParadigmRepository _repository;
  late VerbParadigmState _state;

  VerbParadigmState get state => _state;

  void selectAxis(VerbMorphologyAxis? axis) {
    if (axis == null) {
      _state = _state.copyWith(clearAxis: true);
    } else {
      _state = _state.copyWith(selectedAxis: axis);
    }
    notifyListeners();
  }

  void updateSearch(String query) {
    _state = _state.copyWith(searchQuery: query);
    notifyListeners();
  }

  void toggleMorphologyRules() {
    _state = _state.copyWith(showMorphologyRules: !_state.showMorphologyRules);
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
