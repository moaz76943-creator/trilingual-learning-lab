import 'dart:collection';

enum LogLevel { verbose, debug, info, warning, error, fatal }

class LogEntry {
  final LogLevel level;
  final String message;
  final String? tag;
  final Object? error;
  final StackTrace? stackTrace;
  final DateTime timestamp;

  LogEntry({
    required this.level,
    required this.message,
    this.tag,
    this.error,
    this.stackTrace,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() {
    final timeStr = timestamp.toIso8601String().substring(11, 19);
    final tagStr = tag != null ? '[$tag] ' : '';
    return '[$timeStr] ${level.name.toUpperCase()}: $tagStr$message';
  }
}

/// مسجل الأحداث النواتي الموحد مع دعم الألوان وذاكرة تخزين مؤقتة للأخطاء
class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;
  AppLogger._internal();

  LogLevel minLevel = LogLevel.verbose;
  bool isProduction = false;
  final int maxBufferSize = 500;
  final Queue<LogEntry> _logBuffer = Queue<LogEntry>();

  void v(String message, [String? tag]) => _log(LogLevel.verbose, message, tag);
  void d(String message, [String? tag]) => _log(LogLevel.debug, message, tag);
  void i(String message, [String? tag]) => _log(LogLevel.info, message, tag);
  void w(String message, [String? tag, Object? error]) => _log(LogLevel.warning, message, tag, error);
  void e(String message, [String? tag, Object? error, StackTrace? stackTrace]) =>
      _log(LogLevel.error, message, tag, error, stackTrace);
  void f(String message, [String? tag, Object? error, StackTrace? stackTrace]) =>
      _log(LogLevel.fatal, message, tag, error, stackTrace);

  void _log(
    LogLevel level,
    String message, [
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (level.index < minLevel.index) return;

    final entry = LogEntry(
      level: level,
      message: message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );

    if (_logBuffer.length >= maxBufferSize) {
      _logBuffer.removeFirst();
    }
    _logBuffer.add(entry);

    if (!isProduction) {
      final color = _getColor(level);
      final reset = '\x1B[0m';
      // ignore: avoid_print
      print('$color${entry.toString()}$reset');
      if (error != null) {
        // ignore: avoid_print
        print('$color  خطأ: $error$reset');
      }
      if (stackTrace != null) {
        // ignore: avoid_print
        print('$color  تتبع المكدس:\n$stackTrace$reset');
      }
    }
  }

  String _getColor(LogLevel level) {
    switch (level) {
      case LogLevel.verbose:
        return '\x1B[90m'; // رمادي
      case LogLevel.debug:
        return '\x1B[36m'; // سماوي
      case LogLevel.info:
        return '\x1B[32m'; // أخضر
      case LogLevel.warning:
        return '\x1B[33m'; // أصفر
      case LogLevel.error:
        return '\x1B[31m'; // أحمر
      case LogLevel.fatal:
        return '\x1B[35m'; // أرجواني
    }
  }

  List<LogEntry> getBufferedLogs() => _logBuffer.toList();

  void clearLogs() => _logBuffer.clear();
}

final logger = AppLogger();
