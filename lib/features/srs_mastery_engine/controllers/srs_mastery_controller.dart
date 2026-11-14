import 'package:flutter/foundation.dart';

import '../data/srs_seed_repository.dart';
import '../models/srs_models.dart';
import '../services/sm2_scheduler_service.dart';

@immutable
class SrsMasteryState {
  const SrsMasteryState({
    required this.cards,
    required this.currentEpochDays,
    this.selectedDomain,
    this.isAnswerRevealed = false,
    this.reviewedTodayCount = 0,
  });

  final List<SrsReviewCard> cards;
  final int currentEpochDays;
  final SrsDeckDomain? selectedDomain;
  final bool isAnswerRevealed;
  final int reviewedTodayCount;

  List<SrsReviewCard> get dueQueue {
    return cards.where((c) {
      final domainMatch = selectedDomain == null || c.domain == selectedDomain;
      return domainMatch && c.isDueOn(currentEpochDays);
    }).toList(growable: false);
  }

  SrsReviewCard? get activeCard => dueQueue.isEmpty ? null : dueQueue.first;

  int get masteredCount => cards.where((c) => c.isMastered).length;

  int get totalLapses => cards.fold(0, (sum, c) => sum + c.lapses);

  double get averageEaseFactor {
    if (cards.isEmpty) return 0.0;
    final total = cards.fold(0.0, (sum, c) => sum + c.easeFactor);
    return double.parse((total / cards.length).toStringAsFixed(2));
  }

  SrsMasteryState copyWith({
    List<SrsReviewCard>? cards,
    int? currentEpochDays,
    SrsDeckDomain? selectedDomain,
    bool clearDomain = false,
    bool? isAnswerRevealed,
    int? reviewedTodayCount,
  }) {
    return SrsMasteryState(
      cards: cards ?? this.cards,
      currentEpochDays: currentEpochDays ?? this.currentEpochDays,
      selectedDomain:
          clearDomain ? null : (selectedDomain ?? this.selectedDomain),
      isAnswerRevealed: isAnswerRevealed ?? this.isAnswerRevealed,
      reviewedTodayCount: reviewedTodayCount ?? this.reviewedTodayCount,
    );
  }
}

class SrsMasteryController extends ChangeNotifier {
  SrsMasteryController({
    SrsSeedRepository? repository,
    Sm2SchedulerService? scheduler,
    int initialEpochDays = 20000,
  })  : _repository = repository ?? const SrsSeedRepository(),
        _scheduler = scheduler ?? const Sm2SchedulerService() {
    _state = SrsMasteryState(
      cards: _repository.loadInitialDeck(todayEpochDays: initialEpochDays),
      currentEpochDays: initialEpochDays,
    );
  }

  final SrsSeedRepository _repository;
  final Sm2SchedulerService _scheduler;
  late SrsMasteryState _state;

  SrsMasteryState get state => _state;

  void selectDomain(SrsDeckDomain? domain) {
    if (domain == null) {
      _state = _state.copyWith(clearDomain: true, isAnswerRevealed: false);
    } else {
      _state = _state.copyWith(selectedDomain: domain, isAnswerRevealed: false);
    }
    notifyListeners();
  }

  void revealAnswer() {
    if (_state.activeCard == null || _state.isAnswerRevealed) return;
    _state = _state.copyWith(isAnswerRevealed: true);
    notifyListeners();
  }

  void submitRecallGrade(RecallGrade grade) {
    final current = _state.activeCard;
    if (current == null) return;

    final updated = _scheduler.scheduleNext(
      card: current,
      grade: grade,
      currentEpochDays: _state.currentEpochDays,
    );

    final nextCards = _state.cards
        .map((c) => c.id == updated.id ? updated : c)
        .toList(growable: false);

    _state = _state.copyWith(
      cards: nextCards,
      isAnswerRevealed: false,
      reviewedTodayCount: _state.reviewedTodayCount + 1,
    );
    notifyListeners();
  }

  void advanceDayForSimulation() {
    _state = _state.copyWith(
      currentEpochDays: _state.currentEpochDays + 1,
      isAnswerRevealed: false,
    );
    notifyListeners();
  }

  void resetAllProgress() {
    _state = SrsMasteryState(
      cards: _repository.loadInitialDeck(
        todayEpochDays: _state.currentEpochDays,
      ),
      currentEpochDays: _state.currentEpochDays,
      selectedDomain: _state.selectedDomain,
    );
    notifyListeners();
  }
}
