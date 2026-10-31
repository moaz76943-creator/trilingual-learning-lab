import 'dart:async';
import '../utils/logger.dart';

class PerformanceMetric {
  final String operation;
  final int durationMs;
  final DateTime timestamp;
  final bool isSlow; // استغرقت أكثر من 16 ميلي ثانية (هبوط في معدل 60 إطاراً)

  PerformanceMetric({
    required this.operation,
    required this.durationMs,
    DateTime? timestamp,
  })  : timestamp = timestamp ?? DateTime.now(),
        isSlow = durationMs > 16;

  @override
  String toString() =>
      'Metric($operation: ${durationMs}ms${isSlow ? ' ⚠️ بطء رُصد' : ''})';
}

/// متتبع الأداء اللحظي لقياس سرعة المعالجة ورصد أي تهنيج في واجهة المستخدم
class PerformanceTracker {
  static final PerformanceTracker _instance = PerformanceTracker._internal();
  factory PerformanceTracker() => _instance;
  PerformanceTracker._internal();

  final List<PerformanceMetric> _metrics = [];
  final int maxHistory = 200;

  /// تتبع مدة تنفيذ أي كتلة برمجية غير متزامنة
  Future<T> trace<T>(String operationName, Future<T> Function() block) async {
    final stopwatch = Stopwatch()..start();
    try {
      return await block();
    } finally {
      stopwatch.stop();
      final ms = stopwatch.elapsedMilliseconds;
      _record(operationName, ms);
    }
  }

  /// تتبع مدة تنفيذ كتلة متزامنة
  T traceSync<T>(String operationName, T Function() block) {
    final stopwatch = Stopwatch()..start();
    try {
      return block();
    } finally {
      stopwatch.stop();
      final ms = stopwatch.elapsedMilliseconds;
      _record(operationName, ms);
    }
  }

  void _record(String operation, int durationMs) {
    final metric = PerformanceMetric(operation: operation, durationMs: durationMs);
    if (_metrics.length >= maxHistory) {
      _metrics.removeAt(0);
    }
    _metrics.add(metric);

    if (metric.isSlow) {
      logger.w('عملية بطيئة تم رصدها: $operation استغرقت ${durationMs}ms', 'PerformanceTracker');
    }
  }

  List<PerformanceMetric> getMetrics() => List.unmodifiable(_metrics);

  List<PerformanceMetric> getSlowMetrics() =>
      _metrics.where((m) => m.isSlow).toList();

  void clear() => _metrics.clear();
}

final perfTracker = PerformanceTracker();
