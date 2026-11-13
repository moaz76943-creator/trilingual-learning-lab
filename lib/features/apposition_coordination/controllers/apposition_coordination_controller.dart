import 'package:flutter/foundation.dart';

import '../data/apposition_coordination_repository.dart';
import '../models/apposition_coordination_models.dart';

@immutable
class AppositionCoordinationState {
  const AppositionCoordinationState({
    required this.allItems,
    required this.allDrills,
    this.selectedType,
    this.searchQuery = '',
    this.showGrammarNotes = true,
    this.showMistakeWarnings = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<StructuralComparisonItem> allItems;
  final List<AppositionDrillItem> allDrills;
  final AppositionCoordinationType? selectedType;
  final String searchQuery;
  final bool showGrammarNotes;
  final bool showMistakeWarnings;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<StructuralComparisonItem> get filteredItems {
    final q = searchQuery.trim().toLowerCase();
    return allItems.where((item) {
      final matchesType = selectedType == null || item.type == selectedType;
      if (!matchesType) return false;
      if (q.isEmpty) return true;
      return item.titleAr.toLowerCase().contains(q) ||
          item.titleEn.toLowerCase().contains(q) ||
          item.titleDe.toLowerCase().contains(q) ||
          item.exampleAr.toLowerCase().contains(q) ||
          item.exampleEn.toLowerCase().contains(q) ||
          item.exampleDe.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  AppositionDrillItem? get currentDrill {
    if (allDrills.isEmpty) return null;
    final safeIdx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[safeIdx];
  }

  double get masteryScore {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  AppositionCoordinationState copyWith({
    AppositionCoordinationType? selectedType,
    bool clearType = false,
    String? searchQuery,
    bool? showGrammarNotes,
    bool? showMistakeWarnings,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return AppositionCoordinationState(
      allItems: allItems,
      allDrills: allDrills,
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
      searchQuery: searchQuery ?? this.searchQuery,
      showGrammarNotes: showGrammarNotes ?? this.showGrammarNotes,
      showMistakeWarnings: showMistakeWarnings ?? this.showMistakeWarnings,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class AppositionCoordinationController extends ChangeNotifier {
  AppositionCoordinationController({
    AppositionCoordinationRepository? repository,
  }) : _repository = repository ?? const AppositionCoordinationRepository() {
    _state = AppositionCoordinationState(
      allItems: _repository.getItems(),
      allDrills: _repository.getDrills(),
    );
  }

  final AppositionCoordinationRepository _repository;
  late AppositionCoordinationState _state;

  AppositionCoordinationState get state => _state;

  void selectType(AppositionCoordinationType? type) {
    if (type == null) {
      _state = _state.copyWith(clearType: true);
    } else {
      _state = _state.copyWith(selectedType: type);
    }
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _state = _state.copyWith(searchQuery: query);
    notifyListeners();
  }

  void toggleGrammarNotes() {
    _state = _state.copyWith(showGrammarNotes: !_state.showGrammarNotes);
    notifyListeners();
  }

  void toggleMistakeWarnings() {
    _state = _state.copyWith(showMistakeWarnings: !_state.showMistakeWarnings);
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
