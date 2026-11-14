import 'package:flutter/foundation.dart';

import '../data/interrogative_syntax_repository.dart';
import '../models/interrogative_syntax_models.dart';

@immutable
class InterrogativeSyntaxState {
  const InterrogativeSyntaxState({
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

  final List<InterrogativeLessonUnit> allUnits;
  final List<InterrogativeLessonUnit> filteredUnits;
  final List<InterrogativeDrillItem> drills;
  final InterrogativeCategory? selectedCategory;
  final String searchQuery;
  final bool showRules;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int answeredCount;
  final int correctCount;

  InterrogativeDrillItem? get currentDrill =>
      drills.isEmpty ? null : drills[currentDrillIndex % drills.length];

  double get accuracyRatio =>
      answeredCount == 0 ? 0.0 : correctCount / answeredCount;

  InterrogativeSyntaxState copyWith({
    List<InterrogativeLessonUnit>? allUnits,
    List<InterrogativeLessonUnit>? filteredUnits,
    List<InterrogativeDrillItem>? drills,
    InterrogativeCategory? selectedCategory,
    bool clearCategory = false,
    String? searchQuery,
    bool? showRules,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? answeredCount,
    int? correctCount,
  }) {
    return InterrogativeSyntaxState(
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

class InterrogativeSyntaxController extends ChangeNotifier {
  InterrogativeSyntaxController({InterrogativeSyntaxRepository? repository})
      : _repository = repository ?? const InterrogativeSyntaxRepository() {
    final units = _repository.getUnits();
    final drills = _repository.getDrills();
    _state = InterrogativeSyntaxState(
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

  final InterrogativeSyntaxRepository _repository;
  late InterrogativeSyntaxState _state;

  InterrogativeSyntaxState get state => _state;

  void selectCategory(InterrogativeCategory? category) {
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
          unit.syntaxTag.toLowerCase().contains(q);
    }).toList();

    _state = _state.copyWith(filteredUnits: filtered);
    notifyListeners();
  }
}
