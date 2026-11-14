import 'package:flutter/foundation.dart';

import '../data/passive_voice_repository.dart';
import '../models/passive_voice_models.dart';

@immutable
class PassiveVoiceState {
  const PassiveVoiceState({
    required this.allUnits,
    required this.allDrills,
    this.selectedType,
    this.searchQuery = '',
    this.showPassiveTransformation = true,
    this.showRules = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<PassiveComparisonUnit> allUnits;
  final List<PassiveDrillQuestion> allDrills;
  final PassiveConstructionType? selectedType;
  final String searchQuery;
  final bool showPassiveTransformation;
  final bool showRules;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<PassiveComparisonUnit> get filteredUnits {
    final q = searchQuery.trim().toLowerCase();
    return allUnits.where((u) {
      final matchesType = selectedType == null || u.type == selectedType;
      if (!matchesType) return false;
      if (q.isEmpty) return true;
      return u.titleAr.toLowerCase().contains(q) ||
          u.titleEn.toLowerCase().contains(q) ||
          u.titleDe.toLowerCase().contains(q) ||
          u.passiveFormDe.toLowerCase().contains(q) ||
          u.auxiliaryTag.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  PassiveDrillQuestion? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get accuracyRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  PassiveVoiceState copyWith({
    PassiveConstructionType? selectedType,
    bool clearType = false,
    String? searchQuery,
    bool? showPassiveTransformation,
    bool? showRules,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return PassiveVoiceState(
      allUnits: allUnits,
      allDrills: allDrills,
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
      searchQuery: searchQuery ?? this.searchQuery,
      showPassiveTransformation:
          showPassiveTransformation ?? this.showPassiveTransformation,
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

class PassiveVoiceController extends ChangeNotifier {
  PassiveVoiceController({PassiveVoiceRepository? repository})
      : _repository = repository ?? const PassiveVoiceRepository() {
    _state = PassiveVoiceState(
      allUnits: _repository.getUnits(),
      allDrills: _repository.getDrills(),
    );
  }

  final PassiveVoiceRepository _repository;
  late PassiveVoiceState _state;

  PassiveVoiceState get state => _state;

  void selectType(PassiveConstructionType? type) {
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

  void togglePassiveMode() {
    _state = _state.copyWith(
      showPassiveTransformation: !_state.showPassiveTransformation,
    );
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
