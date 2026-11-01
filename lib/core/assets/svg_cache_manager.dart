import '../cache/lru_cache.dart';
import '../utils/logger.dart';

/// كاش ذاكرة مخصص للرسوم المتجهة بحجم أقصى 50 ميجابايت مع طرد تلقائي
class SvgCacheManager {
  static final SvgCacheManager _instance = SvgCacheManager._internal();
  factory SvgCacheManager() => _instance;
  SvgCacheManager._internal();

  static const int maxMemoryBytes = 50 * 1024 * 1024; // 50 MB
  int _currentMemoryBytes = 0;

  final LRUCache<String, String> _cache = LRUCache<String, String>(capacity: 500);

  int get currentMemoryBytes => _currentMemoryBytes;
  double get currentMemoryMB => _currentMemoryBytes / (1024 * 1024);

  String? get(String key) {
    return _cache.get(key);
  }

  void put(String key, String svgContent) {
    final bytes = svgContent.length * 2; // تقريب حجم النص في ذاكرة UTF-16

    while (_currentMemoryBytes + bytes > maxMemoryBytes && !_cache.isEmpty) {
      final oldestKey = _cache.keys.first;
      final oldestValue = _cache.remove(oldestKey);
      if (oldestValue != null) {
        _currentMemoryBytes -= oldestValue.length * 2;
      }
    }

    _cache.put(key, svgContent);
    _currentMemoryBytes += bytes;
  }

  bool contains(String key) => _cache.containsKey(key);

  void clear() {
    _cache.clear();
    _currentMemoryBytes = 0;
    logger.d('تم إفراغ كاش المتجهات الذاكري بالكامل', 'SvgCacheManager');
  }
}

final svgCache = SvgCacheManager();
