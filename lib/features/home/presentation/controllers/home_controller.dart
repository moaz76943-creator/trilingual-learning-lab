import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:trilingual_learning_lab/core/events/app_event_bus.dart';
import 'package:trilingual_learning_lab/repositories/progress_repository.dart';
import 'package:trilingual_learning_lab/repositories/srs_repository.dart';

/// State object representing verified, dynamic learner dashboard metrics.
class DashboardMetricsState {
  final int wordsLearned;
  final int streakDays;
  final int dailyGoal;
  final int todayReviewsCount;
  final int dueSrsCardsCount;
  final bool isLoading;

  const DashboardMetricsState({
    this.wordsLearned = 0,
    this.streakDays = 1,
    this.dailyGoal = 20,
    this.todayReviewsCount = 0,
    this.dueSrsCardsCount = 0,
    this.isLoading = false,
  });

  DashboardMetricsState copyWith({
    int? wordsLearned,
    int? streakDays,
    int? dailyGoal,
    int? todayReviewsCount,
    int? dueSrsCardsCount,
    bool? isLoading,
  }) {
    return DashboardMetricsState(
      wordsLearned: wordsLearned ?? this.wordsLearned,
      streakDays: streakDays ?? this.streakDays,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      todayReviewsCount: todayReviewsCount ?? this.todayReviewsCount,
      dueSrsCardsCount: dueSrsCardsCount ?? this.dueSrsCardsCount,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Authoritative HomeController binding real persistent progress to the UI
/// and strictly managing StreamSubscription lifecycles to prevent memory leaks.
class HomeController extends ChangeNotifier {
  final ProgressRepository _progressRepo;
  final SrsRepository _srsRepo;
  final AppEventBus _eventBus;

  DashboardMetricsState _state = const DashboardMetricsState(isLoading: true);
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  bool _isDisposed = false;

  HomeController({
    ProgressRepository? progressRepository,
    SrsRepository? srsRepository,
    AppEventBus? eventBus,
  })  : _progressRepo = progressRepository ?? ProgressRepository(),
        _srsRepo = srsRepository ?? SrsRepository(),
        _eventBus = eventBus ?? AppEventBus() {
    _initSubscriptions();
  }

  DashboardMetricsState get state => _state;
  bool get isDisposed => _isDisposed;

  void _initSubscriptions() {
    // Retain subscription handle explicitly to cancel on dispose
    final sub = _eventBus.on<AppEvent>().listen((event) {
      if (!_isDisposed) {
        refreshDashboardData();
      }
    });
    _subscriptions.add(sub);
  }

  /// Loads verified metrics from persistent storage without fake dummy data.
  Future<void> loadDashboardData() async {
    if (_isDisposed) return;
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      await _progressRepo.loadProgress();
      final progress = _progressRepo.currentProgress;
      final dueCards = _srsRepo.getDueCards();

      if (!_isDisposed) {
        _state = DashboardMetricsState(
          wordsLearned: progress.wordsLearned,
          streakDays: progress.streakDays,
          dailyGoal: progress.dailyGoal,
          todayReviewsCount: progress.todayReviewsCount,
          dueSrsCardsCount: dueCards.length,
          isLoading: false,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading real dashboard metrics: $e');
      if (!_isDisposed) {
        _state = _state.copyWith(isLoading: false);
        notifyListeners();
      }
    }
  }

  Future<void> refreshDashboardData() async {
    await loadDashboardData();
  }

  @override
  void dispose() {
    _isDisposed = true;
    // Cancel all StreamSubscriptions to eliminate memory leaks and callbacks after disposal
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    super.dispose();
  }
}
