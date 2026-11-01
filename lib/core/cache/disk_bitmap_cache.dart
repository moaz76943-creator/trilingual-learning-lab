import 'dart:typed_data';
import '../utils/logger.dart';

/// كاش ذاكرة للصور المعالجة مسبقاً لمنع إعادة تكرار حسابات المنحنيات المتجهية المعقدة
class DiskBitmapCache {
  static final DiskBitmapCache _instance = DiskBitmapCache._internal();
  factory DiskBitmapCache() => _instance;
  DiskBitmapCache._internal();

  final Map<String, Uint8List> _memoryBitmapCache = {};

  bool contains(String key) => _memoryBitmapCache.containsKey(key);

  Uint8List? get(String key) {
    return _memoryBitmapCache[key];
  }

  void put(String key, Uint8List bytes) {
    if (_memoryBitmapCache.length >= 100) {
      _memoryBitmapCache.remove(_memoryBitmapCache.keys.first);
    }
    _memoryBitmapCache[key] = bytes;
  }

  void clear() {
    _memoryBitmapCache.clear();
    logger.d('تم إفراغ كاش الرسوم المعالجة', 'DiskBitmapCache');
  }
}

final diskBitmapCache = DiskBitmapCache();
