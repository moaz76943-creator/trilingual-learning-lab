import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/splash/presentation/screens/splash_screen.dart';

void main() {
  group('SplashScreen Real Bootstrap Gate Tests', () {
    testWidgets('Shows loading progress indicator on initial boot', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SplashScreen(
          customInitializer: () async {
            // Keep pending to verify loading UI
            await Future<void>.delayed(const Duration(seconds: 10));
            return true;
          },
        ),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('مختبر اللغات الثلاث'), findsOneWidget);
    });

    testWidgets('Displays clear failure message and retry button when initialization fails', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: SplashScreen(
          customInitializer: () async => false, // Simulate component failure
        ),
      ));

      await tester.pumpAndSettle();

      expect(find.text('إعادة المحاولة'), findsOneWidget);
      expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
    });
  });
}
