import '../utils/logger.dart';
import '../cache/vector_cache_manager.dart';
import '../assets/svg_cache_manager.dart';

/// نظام تنظيف الكاش الدوري التلقائي لتوفير مساحة التخزين وحماية ذاكرة الهاتف
class CacheCleaner {
  static final CacheCleaner _instance = CacheCleaner._internal();
  factory CacheCleaner() => _instance;
  CacheCleaner._internal();

  /// تشغيل تنظيف الكاش الذاكري والمؤقت
  Future<int> runCleanup() async {
    logger.i('بدء دورة تنظيف الكاش الدوري...', 'CacheCleaner');

    int freedBytes = 0;

    // تنظيف كاش المتجهات الذاكري
    freedBytes += svgCache.currentMemoryBytes;
    svgCache.clear();
    vectorCache.clear();

    logger.i(
      'اكتملت دورة التنظيف وتم تفريغ ${(freedBytes / 1024).toStringAsFixed(1)} KB من الذاكرة',
      'CacheCleaner',
    );
    return freedBytes;
  }
}

final cacheCleaner = CacheCleaner();
