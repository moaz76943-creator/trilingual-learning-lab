import '../error/result.dart';
import '../error/failures.dart';

class CacheFirstStrategy {
  static Future<Result<T, Failure>> execute<T>({
    required Future<T?> Function() fetchFromCache,
    required Future<T> Function() fetchFromRemote,
    required Future<void> Function(T data) saveToCache,
  }) async {
    try {
      final cached = await fetchFromCache();
      if (cached != null) {
        return Result.success(cached);
      }
      final remote = await fetchFromRemote();
      await saveToCache(remote);
      return Result.success(remote);
    } catch (e) {
      return Result.failure(CacheFailure(e.toString()));
    }
  }
}
