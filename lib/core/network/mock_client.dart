import 'dart:async';
import '../errors/failures.dart';
import '../utils/result.dart';

/// عميل شبكي وهمي عالي المرونة لدعم محاكاة المزامنة السحابية والاختبارات
class MockHttpClient {
  bool simulateOffline = false;
  Duration simulatedLatency = const Duration(milliseconds: 150);

  /// محاكاة طلب GET غير متزامن
  Future<Result, Failure>> get(String endpoint) async {
    if (simulateOffline) {
      return Result.failure(
        const NetworkFailure('لا يوجد اتصال بالإنترنت (وضع عدم الاتصال المحاكى)'),
      );
    }

    await Future.delayed(simulatedLatency);

    return Result.success({
      'status': 200,
      'endpoint': endpoint,
      'data': {'sync_time': DateTime.now().toIso8601String()},
    });
  }

  /// محاكاة طلب POST غير متزامن
  Future<Result, Failure>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    if (simulateOffline) {
      return Result.failure(
        const NetworkFailure('تعذر إرسال البيانات (وضع عدم الاتصال المحاكى)'),
      );
    }

    await Future.delayed(simulatedLatency);

    return Result.success({
      'status': 201,
      'endpoint': endpoint,
      'received_bytes': body.length,
      'success': true,
    });
  }
}

final mockHttpClient = MockHttpClient();
