import 'dart:math';

class RetryPolicy {
  static Future<T> withExponentialBackoff<T>({
    required Future<T> Function() operation,
    int maxRetries = 3,
    Duration initialDelay = const Duration(milliseconds: 300),
  }) async {
    int attempts = 0;
    while (true) {
      try {
        attempts++;
        return await operation();
      } catch (e) {
        if (attempts >= maxRetries) rethrow;
        final delayMs = initialDelay.inMilliseconds * pow(2, attempts - 1).toInt();
        await Future.delayed(Duration(milliseconds: delayMs));
      }
    }
  }
}
