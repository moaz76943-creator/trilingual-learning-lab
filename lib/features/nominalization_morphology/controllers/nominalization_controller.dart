import 'package:flutter/foundation.dart';

import '../data/nominalization_repository.dart';
import '../models/nominalization_models.dart';

@immutable
class NominalizationState {
  const NominalizationState({
    required this.allLessons,
    required this.allDrills,
    this.selectedType,
    this.searchQuery = '',
    this.showNominalStyle = true,
    this.showMatrix = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<NominalizationLesson> allLessons;
  final List<NominalizationDrill> allDrills;
  final NominalizationPatternType? selectedType;
  final String searchQuery;
  final bool showNominalStyle;
  final bool showMatrix;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<NominalizationLesson> get filteredLessons {
    final q = searchQuery.trim().toLowerCase();
    return allLessons.where((lesson) {
      final matchesType = selectedType == null || lesson.type == selectedType;
      if (!matchesType) return false;
      if (q.isEmpty) return true;
      return lesson.titleAr.toLowerCase().contains(q) ||
          lesson.titleEn.toLowerCase().contains(q) ||
          lesson.titleDe.toLowerCase().contains(q) ||
          lesson.nominalFormAr.toLowerCase().contains(q) ||
          lesson.nominalFormEn.toLowerCase().contains(q) ||
          lesson.nominalFormDe.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  NominalizationDrill? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get masteryPercentage {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  NominalizationState copyWith({
    NominalizationPatternType? selectedType,
    bool clearType = false,
    String? searchQuery,
    bool? showNominalStyle,
    bool? showMatrix,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return NominalizationState(
      allLessons: allLessons,
      allDrills: allDrills,
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
      searchQuery: searchQuery ?? this.searchQuery,
      showNominalStyle: showNominalStyle ?? this.showNominalStyle,
      showMatrix: showMatrix ?? this.showMatrix,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class NominalizationController extends ChangeNotifier {
  NominalizationController({NominalizationRepository? repository})
      : _repository = repository ?? const NominalizationRepository() {
    _state = NominalizationState(
      allLessons: _repository.getLessons(),
      allDrills: _repository.getDrills(),
    );
  }

  final NominalizationRepository _repository;
  late NominalizationState _state;

  NominalizationState get state => _state;

  void selectType(NominalizationPatternType? type) {
    if (type == null) {
      _state = _state.copyWith(clearType: true);
    } else {
      _state = _state.copyWith(selectedType: type);
    }
    notifyListeners();
  }

  void updateSearch(String query) {
    _state = _state.copyWith(searchQuery: query);
    notifyListeners();
  }

  void toggleStyleMode() {
    _state = _state.copyWith(showNominalStyle: !_state.showNominalStyle);
    notifyListeners();
  }

  void toggleMatrix() {
    _state = _state.copyWith(showMatrix: !_state.showMatrix);
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
