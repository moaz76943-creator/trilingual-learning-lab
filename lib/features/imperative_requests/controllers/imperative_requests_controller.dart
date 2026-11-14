import 'package:flutter/foundation.dart';

import '../data/imperative_requests_repository.dart';
import '../models/imperative_requests_models.dart';

@immutable
class ImperativeRequestsState {
  const ImperativeRequestsState({
    required this.allUnits,
    required this.filteredUnits,
    required this.drills,
    required this.selectedCategory,
    required this.searchQuery,
    required this.showRules,
    required this.currentDrillIndex,
    required this.selectedOptionIndex,
    required this.answeredCount,
    required this.correctCount,
  });

  final List<ImperativeLessonUnit> allUnits;
  final List<ImperativeLessonUnit> filteredUnits;
  final List<ImperativeDrillItem> drills;
  final ImperativeCategory? selectedCategory;
  final String searchQuery;
  final bool showRules;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int answeredCount;
  final int correctCount;

  ImperativeDrillItem? get currentDrill =>
      drills.isEmpty ? null : drills[currentDrillIndex % drills.length];

  double get accuracyRatio =>
      answeredCount == 0 ? 0.0 : correctCount / answeredCount;

  ImperativeRequestsState copyWith({
    List<ImperativeLessonUnit>? allUnits,
    List<ImperativeLessonUnit>? filteredUnits,
    List<ImperativeDrillItem>? drills,
    ImperativeCategory? selectedCategory,
    bool clearCategory = false,
    String? searchQuery,
    bool? showRules,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? answeredCount,
    int? correctCount,
  }) {
    return ImperativeRequestsState(
      allUnits: allUnits ?? this.allUnits,
      filteredUnits: filteredUnits ?? this.filteredUnits,
      drills: drills ?? this.drills,
      selectedCategory: clearCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
      searchQuery: searchQuery ?? this.searchQuery,
      showRules: showRules ?? this.showRules,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      answeredCount: answeredCount ?? this.answeredCount,
      correctCount: correctCount ?? this.correctCount,
    );
  }
}

class ImperativeRequestsController extends ChangeNotifier {
  ImperativeRequestsController({ImperativeRequestsRepository? repository})
      : _repository = repository ?? const ImperativeRequestsRepository() {
    final units = _repository.getUnits();
    final drills = _repository.getDrills();
    _state = ImperativeRequestsState(
      allUnits: units,
      filteredUnits: units,
      drills: drills,
      selectedCategory: null,
      searchQuery: '',
      showRules: true,
      currentDrillIndex: 0,
      selectedOptionIndex: null,
      answeredCount: 0,
      correctCount: 0,
    );
  }

  final ImperativeRequestsRepository _repository;
  late ImperativeRequestsState _state;

  ImperativeRequestsState get state => _state;

  void selectCategory(ImperativeCategory? category) {
    _state = _state.copyWith(
      selectedCategory: category,
      clearCategory: category == null,
    );
    _applyFilters();
  }

  void updateSearch(String query) {
    _state = _state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void toggleRules() {
    _state = _state.copyWith(showRules: !_state.showRules);
    notifyListeners();
  }

  void submitAnswer(int optionIndex) {
    if (_state.selectedOptionIndex != null) return;
    final drill = _state.currentDrill;
    if (drill == null) return;

    final isCorrect = optionIndex == drill.correctIndex;
    _state = _state.copyWith(
      selectedOptionIndex: optionIndex,
      answeredCount: _state.answeredCount + 1,
      correctCount: _state.correctCount + (isCorrect ? 1 : 0),
    );
    notifyListeners();
  }

  void nextDrill() {
    if (_state.drills.isEmpty) return;
    final nextIndex = (_state.currentDrillIndex + 1) % _state.drills.length;
    _state = _state.copyWith(
      currentDrillIndex: nextIndex,
      clearSelectedOption: true,
    );
    notifyListeners();
  }

  void resetDrills() {
    _state = _state.copyWith(
      currentDrillIndex: 0,
      clearSelectedOption: true,
      answeredCount: 0,
      correctCount: 0,
    );
    notifyListeners();
  }

  void _applyFilters() {
    final q = _state.searchQuery.trim().toLowerCase();
    final cat = _state.selectedCategory;
    final filtered = _state.allUnits.where((unit) {
      if (cat != null && unit.category != cat) return false;
      if (q.isEmpty) return true;
      return unit.titleAr.toLowerCase().contains(q) ||
          unit.titleEn.toLowerCase().contains(q) ||
          unit.titleDe.toLowerCase().contains(q) ||
          unit.exampleAr.toLowerCase().contains(q) ||
          unit.exampleEn.toLowerCase().contains(q) ||
          unit.exampleDe.toLowerCase().contains(q) ||
          unit.moodTag.toLowerCase().contains(q);
    }).toList();

    _state = _state.copyWith(filteredUnits: filtered);
    notifyListeners();
  }
}
