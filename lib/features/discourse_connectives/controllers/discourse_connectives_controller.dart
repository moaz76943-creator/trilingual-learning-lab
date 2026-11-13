import 'package:flutter/foundation.dart';

import '../data/discourse_connectives_repository.dart';
import '../models/discourse_connectives_models.dart';

@immutable
class DiscourseConnectivesState {
  const DiscourseConnectivesState({
    required this.allTriplets,
    required this.allDrills,
    this.selectedRelation,
    this.searchQuery = '',
    this.showAdverbialAndPrepVariant = true,
    this.showWordOrderRules = true,
    this.currentDrillIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<ConnectiveSyntaxTriplet> allTriplets;
  final List<DiscourseDrillItem> allDrills;
  final DiscourseRelationType? selectedRelation;
  final String searchQuery;
  final bool showAdverbialAndPrepVariant;
  final bool showWordOrderRules;
  final int currentDrillIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<ConnectiveSyntaxTriplet> get filteredTriplets {
    final q = searchQuery.trim().toLowerCase();
    return allTriplets.where((t) {
      final matchesRelation =
          selectedRelation == null || t.relation == selectedRelation;
      if (!matchesRelation) return false;
      if (q.isEmpty) return true;
      return t.titleAr.toLowerCase().contains(q) ||
          t.titleEn.toLowerCase().contains(q) ||
          t.titleDe.toLowerCase().contains(q) ||
          t.subordinatingDe.toLowerCase().contains(q) ||
          t.adverbialOrPrepDe.toLowerCase().contains(q) ||
          t.germanPositionTag.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  DiscourseDrillItem? get currentDrill {
    if (allDrills.isEmpty) return null;
    final idx = currentDrillIndex.clamp(0, allDrills.length - 1);
    return allDrills[idx];
  }

  double get masteryRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  DiscourseConnectivesState copyWith({
    DiscourseRelationType? selectedRelation,
    bool clearRelation = false,
    String? searchQuery,
    bool? showAdverbialAndPrepVariant,
    bool? showWordOrderRules,
    int? currentDrillIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return DiscourseConnectivesState(
      allTriplets: allTriplets,
      allDrills: allDrills,
      selectedRelation:
          clearRelation ? null : (selectedRelation ?? this.selectedRelation),
      searchQuery: searchQuery ?? this.searchQuery,
      showAdverbialAndPrepVariant:
          showAdverbialAndPrepVariant ?? this.showAdverbialAndPrepVariant,
      showWordOrderRules: showWordOrderRules ?? this.showWordOrderRules,
      currentDrillIndex: currentDrillIndex ?? this.currentDrillIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class DiscourseConnectivesController extends ChangeNotifier {
  DiscourseConnectivesController({
    DiscourseConnectivesRepository? repository,
  }) : _repository = repository ?? const DiscourseConnectivesRepository() {
    _state = DiscourseConnectivesState(
      allTriplets: _repository.getTriplets(),
      allDrills: _repository.getDrills(),
    );
  }

  final DiscourseConnectivesRepository _repository;
  late DiscourseConnectivesState _state;

  DiscourseConnectivesState get state => _state;

  void selectRelation(DiscourseRelationType? relation) {
    if (relation == null) {
      _state = _state.copyWith(clearRelation: true);
    } else {
      _state = _state.copyWith(selectedRelation: relation);
    }
    notifyListeners();
  }

  void updateSearch(String query) {
    _state = _state.copyWith(searchQuery: query);
    notifyListeners();
  }

  void toggleAdverbialVariant() {
    _state = _state.copyWith(
      showAdverbialAndPrepVariant: !_state.showAdverbialAndPrepVariant,
    );
    notifyListeners();
  }

  void toggleWordOrderRules() {
    _state = _state.copyWith(showWordOrderRules: !_state.showWordOrderRules);
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
