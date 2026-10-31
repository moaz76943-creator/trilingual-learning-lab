import 'package:flutter/material.dart';

/// ثوابت أسماء المسارات الرئيسية للتطبيق
class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String categoryDetail = '/category-detail';
  static const String flashcard = '/flashcard';
  static const String sentences = '/sentences';
  static const String quiz = '/quiz';
  static const String settings = '/settings';
}

/// مدير التوجيه والتنقل التصريحي مع تأثيرات انتقال انسيابية
class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(
          const Scaffold(body: Center(child: Text('المختبر اللغوي الثلاثي - جاري التحميل...'))),
          settings,
        );
      case AppRoutes.home:
      default:
        return _buildRoute(
          Scaffold(
            appBar: AppBar(title: const Text('المختبر الثلاثي للغات')),
            body: const Center(child: Text('الواجهة الرئيسية قيد التطوير')),
          ),
          settings,
        );
    }
  }

  static PageRouteBuilder<T> _buildRoute<T>(Widget page, RouteSettings settings) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
