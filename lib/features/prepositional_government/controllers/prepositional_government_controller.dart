import 'package:flutter/foundation.dart';

import '../data/prepositional_government_repository.dart';
import '../models/prepositional_government_models.dart';

@immutable
class PrepositionalGovernmentState {
  const PrepositionalGovernmentState({
    required this.allPairs,
    required this.allDrills,
    this.selectedDomain,
    this.searchQuery = '',
    this.showContrastPatternB = true,
    this.showValencyRules = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<PrepositionalContrastPair> allPairs;
  final List<PrepositionDrillItem> allDrills;
  final PrepositionDomain? selectedDomain;
  final String searchQuery;
  final bool showContrastPatternB;
  final bool showValencyRules;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<PrepositionalContrastPair> get filteredPairs {
    final q = searchQuery.trim().toLowerCase();
    return allPairs.where((p) {
      final matchesDomain = selectedDomain == null || p.domain == selectedDomain;
      if (!matchesDomain) return false;
      if (q.isEmpty) return true;
      return p.titleAr.toLowerCase().contains(q) ||
          p.titleEn.toLowerCase().contains(q) ||
          p.titleDe.toLowerCase().contains(q) ||
          p.patternAAr.toLowerCase().contains(q) ||
          p.patternADe.toLowerCase().contains(q) ||
          p.patternBDe.toLowerCase().contains(q) ||
          p.germanCaseTag.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  PrepositionDrillItem? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get accuracyRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  PrepositionalGovernmentState copyWith({
    PrepositionDomain? selectedDomain,
    bool clearDomain = false,
    String? searchQuery,
    bool? showContrastPatternB,
    bool? showValencyRules,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return PrepositionalGovernmentState(
      allPairs: allPairs,
      allDrills: allDrills,
      selectedDomain:
          clearDomain ? null : (selectedDomain ?? this.selectedDomain),
      searchQuery: searchQuery ?? this.searchQuery,
      showContrastPatternB: showContrastPatternB ?? this.showContrastPatternB,
      showValencyRules: showValencyRules ?? this.showValencyRules,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class PrepositionalGovernmentController extends ChangeNotifier {
  PrepositionalGovernmentController({
    PrepositionalGovernmentRepository? repository,
  }) : _repository = repository ?? const PrepositionalGovernmentRepository() {
    _state = PrepositionalGovernmentState(
      allPairs: _repository.getPairs(),
      allDrills: _repository.getDrills(),
    );
  }

  final PrepositionalGovernmentRepository _repository;
  late PrepositionalGovernmentState _state;

  PrepositionalGovernmentState get state => _state;

  void selectDomain(PrepositionDomain? domain) {
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

  void toggleContrastPatternB() {
    _state = _state.copyWith(
      showContrastPatternB: !_state.showContrastPatternB,
    );
    notifyListeners();
  }

  void toggleValencyRules() {
    _state = _state.copyWith(showValencyRules: !_state.showValencyRules);
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
