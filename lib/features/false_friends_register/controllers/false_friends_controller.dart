import 'package:flutter/foundation.dart';

import '../data/false_friends_repository.dart';
import '../models/false_friends_models.dart';

@immutable
class FalseFriendsState {
  const FalseFriendsState({
    required this.allEntries,
    required this.allDrills,
    this.selectedCategory,
    this.searchQuery = '',
    this.showExamples = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<FalseFriendEntry> allEntries;
  final List<FalseFriendDrillItem> allDrills;
  final FalseFriendCategory? selectedCategory;
  final String searchQuery;
  final bool showExamples;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<FalseFriendEntry> get filteredEntries {
    final q = searchQuery.trim().toLowerCase();
    return allEntries.where((e) {
      final matchesCat = selectedCategory == null || e.category == selectedCategory;
      if (!matchesCat) return false;
      if (q.isEmpty) return true;
      return e.germanTerm.toLowerCase().contains(q) ||
          e.englishLookalike.toLowerCase().contains(q) ||
          e.trueGermanMeaningAr.toLowerCase().contains(q) ||
          e.trueEnglishMeaningAr.toLowerCase().contains(q) ||
          e.exampleDe.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  FalseFriendDrillItem? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get accuracyRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  FalseFriendsState copyWith({
    FalseFriendCategory? selectedCategory,
    bool clearCategory = false,
    String? searchQuery,
    bool? showExamples,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return FalseFriendsState(
      allEntries: allEntries,
      allDrills: allDrills,
      selectedCategory:
          clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      searchQuery: searchQuery ?? this.searchQuery,
      showExamples: showExamples ?? this.showExamples,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class FalseFriendsController extends ChangeNotifier {
  FalseFriendsController({FalseFriendsRepository? repository})
      : _repository = repository ?? const FalseFriendsRepository() {
    _state = FalseFriendsState(
      allEntries: _repository.getEntries(),
      allDrills: _repository.getDrills(),
    );
  }

  final FalseFriendsRepository _repository;
  late FalseFriendsState _state;

  FalseFriendsState get state => _state;

  void selectCategory(FalseFriendCategory? category) {
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

  void toggleExamples() {
    _state = _state.copyWith(showExamples: !_state.showExamples);
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
