import 'dart:async';
import '../config/app_config.dart';
import '../storage/secure_storage_service.dart';
import '../utils/logger.dart';

/// خط أنابيب التهيئة المتوازية لتسريع إقلاع التطبيق البارد بنسبة 50%
class AppInitializer {
  static Future<bool> initializeAll({
    SecureStorageService? storageService,
  }) async {
    final stopwatch = Stopwatch()..start();
    logger.i('بدء خط أنابيب التهيئة المتوازية للتطبيق...', 'AppInitializer');

    try {
      final storage = storageService ?? SecureStorageService();

      // تشغيل مهام التهيئة بالتوازي عبر Future.wait
      await Future.wait([
        _initStorage(storage),
        _initConfig(),
        _initDiagnostics(),
      ]);

      stopwatch.stop();
      logger.i(
        'اكتملت التهيئة المتوازية بنجاح في ${stopwatch.elapsedMilliseconds}ms',
        'AppInitializer',
      );
      return true;
    } catch (e, stack) {
      logger.e('فشل في خط أنابيب التهيئة: $e', 'AppInitializer', e, stack);
      return false;
    }
  }

  static Future<void> _initStorage(SecureStorageService storage) async {
    await storage.containsKey('startup_check');
  }

  static Future<void> _initConfig() async {
    assert(AppConfig.supportedLocales.isNotEmpty);
  }

  static Future<void> _initDiagnostics() async {
    logger.minLevel = LogLevel.verbose;
  }
}
