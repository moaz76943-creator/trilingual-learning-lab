import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/recovery/session_crash_recovery_service.dart';

void main() {
  group('SessionCrashRecoveryService Fault-Tolerance Tests', () {
    late SessionCrashRecoveryService service;

    setUp(() {
      service = SessionCrashRecoveryService();
    });

    test('Records session heartbeat with SHA-256 checksum', () async {
      final now = DateTime(2026, 11, 11, 10, 0);

      await service.recordHeartbeat(
        sessionId: 'srs_session_001',
        moduleType: SessionModuleType.srsReview,
        currentIndex: 4,
        totalItems: 15,
        statePayload: {'completed_ids': ['card_1', 'card_2', 'card_3', 'card_4']},
        now: now,
      );

      expect(service.hasPendingRecovery, isTrue);
      final snapshot = service.pendingRecovery!;
      expect(snapshot.sessionId, equals('srs_session_001'));
      expect(snapshot.currentIndex, equals(4));
      expect(snapshot.totalItems, equals(15));
      expect(snapshot.checksum.length, equals(64)); // Valid SHA-256
      expect(snapshot.isExpired(now), isFalse);
    });

    test('Expires stale recovery snapshot older than 24 hours', () async {
      final sessionTime = DateTime(2026, 11, 10, 8, 0);
      final startupTime = DateTime(2026, 11, 11, 10, 0); // 26 hours later

      await service.recordHeartbeat(
        sessionId: 'stale_session',
        moduleType: SessionModuleType.quizExam,
        currentIndex: 2,
        totalItems: 10,
        statePayload: {},
        now: sessionTime,
      );

      final recovery = await service.checkForPendingRecovery(startupTime);

      expect(recovery, isNull); // Expired and purged
      expect(service.hasPendingRecovery, isFalse);
    });

    test('Clears journal completely when session completes normally', () async {
      await service.recordHeartbeat(
        sessionId: 'normal_session',
        moduleType: SessionModuleType.dictation,
        currentIndex: 5,
        totalItems: 5,
        statePayload: {},
      );

      expect(service.hasPendingRecovery, isTrue);

      await service.clearJournal();

      expect(service.hasPendingRecovery, isFalse);
      expect(service.pendingRecovery, isNull);
    });
  });
}
