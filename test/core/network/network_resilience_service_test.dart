import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/network/network_resilience_service.dart';

void main() {
  group('NetworkResilienceService Offline-First Gates', () {
    late NetworkResilienceService service;

    setUp(() {
      service = NetworkResilienceService();
    });

    tearDown(() {
      service.dispose();
    });

    test('Defaults to offline mode for sovereign operation', () {
      expect(service.isOnline, isFalse);
      expect(service.status, equals(NetworkStatus.offline));
    });

    test('Returns fallback immediately when offline without calling network closure', () async {
      bool networkCalled = false;

      final result = await service.executeWithFallback<String>(
        networkTask: () async {
          networkCalled = true;
          return 'Remote Data';
        },
        fallbackValue: 'Local Cached Data',
      );

      expect(networkCalled, isFalse);
      expect(result.isFromFallback, isTrue);
      expect(result.data, equals('Local Cached Data'));
      expect(result.errorMessage, contains('offline'));
    });

    test('Executes network closure and returns live data when online', () async {
      service.setNetworkStatus(NetworkStatus.online);
      expect(service.isOnline, isTrue);

      final result = await service.executeWithFallback<String>(
        networkTask: () async => 'Fresh Remote Data',
        fallbackValue: 'Local Cached Data',
      );

      expect(result.isFromFallback, isFalse);
      expect(result.data, equals('Fresh Remote Data'));
    });

    test('Falls back gracefully when online request times out', () async {
      service.setNetworkStatus(NetworkStatus.online);

      final result = await service.executeWithFallback<String>(
        networkTask: () async {
          await Future.delayed(const Duration(milliseconds: 100));
          return 'Slow Data';
        },
        fallbackValue: 'Timeout Fallback Data',
        timeout: const Duration(milliseconds: 20),
      );

      expect(result.isFromFallback, isTrue);
      expect(result.data, equals('Timeout Fallback Data'));
      expect(result.errorMessage, contains('TimeoutException'));
    });

    test('Manages offline task queue idempotently', () {
      service.queueOfflineTask(
        taskId: 'sync_card_001',
        taskType: 'UPDATE_CARD',
        payload: {'repetitions': 5},
      );
      service.queueOfflineTask(
        taskId: 'sync_card_001', // Duplicate task ID updates existing
        taskType: 'UPDATE_CARD',
        payload: {'repetitions': 6},
      );

      expect(service.queuedTaskCount, equals(1));
      expect(service.queuedTasks.first.payload['repetitions'], equals(6));

      expect(service.removeQueuedTask('sync_card_001'), isTrue);
      expect(service.queuedTaskCount, equals(0));
    });
  });
}
