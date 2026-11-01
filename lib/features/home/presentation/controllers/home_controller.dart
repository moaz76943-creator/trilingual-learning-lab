import 'package:flutter/material.dart';
import '../../../../core/events/app_event_bus.dart';
import '../../../../core/storage/secure_storage_service.dart';

class HomeStats {
  final int wordsLearned;
  final int streakDays;
  final int dailyGoal;
  final int todayReviewsCount;

  const HomeStats({
    this.wordsLearned = 0,
    this.streakDays = 0,
    this.dailyGoal = 10,
    this.todayReviewsCount = 0,
  });

  double get dailyGoalProgress =>
      dailyGoal == 0 ? 0.0 : (todayReviewsCount / dailyGoal).clamp(0.0, 1.0);
}

/// متحكم الشاشة الرئيسية التفاعلي HomeDashboardController
class HomeController extends ChangeNotifier {
  final SecureStorageService _storage;
  HomeStats _stats = const HomeStats();
  bool _isLoading = false;

  HomeController(this._storage) {
    _listenToEvents();
  }

  HomeStats get stats => _stats;
  bool get isLoading => _isLoading;

  void _listenToEvents() {
    eventBus.on<StreakUpdatedEvent>().listen((event) {
      _stats = HomeStats(
        wordsLearned: _stats.wordsLearned,
        streakDays: event.streakDays,
        dailyGoal: _stats.dailyGoal,
        todayReviewsCount: _stats.todayReviewsCount,
      );
      notifyListeners();
    });

    eventBus.on<WordMasteredEvent>().listen((event) {
      _stats = HomeStats(
        wordsLearned: _stats.wordsLearned + 1,
        streakDays: _stats.streakDays,
        dailyGoal: _stats.dailyGoal,
        todayReviewsCount: _stats.todayReviewsCount + 1,
      );
      notifyListeners();
    });
  }

  Future<void> loadDashboardData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 100));
    _stats = const HomeStats(
      wordsLearned: 5435,
      streakDays: 7,
      dailyGoal: 15,
      todayReviewsCount: 12,
    );

    _isLoading = false;
    notifyListeners();
  }
}
