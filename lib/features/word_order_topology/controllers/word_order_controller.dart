import 'package:flutter/foundation.dart';

import '../data/word_order_repository.dart';
import '../models/word_order_models.dart';

@immutable
class WordOrderState {
  const WordOrderState({
    required this.allPatterns,
    required this.allDrills,
    this.selectedTopic,
    this.searchQuery = '',
    this.showSlotBreakdown = true,
    this.showRules = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<WordOrderPattern> allPatterns;
  final List<WordOrderDrill> allDrills;
  final WordOrderTopic? selectedTopic;
  final String searchQuery;
  final bool showSlotBreakdown;
  final bool showRules;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<WordOrderPattern> get filteredPatterns {
    final q = searchQuery.trim().toLowerCase();
    return allPatterns.where((p) {
      final matchesTopic = selectedTopic == null || p.topic == selectedTopic;
      if (!matchesTopic) return false;
      if (q.isEmpty) return true;
      return p.titleAr.toLowerCase().contains(q) ||
          p.titleEn.toLowerCase().contains(q) ||
          p.titleDe.toLowerCase().contains(q) ||
          p.sentenceDe.toLowerCase().contains(q) ||
          p.topologyTag.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  WordOrderDrill? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get accuracyRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  WordOrderState copyWith({
    WordOrderTopic? selectedTopic,
    bool clearTopic = false,
    String? searchQuery,
    bool? showSlotBreakdown,
    bool? showRules,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return WordOrderState(
      allPatterns: allPatterns,
      allDrills: allDrills,
      selectedTopic: clearTopic ? null : (selectedTopic ?? this.selectedTopic),
      searchQuery: searchQuery ?? this.searchQuery,
      showSlotBreakdown: showSlotBreakdown ?? this.showSlotBreakdown,
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

class WordOrderController extends ChangeNotifier {
  WordOrderController({WordOrderRepository? repository})
      : _repository = repository ?? const WordOrderRepository() {
    _state = WordOrderState(
      allPatterns: _repository.getPatterns(),
      allDrills: _repository.getDrills(),
    );
  }

  final WordOrderRepository _repository;
  late WordOrderState _state;

  WordOrderState get state => _state;

  void selectTopic(WordOrderTopic? topic) {
    if (topic == null) {
      _state = _state.copyWith(clearTopic: true);
    } else {
      _state = _state.copyWith(selectedTopic: topic);
    }
    notifyListeners();
  }

  void updateSearch(String query) {
    _state = _state.copyWith(searchQuery: query);
    notifyListeners();
  }

  void toggleSlotBreakdown() {
    _state = _state.copyWith(showSlotBreakdown: !_state.showSlotBreakdown);
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
