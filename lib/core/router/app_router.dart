import 'package:flutter/material.dart';
import 'package:trilingual_learning_lab/features/home/presentation/screens/home_screen.dart';
import 'package:trilingual_learning_lab/screens/categories_screen.dart';
import 'package:trilingual_learning_lab/screens/verbs_screen.dart';
import 'package:trilingual_learning_lab/screens/dialogues_screen.dart';
import 'package:trilingual_learning_lab/screens/sentence_builder_screen.dart';
import 'package:trilingual_learning_lab/screens/prepositions_screen.dart';
import 'package:trilingual_learning_lab/features/search/presentation/screens/search_screen.dart';

/// Routes registry defining authoritative route names across the application.
class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  static const String categories = '/categories';
  static const String verbs = '/verbs';
  static const String dialogues = '/dialogues';
  static const String sentenceBuilder = '/sentence-builder';
  static const String prepositions = '/prepositions';
  static const String search = '/search';
}

/// Authoritative AppRouter linking real functional screens without placeholder mocks.
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeName = settings.name ?? AppRoutes.initial;

    switch (routeName) {
      case AppRoutes.initial:
      case AppRoutes.home:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );

      case AppRoutes.categories:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => const CategoriesScreen(),
        );

      case AppRoutes.verbs:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => const VerbsScreen(),
        );

      case AppRoutes.dialogues:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => const DialoguesScreen(),
        );

      case AppRoutes.sentenceBuilder:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => const SentenceBuilderScreen(),
        );

      case AppRoutes.prepositions:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => const PrepositionsScreen(),
        );

      case AppRoutes.search:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => const SearchScreen(),
        );

      default:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('الصفحة غير موجودة')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.amber),
                  const SizedBox(height: 16),
                  Text(
                    'المسار المطلوب غير متاح: $routeName',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('العودة للرئيسية'),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}
