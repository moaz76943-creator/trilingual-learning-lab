class AppLogger {
  static final List<String> _logBuffer = [];
  static const int _maxBufferSize = 500;

  static void info(String message, {String tag = 'APP'}) {
    _log('INFO', tag, message);
  }

  static void warn(String message, {String tag = 'APP'}) {
    _log('WARN', tag, message);
  }

  static void error(String message, {String tag = 'APP', Object? error, StackTrace? stack}) {
    _log('ERROR', tag, '$message ${error ?? ''}');
  }

  static void _log(String level, String tag, String message) {
    final timestamp = DateTime.now().toIso8601String();
    final entry = '[$timestamp] [$level] [$tag]: $message';
    _logBuffer.add(entry);
    if (_logBuffer.length > _maxBufferSize) {
      _logBuffer.removeAt(0);
    }
  }

  static List<String> getLogs() => List.unmodifiable(_logBuffer);
  static void clearLogs() => _logBuffer.clear();
}
