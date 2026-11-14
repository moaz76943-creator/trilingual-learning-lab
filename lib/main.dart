import 'package:flutter/material.dart';

import 'features/system_diagnostics/screens/trilingual_master_hub_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TrilingualLearningLabApp());
}

class TrilingualLearningLabApp extends StatelessWidget {
  const TrilingualLearningLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trilingual Learning Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF0D6E6E),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF0D6E6E),
        brightness: Brightness.dark,
      ),
      home: const TrilingualMasterHubScreen(),
    );
  }
}
