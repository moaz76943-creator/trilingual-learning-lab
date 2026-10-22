import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TrilingualApp());
}

class TrilingualApp extends StatelessWidget {
  const TrilingualApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trilingual Learning Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
          surface: const Color(0xFFF8FAFC),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const CategoriesScreen(),
    );
  }
}
