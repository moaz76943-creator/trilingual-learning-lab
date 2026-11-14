import 'package:flutter/foundation.dart';

import '../data/nominal_agreement_repository.dart';
import '../models/nominal_agreement_models.dart';

@immutable
class NominalAgreementState {
  const NominalAgreementState({
    required this.allLessons,
    required this.allDrills,
    this.selectedAxis,
    this.searchQuery = '',
    this.showRules = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<NominalAgreementLesson> allLessons;
  final List<NominalAgreementDrill> allDrills;
  final DeclensionAgreementAxis? selectedAxis;
  final String searchQuery;
  final bool showRules;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<NominalAgreementLesson> get filteredLessons {
    final q = searchQuery.trim().toLowerCase();
    return allLessons.where((lesson) {
      final matchesAxis = selectedAxis == null || lesson.axis == selectedAxis;
      if (!matchesAxis) return false;
      if (q.isEmpty) return true;
      return lesson.titleAr.toLowerCase().contains(q) ||
          lesson.titleEn.toLowerCase().contains(q) ||
          lesson.titleDe.toLowerCase().contains(q) ||
          lesson.exampleAr.toLowerCase().contains(q) ||
          lesson.exampleDe.toLowerCase().contains(q) ||
          lesson.declensionPatternTag.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  NominalAgreementDrill? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get accuracyRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  NominalAgreementState copyWith({
    DeclensionAgreementAxis? selectedAxis,
    bool clearAxis = false,
    String? searchQuery,
    bool? showRules,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return NominalAgreementState(
      allLessons: allLessons,
      allDrills: allDrills,
      selectedAxis: clearAxis ? null : (selectedAxis ?? this.selectedAxis),
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

class NominalAgreementController extends ChangeNotifier {
  NominalAgreementController({NominalAgreementRepository? repository})
      : _repository = repository ?? const NominalAgreementRepository() {
    _state = NominalAgreementState(
      allLessons: _repository.getLessons(),
      allDrills: _repository.getDrills(),
    );
  }

  final NominalAgreementRepository _repository;
  late NominalAgreementState _state;

  NominalAgreementState get state => _state;

  void selectAxis(DeclensionAgreementAxis? axis) {
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
