import 'package:flutter/material.dart';
import '../utils/logger.dart';

class RouteHistoryItem {
  final String routeName;
  final DateTime enteredAt;
  DateTime? leftAt;

  RouteHistoryItem({required this.routeName, required this.enteredAt});

  int get durationSeconds =>
      (leftAt ?? DateTime.now()).difference(enteredAt).inSeconds;
}

/// مراقب تنقلات المستخدم عبر الشاشات لقياس زمن البقاء وتحليل مسارات التعلم
class AppNavigationObserver extends NavigatorObserver {
  static final AppNavigationObserver _instance = AppNavigationObserver._internal();
  factory AppNavigationObserver() => _instance;
  AppNavigationObserver._internal();

  final List<RouteHistoryItem> _history = [];
  final int maxHistory = 100;

  List<RouteHistoryItem> get history => List.unmodifiable(_history);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _onEnter(route.settings.name ?? 'unknown');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _onLeave();
    if (previousRoute != null) {
      _onEnter(previousRoute.settings.name ?? 'unknown');
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _onLeave();
    if (newRoute != null) {
      _onEnter(newRoute.settings.name ?? 'unknown');
    }
  }

  void _onEnter(String name) {
    logger.d('دخول الشاشة: $name', 'NavigationObserver');
    final item = RouteHistoryItem(routeName: name, enteredAt: DateTime.now());
    if (_history.length >= maxHistory) {
      _history.removeAt(0);
    }
    _history.add(item);
  }

  void _onLeave() {
    if (_history.isNotEmpty && _history.last.leftAt == null) {
      _history.last.leftAt = DateTime.now();
      logger.d(
        'مغادرة الشاشة: ${_history.last.routeName} (المدة: ${_history.last.durationSeconds}s)',
        'NavigationObserver',
      );
    }
  }

  void clearHistory() => _history.clear();
}

final navObserver = AppNavigationObserver();
