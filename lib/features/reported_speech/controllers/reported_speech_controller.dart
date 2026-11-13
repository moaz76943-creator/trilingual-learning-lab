import 'package:flutter/foundation.dart';

import '../data/reported_speech_repository.dart';
import '../models/reported_speech_models.dart';

@immutable
class ReportedSpeechState {
  const ReportedSpeechState({
    required this.allScenarios,
    required this.allDrills,
    this.selectedCategory,
    this.searchQuery = '',
    this.showIndirectMode = true,
    this.highlightDeictics = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctAnswers = 0,
    this.answeredCount = 0,
  });

  final List<ReportedSpeechScenario> allScenarios;
  final List<ReportedSpeechDrill> allDrills;
  final ReportedSpeechCategory? selectedCategory;
  final String searchQuery;
  final bool showIndirectMode;
  final bool highlightDeictics;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctAnswers;
  final int answeredCount;

  List<ReportedSpeechScenario> get filteredScenarios {
    final normalizedQuery = searchQuery.trim().toLowerCase();
    return allScenarios.where((scenario) {
      final matchesCategory =
          selectedCategory == null || scenario.category == selectedCategory;
      if (!matchesCategory) return false;
      if (normalizedQuery.isEmpty) return true;
      return scenario.titleAr.toLowerCase().contains(normalizedQuery) ||
          scenario.titleEn.toLowerCase().contains(normalizedQuery) ||
          scenario.titleDe.toLowerCase().contains(normalizedQuery) ||
          scenario.directAr.toLowerCase().contains(normalizedQuery) ||
          scenario.indirectAr.toLowerCase().contains(normalizedQuery) ||
          scenario.directDe.toLowerCase().contains(normalizedQuery) ||
          scenario.indirectDe.toLowerCase().contains(normalizedQuery) ||
          scenario.directEn.toLowerCase().contains(normalizedQuery) ||
          scenario.indirectEn.toLowerCase().contains(normalizedQuery);
    }).toList(growable: false);
  }

  ReportedSpeechDrill? get currentDrill {
    if (allDrills.isEmpty) return null;
    final safeIndex = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[safeIndex];
  }

  double get masteryRatio {
    if (answeredCount == 0) return 0.0;
    return correctAnswers / answeredCount;
  }

  ReportedSpeechState copyWith({
    ReportedSpeechCategory? selectedCategory,
    bool clearCategory = false,
    String? searchQuery,
    bool? showIndirectMode,
    bool? highlightDeictics,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctAnswers,
    int? answeredCount,
  }) {
    return ReportedSpeechState(
      allScenarios: allScenarios,
      allDrills: allDrills,
      selectedCategory:
          clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      searchQuery: searchQuery ?? this.searchQuery,
      showIndirectMode: showIndirectMode ?? this.showIndirectMode,
      highlightDeictics: highlightDeictics ?? this.highlightDeictics,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctAnswers: correctAnswers ?? this.correctAnswers,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class ReportedSpeechController extends ChangeNotifier {
  ReportedSpeechController({ReportedSpeechRepository? repository})
      : _repository = repository ?? const ReportedSpeechRepository() {
    _state = ReportedSpeechState(
      allScenarios: _repository.getScenarios(),
      allDrills: _repository.getDrills(),
    );
  }

  final ReportedSpeechRepository _repository;
  late ReportedSpeechState _state;

  ReportedSpeechState get state => _state;

  void selectCategory(ReportedSpeechCategory? category) {
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

  void toggleSpeechMode() {
    _state = _state.copyWith(showIndirectMode: !_state.showIndirectMode);
    notifyListeners();
  }

  void toggleDeicticHighlights() {
    _state = _state.copyWith(highlightDeictics: !_state.highlightDeictics);
    notifyListeners();
  }

  void submitDrillAnswer(int optionIndex) {
    final drill = _state.currentDrill;
    if (drill == null || _state.selectedOptionIndex != null) return;
    final isCorrect = optionIndex == drill.correctIndex;
    _state = _state.copyWith(
      selectedOptionIndex: optionIndex,
      answeredCount: _state.answeredCount + 1,
      correctAnswers: _state.correctAnswers + (isCorrect ? 1 : 0),
    );
    notifyListeners();
  }

  void nextDrill() {
    if (_state.allDrills.isEmpty) return;
    final nextIndex = (_state.currentDrillIndex + 1) % _state.allDrills.length;
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
      correctAnswers: 0,
      answeredCount: 0,
    );
    notifyListeners();
  }
}
