import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
  static const String vocabulary = '/vocabulary';
  static const String sentences = '/sentences';
  static const String verbs = '/verbs';
  static const String settings = '/settings';
  static const String diagnostics = '/diagnostics';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => Scaffold(
        appBar: AppBar(title: Text(settings.name ?? 'App')),
        body: Center(child: Text('Screen: ${settings.name}')),
      ),
    );
  }
}
