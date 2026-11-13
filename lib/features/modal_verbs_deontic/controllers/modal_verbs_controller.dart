import 'package:flutter/foundation.dart';

import '../data/modal_verbs_repository.dart';
import '../models/modal_verbs_models.dart';

@immutable
class ModalVerbsState {
  const ModalVerbsState({
    required this.allUnits,
    required this.allDrills,
    this.selectedAxis,
    this.searchQuery = '',
    this.showContrastiveForm = true,
    this.showTrapAlerts = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<ModalContrastUnit> allUnits;
  final List<ModalDrillQuestion> allDrills;
  final ModalAxisCategory? selectedAxis;
  final String searchQuery;
  final bool showContrastiveForm;
  final bool showTrapAlerts;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<ModalContrastUnit> get filteredUnits {
    final q = searchQuery.trim().toLowerCase();
    return allUnits.where((unit) {
      final matchesAxis = selectedAxis == null || unit.axis == selectedAxis;
      if (!matchesAxis) return false;
      if (q.isEmpty) return true;
      return unit.titleAr.toLowerCase().contains(q) ||
          unit.titleEn.toLowerCase().contains(q) ||
          unit.titleDe.toLowerCase().contains(q) ||
          unit.deonticOrBaseDe.toLowerCase().contains(q) ||
          unit.epistemicOrContrastDe.toLowerCase().contains(q) ||
          unit.modalTag.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  ModalDrillQuestion? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get masteryRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  ModalVerbsState copyWith({
    ModalAxisCategory? selectedAxis,
    bool clearAxis = false,
    String? searchQuery,
    bool? showContrastiveForm,
    bool? showTrapAlerts,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return ModalVerbsState(
      allUnits: allUnits,
      allDrills: allDrills,
      selectedAxis: clearAxis ? null : (selectedAxis ?? this.selectedAxis),
      searchQuery: searchQuery ?? this.searchQuery,
      showContrastiveForm: showContrastiveForm ?? this.showContrastiveForm,
      showTrapAlerts: showTrapAlerts ?? this.showTrapAlerts,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class ModalVerbsController extends ChangeNotifier {
  ModalVerbsController({ModalVerbsRepository? repository})
      : _repository = repository ?? const ModalVerbsRepository() {
    _state = ModalVerbsState(
      allUnits: _repository.getUnits(),
      allDrills: _repository.getDrills(),
    );
  }

  final ModalVerbsRepository _repository;
  late ModalVerbsState _state;

  ModalVerbsState get state => _state;

  void selectAxis(ModalAxisCategory? axis) {
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

  void toggleContrastiveForm() {
    _state = _state.copyWith(showContrastiveForm: !_state.showContrastiveForm);
    notifyListeners();
  }

  void toggleTrapAlerts() {
    _state = _state.copyWith(showTrapAlerts: !_state.showTrapAlerts);
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
