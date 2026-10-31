import '../errors/failures.dart';
import '../utils/result.dart';

/// استراتيجية الكاش المسبق الذكية لفتح الدروس والمفردات في أقل من 15 ميلي ثانية
class CacheFirstStrategy<T> {
  final Map<String, _CacheEntry<T>> _cache = {};
  final Duration defaultTtl;

  CacheFirstStrategy({this.defaultTtl = const Duration(hours: 12)});

  /// تنفيذ الطلب وفق أولوية الكاش: إرجاع البيانات المحفوظة فوراً إذا كانت صالحة،
  /// واستدعاء المصدر الأصلي وتحديث الكاش عند الحاجة أو عند انتهاء الصلاحية.
  Future<Result<T, Failure>> execute({
    required String cacheKey,
    required Future<Result<T, Failure>> Function() fetchFromSource,
    Duration? customTtl,
    bool forceRefresh = false,
  }) async {
    final now = DateTime.now();
    final ttl = customTtl ?? defaultTtl;

    if (!forceRefresh && _cache.containsKey(cacheKey)) {
      final entry = _cache[cacheKey]!;
      if (now.difference(entry.timestamp) < ttl) {
        return Result.success(entry.data);
      }
    }

    final sourceResult = await fetchFromSource();
    return sourceResult.fold(
      (failure) {
        // في حال فشل المصدر، يتم إرجاع الكاش القديم كبديل أمان بدلاً من الانهيار
        if (_cache.containsKey(cacheKey)) {
          return Result.success(_cache[cacheKey]!.data);
        }
        return Result.failure(failure);
      },
      (freshData) {
        _cache[cacheKey] = _CacheEntry(data: freshData, timestamp: now);
        return Result.success(freshData);
      },
    );
  }

  void invalidate(String cacheKey) {
    _cache.remove(cacheKey);
  }

  void clear() {
    _cache.clear();
  }

  bool hasValid(String cacheKey, [Duration? customTtl]) {
    if (!_cache.containsKey(cacheKey)) return false;
    final ttl = customTtl ?? defaultTtl;
    return DateTime.now().difference(_cache[cacheKey]!.timestamp) < ttl;
  }
}

class _CacheEntry<T> {
  final T data;
  final DateTime timestamp;
  _CacheEntry({required this.data, required this.timestamp});
}
