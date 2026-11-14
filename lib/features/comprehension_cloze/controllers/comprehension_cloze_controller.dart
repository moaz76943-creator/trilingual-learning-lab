import 'package:flutter/foundation.dart';

import '../data/comprehension_cloze_repository.dart';
import '../models/comprehension_cloze_models.dart';

@immutable
class ComprehensionClozeState {
  const ComprehensionClozeState({
    required this.allPassages,
    required this.allClozeItems,
    this.selectedDomain,
    this.searchQuery = '',
    this.showParallelTranslations = true,
    this.showGlossaryTerms = true,
    this.currentClozeIndex = 0,
    this.selectedOptionIndex,
    this.correctCount = 0,
    this.answeredCount = 0,
  });

  final List<TrilingualReadingPassage> allPassages;
  final List<ClozeBlankItem> allClozeItems;
  final PassageDomain? selectedDomain;
  final String searchQuery;
  final bool showParallelTranslations;
  final bool showGlossaryTerms;
  final int currentClozeIndex;
  final int? selectedOptionIndex;
  final int correctCount;
  final int answeredCount;

  List<TrilingualReadingPassage> get filteredPassages {
    final q = searchQuery.trim().toLowerCase();
    return allPassages.where((p) {
      final matchesDomain = selectedDomain == null || p.domain == selectedDomain;
      if (!matchesDomain) return false;
      if (q.isEmpty) return true;
      return p.titleAr.toLowerCase().contains(q) ||
          p.titleEn.toLowerCase().contains(q) ||
          p.titleDe.toLowerCase().contains(q) ||
          p.bodyAr.toLowerCase().contains(q) ||
          p.bodyEn.toLowerCase().contains(q) ||
          p.bodyDe.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  ClozeBlankItem? get currentCloze {
    if (allClozeItems.isEmpty) return null;
    final idx = currentClozeIndex.clamp(0, allClozeItems.length - 1);
    return allClozeItems[idx];
  }

  double get accuracyRatio {
    if (answeredCount == 0) return 0.0;
    return correctCount / answeredCount;
  }

  ComprehensionClozeState copyWith({
    PassageDomain? selectedDomain,
    bool clearDomain = false,
    String? searchQuery,
    bool? showParallelTranslations,
    bool? showGlossaryTerms,
    int? currentClozeIndex,
    int? selectedOptionIndex,
    bool clearSelectedOption = false,
    int? correctCount,
    int? answeredCount,
  }) {
    return ComprehensionClozeState(
      allPassages: allPassages,
      allClozeItems: allClozeItems,
      selectedDomain:
          clearDomain ? null : (selectedDomain ?? this.selectedDomain),
      searchQuery: searchQuery ?? this.searchQuery,
      showParallelTranslations:
          showParallelTranslations ?? this.showParallelTranslations,
      showGlossaryTerms: showGlossaryTerms ?? this.showGlossaryTerms,
      currentClozeIndex: currentClozeIndex ?? this.currentClozeIndex,
      selectedOptionIndex: clearSelectedOption
          ? null
          : (selectedOptionIndex ?? this.selectedOptionIndex),
      correctCount: correctCount ?? this.correctCount,
      answeredCount: answeredCount ?? this.answeredCount,
    );
  }
}

class ComprehensionClozeController extends ChangeNotifier {
  ComprehensionClozeController({ComprehensionClozeRepository? repository})
      : _repository = repository ?? const ComprehensionClozeRepository() {
    _state = ComprehensionClozeState(
      allPassages: _repository.getPassages(),
      allClozeItems: _repository.getClozeDrills(),
    );
  }

  final ComprehensionClozeRepository _repository;
  late ComprehensionClozeState _state;

  ComprehensionClozeState get state => _state;

  void selectDomain(PassageDomain? domain) {
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

  void toggleParallelTranslations() {
    _state = _state.copyWith(
      showParallelTranslations: !_state.showParallelTranslations,
    );
    notifyListeners();
  }

  void toggleGlossaryTerms() {
    _state = _state.copyWith(showGlossaryTerms: !_state.showGlossaryTerms);
    notifyListeners();
  }

  void submitClozeAnswer(int optionIndex) {
    final item = _state.currentCloze;
    if (item == null || _state.selectedOptionIndex != null) return;
    final isCorrect = optionIndex == item.correctIndex;
    _state = _state.copyWith(
      selectedOptionIndex: optionIndex,
      answeredCount: _state.answeredCount + 1,
      correctCount: _state.correctCount + (isCorrect ? 1 : 0),
    );
    notifyListeners();
  }

  void nextCloze() {
    if (_state.allClozeItems.isEmpty) return;
    final nextIdx = (_state.currentClozeIndex + 1) % _state.allClozeItems.length;
    _state = _state.copyWith(
      currentClozeIndex: nextIdx,
      clearSelectedOption: true,
    );
    notifyListeners();
  }

  void resetCloze() {
    _state = _state.copyWith(
      currentClozeIndex: 0,
      clearSelectedOption: true,
      correctCount: 0,
      answeredCount: 0,
    );
    notifyListeners();
  }
}
