import 'dart:async';

/// واجهة حارس المسار الموحدة
abstract class RouteGuard {
  Future<bool> canActivate();
  String get redirectRoute;
}

/// حارس التحقق من اكتمال تحميل وفهرسة المحتوى اللغوي في الذاكرة
class ContentReadyGuard implements RouteGuard {
  static bool _isContentInitialized = false;

  static void markContentReady() {
    _isContentInitialized = true;
  }

  static void reset() {
    _isContentInitialized = false;
  }

  @override
  Future<bool> canActivate() async {
    return _isContentInitialized;
  }

  @override
  String get redirectRoute => '/';
}
