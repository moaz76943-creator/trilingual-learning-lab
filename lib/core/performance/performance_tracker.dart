import '../logging/app_logger.dart';

class PerformanceTracker {
  static final Map<String, Stopwatch> _activeWatches = {};

  static void start(String operationName) {
    final watch = Stopwatch()..start();
    _activeWatches[operationName] = watch;
  }

  static int stop(String operationName) {
    final watch = _activeWatches.remove(operationName);
    if (watch == null) return -1;
    watch.stop();
    final elapsedMs = watch.elapsedMilliseconds;
    if (elapsedMs > 16) {
      AppLogger.warn('Slow operation detected: $operationName took ${elapsedMs}ms', tag: 'PERF');
    }
    return elapsedMs;
  }

  static Future<T> track<T>(String operationName, Future<T> Function() block) async {
    start(operationName);
    try {
      return await block();
    } finally {
      stop(operationName);
    }
  }
}
