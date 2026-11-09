import 'package:flutter/material.dart';

/// Central Material Design 3 theme for Trilingual Learning Lab.
/// Supports system dark mode, high-contrast accessibility, and font scaling.
class AppTheme {
  static const Color _seedColor = Color(0xFF00897B); // Teal 600 – educational, calm

  static ThemeData get light => _buildTheme(Brightness.light, contrastLevel: 0.0);
  static ThemeData get dark => _buildTheme(Brightness.dark, contrastLevel: 0.0);
  static ThemeData get highContrastLight =>
      _buildTheme(Brightness.light, contrastLevel: 1.0);
  static ThemeData get highContrastDark =>
      _buildTheme(Brightness.dark, contrastLevel: 1.0);

  static ThemeData _buildTheme(Brightness brightness, {required double contrastLevel}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot,
      contrastLevel: contrastLevel,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,
      scaffoldBackgroundColor: colorScheme.surface,
      // Typography that scales with system font size (accessibility)
      textTheme: _textTheme(colorScheme),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 3,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 3,
        backgroundColor: colorScheme.surfaceContainer,
        indicatorColor: colorScheme.secondaryContainer,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      // Ensure minimum touch targets for accessibility
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static TextTheme _textTheme(ColorScheme scheme) {
    const base = TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, height: 1.12),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400, height: 1.16),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, height: 1.22),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, height: 1.25),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, height: 1.29),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, height: 1.33),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, height: 1.27),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.50),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.43),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.50),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.43),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.33),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.43),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 1.33),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, height: 1.45),
    );

    return base.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
  }
}
