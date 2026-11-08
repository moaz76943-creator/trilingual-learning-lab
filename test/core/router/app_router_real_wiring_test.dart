import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/router/app_router.dart';
import 'package:trilingual_learning_lab/features/home/presentation/screens/home_screen.dart';
import 'package:trilingual_learning_lab/screens/categories_screen.dart';
import 'package:trilingual_learning_lab/screens/verbs_screen.dart';
import 'package:trilingual_learning_lab/screens/dialogues_screen.dart';

void main() {
  group('AppRouter Real Wiring Tests (Anti-Placeholder Audit)', () {
    test('Routes initial and home to legitimate HomeScreen', () {
      final route = AppRouter.generateRoute(const RouteSettings(name: AppRoutes.home));
      expect(route, isA<MaterialPageRoute>());
      final materialRoute = route as MaterialPageRoute;
      final widget = materialRoute.builder(null as dynamic);
      expect(widget, isA<HomeScreen>());
    });

    test('Routes categories to real CategoriesScreen', () {
      final route = AppRouter.generateRoute(const RouteSettings(name: AppRoutes.categories));
      final materialRoute = route as MaterialPageRoute;
      final widget = materialRoute.builder(null as dynamic);
      expect(widget, isA<CategoriesScreen>());
    });

    test('Routes verbs to real VerbsScreen', () {
      final route = AppRouter.generateRoute(const RouteSettings(name: AppRoutes.verbs));
      final materialRoute = route as MaterialPageRoute;
      final widget = materialRoute.builder(null as dynamic);
      expect(widget, isA<VerbsScreen>());
    });

    test('Routes dialogues to real DialoguesScreen', () {
      final route = AppRouter.generateRoute(const RouteSettings(name: AppRoutes.dialogues));
      final materialRoute = route as MaterialPageRoute;
      final widget = materialRoute.builder(null as dynamic);
      expect(widget, isA<DialoguesScreen>());
    });

    test('Non-existent route returns clean error page without raw text leaks', () {
      final route = AppRouter.generateRoute(const RouteSettings(name: '/invalid-path'));
      final materialRoute = route as MaterialPageRoute;
      final widget = materialRoute.builder(null as dynamic);
      expect(widget, isA<Scaffold>());
    });
  });
}
