import 'dart:async';
import '../logging/app_logger.dart';

class DeferredAssetPreloader {
  static final Set<String> _loadedKeys = {};

  static Future<void> preloadBatch(List<String> assetKeys) async {
    for (final key in assetKeys) {
      if (_loadedKeys.contains(key)) continue;
      await Future.delayed(const Duration(milliseconds: 10)); // تفادي حجب الـ UI Thread
      _loadedKeys.add(key);
      AppLogger.info('Preloaded vector asset: $key', tag: 'PRELOADER');
    }
  }

  static bool isPreloaded(String key) => _loadedKeys.contains(key);
}
