import 'dart:async';
import '../errors/failures.dart';
import '../utils/logger.dart';
import '../utils/result.dart';

/// سياسة إعادة المحاولة التلقائية المتدرجة لحماية قراءة البيانات من التعليق
class RetryPolicy {
  final int maxRetries;
  final Duration initialDelay;
  final double backoffMultiplier;

  const RetryPolicy({
    this.maxRetries = 3,
    this.initialDelay = const Duration(milliseconds: 100),
    this.backoffMultiplier = 2.0,
  });

  Future<Result<T, Failure>> execute<T>(
    Future<Result<T, Failure>> Function() operation, {
    String operationName = 'عملية',
  }) async {
    int attempts = 0;
    Duration currentDelay = initialDelay;

    while (true) {
      attempts++;
      final result = await operation();

      if (result.isSuccess) {
        return result;
      }

      if (attempts >= maxRetries) {
        logger.w('فشلت $operationName بعد $attempts محاولات متتالية', 'RetryPolicy');
        return result;
      }

      logger.d(
        'إعادة محاولة $operationName (محاولة $attempts من $maxRetries) بعد ${currentDelay.inMilliseconds}ms',
        'RetryPolicy',
      );
      await Future.delayed(currentDelay);
      currentDelay = Duration(
        milliseconds: (currentDelay.inMilliseconds * backoffMultiplier).round(),
      );
    }
  }
}

const defaultRetryPolicy = RetryPolicy();
