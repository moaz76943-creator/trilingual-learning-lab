import 'package:flutter/foundation.dart';

import '../data/ellipsis_anaphora_repository.dart';
import '../models/ellipsis_anaphora_models.dart';

@immutable
class EllipsisAnaphoraState {
  const EllipsisAnaphoraState({
    required this.allCases,
    required this.allDrills,
    this.selectedType,
    this.searchQuery = '',
    this.showRecoveredForm = false,
    this.showMappingsPanel = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.totalAnswered = 0,
  });

  final List<EllipsisCaseStudy> allCases;
  final List<EllipsisDrillQuestion> allDrills;
  final EllipsisPhenomenonType? selectedType;
  final String searchQuery;
  final bool showRecoveredForm;
  final bool showMappingsPanel;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int totalAnswered;

  List<EllipsisCaseStudy> get filteredCases {
    final q = searchQuery.trim().toLowerCase();
    return allCases.where((c) {
      final typeMatch = selectedType == null || c.type == selectedType;
      if (!typeMatch) return false;
      if (q.isEmpty) return true;
      return c.titleAr.toLowerCase().contains(q) ||
          c.titleEn.toLowerCase().contains(q) ||
          c.titleDe.toLowerCase().contains(q) ||
          c.surfaceAr.toLowerCase().contains(q) ||
          c.surfaceEn.toLowerCase().contains(q) ||
          c.surfaceDe.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  EllipsisDrillQuestion? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get accuracy {
    if (totalAnswered == 0) return 0.0;
    return correctCount / totalAnswered;
  }

  EllipsisAnaphoraState copyWith({
    EllipsisPhenomenonType? selectedType,
    bool clearType = false,
    String? searchQuery,
    bool? showRecoveredForm,
    bool? showMappingsPanel,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearOption = false,
    int? correctCount,
    int? totalAnswered,
  }) {
    return EllipsisAnaphoraState(
      allCases: allCases,
      allDrills: allDrills,
      selectedType: clearType ? null : (selectedType ?? this.selectedType),
      searchQuery: searchQuery ?? this.searchQuery,
      showRecoveredForm: showRecoveredForm ?? this.showRecoveredForm,
      showMappingsPanel: showMappingsPanel ?? this.showMappingsPanel,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex:
          clearOption ? null : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      totalAnswered: totalAnswered ?? this.totalAnswered,
    );
  }
}

class EllipsisAnaphoraController extends ChangeNotifier {
  EllipsisAnaphoraController({EllipsisAnaphoraRepository? repository})
      : _repository = repository ?? const EllipsisAnaphoraRepository() {
    _state = EllipsisAnaphoraState(
      allCases: _repository.getCaseStudies(),
      allDrills: _repository.getDrills(),
    );
  }

  final EllipsisAnaphoraRepository _repository;
  late EllipsisAnaphoraState _state;

  EllipsisAnaphoraState get state => _state;

  void selectType(EllipsisPhenomenonType? type) {
    if (type == null) {
      _state = _state.copyWith(clearType: true);
    } else {
      _state = _state.copyWith(selectedType: type);
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _state = _state.copyWith(searchQuery: query);
    notifyListeners();
  }

  void toggleRecoveredForm() {
    _state = _state.copyWith(showRecoveredForm: !_state.showRecoveredForm);
    notifyListeners();
  }

  void toggleMappingsPanel() {
    _state = _state.copyWith(showMappingsPanel: !_state.showMappingsPanel);
    notifyListeners();
  }

  void answerDrill(int optionIndex) {
    final drill = _state.currentDrill;
    if (drill == null || _state.selectedOptionIndex != null) return;
    final isCorrect = optionIndex == drill.correctIndex;
    _state = _state.copyWith(
      selectedOptionIndex: optionIndex,
      totalAnswered: _state.totalAnswered + 1,
      correctCount: _state.correctCount + (isCorrect ? 1 : 0),
    );
    notifyListeners();
  }

  void nextDrill() {
    if (_state.allDrills.isEmpty) return;
    final nextIdx = (_state.currentDrillIndex + 1) % _state.allDrills.length;
    _state = _state.copyWith(currentDrillIndex: nextIdx, clearOption: true);
    notifyListeners();
  }

  void resetDrills() {
    _state = _state.copyWith(
      currentDrillIndex: 0,
      clearOption: true,
      correctCount: 0,
      totalAnswered: 0,
    );
    notifyListeners();
  }
}
