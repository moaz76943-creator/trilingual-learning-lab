import 'package:flutter/foundation.dart';

import '../data/reflexive_reciprocal_repository.dart';
import '../models/reflexive_reciprocal_models.dart';

@immutable
class ReflexiveReciprocalState {
  const ReflexiveReciprocalState({
    required this.allUnits,
    required this.allDrills,
    this.selectedCategory,
    this.searchQuery = '',
    this.showRules = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<ReflexiveLessonUnit> allUnits;
  final List<ReflexiveDrillItem> allDrills;
  final ReflexiveCategory? selectedCategory;
  final String searchQuery;
  final bool showRules;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<ReflexiveLessonUnit> get filteredUnits {
    final q = searchQuery.trim().toLowerCase();
    return allUnits.where((u) {
      final matchesCat = selectedCategory == null || u.category == selectedCategory;
      if (!matchesCat) return false;
      if (q.isEmpty) return true;
      return u.titleAr.toLowerCase().contains(q) ||
          u.titleEn.toLowerCase().contains(q) ||
          u.titleDe.toLowerCase().contains(q) ||
          u.exampleDe.toLowerCase().contains(q) ||
          u.caseTag.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  ReflexiveDrillItem? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get accuracyRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  ReflexiveReciprocalState copyWith({
    ReflexiveCategory? selectedCategory,
    bool clearCategory = false,
    String? searchQuery,
    bool? showRules,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return ReflexiveReciprocalState(
      allUnits: allUnits,
      allDrills: allDrills,
      selectedCategory:
          clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      searchQuery: searchQuery ?? this.searchQuery,
      showRules: showRules ?? this.showRules,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class ReflexiveReciprocalController extends ChangeNotifier {
  ReflexiveReciprocalController({ReflexiveReciprocalRepository? repository})
      : _repository = repository ?? const ReflexiveReciprocalRepository() {
    _state = ReflexiveReciprocalState(
      allUnits: _repository.getUnits(),
      allDrills: _repository.getDrills(),
    );
  }

  final ReflexiveReciprocalRepository _repository;
  late ReflexiveReciprocalState _state;

  ReflexiveReciprocalState get state => _state;

  void selectCategory(ReflexiveCategory? category) {
    if (category == null) {
      _state = _state.copyWith(clearCategory: true);
    } else {
      _state = _state.copyWith(selectedCategory: category);
    }
    notifyListeners();
  }

  void updateSearch(String query) {
    _state = _state.copyWith(searchQuery: query);
    notifyListeners();
  }

  void toggleRules() {
    _state = _state.copyWith(showRules: !_state.showRules);
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
