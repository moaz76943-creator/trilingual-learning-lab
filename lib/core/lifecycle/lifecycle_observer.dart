import 'package:flutter/widgets.dart';
import '../utils/logger.dart';

typedef LifecycleCallback = void Function(AppLifecycleState state);

/// مراقب دورة حياة التطبيق لحفظ التقدم التلقائي عند مغادرة الشاشة أو تصغير التطبيق
class AppLifecycleObserver with WidgetsBindingObserver {
  static final AppLifecycleObserver _instance = AppLifecycleObserver._internal();
  factory AppLifecycleObserver() => _instance;
  AppLifecycleObserver._internal();

  final List<LifecycleCallback> _listeners = [];
  AppLifecycleState _currentState = AppLifecycleState.resumed;

  AppLifecycleState get currentState => _currentState;

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
    logger.i('تم تفعيل مراقب دورة حياة التطبيق بنجاح', 'LifecycleObserver');
  }

  void addListener(LifecycleCallback callback) {
    _listeners.add(callback);
  }

  void removeListener(LifecycleCallback callback) {
    _listeners.remove(callback);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _currentState = state;
    logger.d('تغيرت حالة دورة حياة التطبيق إلى: $state', 'LifecycleObserver');

    for (final listener in _listeners) {
      try {
        listener(state);
      } catch (e, stack) {
        logger.e('خطأ أثناء إشعار مستمع دورة الحياة: $e', 'LifecycleObserver', e, stack);
      }
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _listeners.clear();
  }
}

final lifecycleObserver = AppLifecycleObserver();
