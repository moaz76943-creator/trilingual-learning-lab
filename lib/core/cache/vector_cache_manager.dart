import '../utils/logger.dart';
import 'lru_cache.dart';

/// كاش رسومات المتجهات Vector Memory Cache لمنع إعادة قراءة ملفات SVG من القرص
class VectorCacheManager {
  static final VectorCacheManager _instance = VectorCacheManager._internal();
  factory VectorCacheManager() => _instance;
  VectorCacheManager._internal();

  final LRUCache<String, String> _svgStringCache = LRUCache<String, String>(capacity: 250);
  int _hits = 0;
  int _misses = 0;

  int get hits => _hits;
  int get misses => _misses;
  double get hitRate => (_hits + _misses) == 0 ? 0.0 : _hits / (_hits + _misses);

  String? getSvg(String assetPath) {
    final cached = _svgStringCache.get(assetPath);
    if (cached != null) {
      _hits++;
      return cached;
    }
    _misses++;
    return null;
  }

  void putSvg(String assetPath, String svgContent) {
    _svgStringCache.put(assetPath, svgContent);
  }

  bool contains(String assetPath) => _svgStringCache.containsKey(assetPath);

  void clear() {
    _svgStringCache.clear();
    _hits = 0;
    _misses = 0;
    logger.d('تم تنظيف كاش رسومات المتجهات', 'VectorCacheManager');
  }
}

final vectorCache = VectorCacheManager();
