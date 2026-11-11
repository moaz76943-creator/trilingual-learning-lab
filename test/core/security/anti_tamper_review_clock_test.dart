import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/security/anti_tamper_review_clock.dart';

void main() {
  group('AntiTamperReviewClock Monotonic Time & Rollback Guard Tests', () {
    late AntiTamperReviewClock clock;
    final initialAnchor = DateTime(2026, 11, 11, 10, 0, 0);

    setUp(() {
      clock = AntiTamperReviewClock(initialAnchor: initialAnchor);
    });

    test('Verifies normal forward chronological progression cleanly', () {
      final forwardTime = DateTime(2026, 11, 11, 10, 15, 0); // 15 mins later
      final result = clock.verifyAndResolveTime(forwardTime);

      expect(result.isClean, isTrue);
      expect(result.status, equals(ClockIntegrityStatus.verified));
      expect(result.trustedTime, equals(forwardTime));
      expect(clock.lastTrustedTimestamp, equals(forwardTime));
      expect(clock.tamperEventsDetected, equals(0));
    });

    test('Detects backwards clock roll and clamps monotonic progression', () {
      final rolledBackTime = DateTime(2026, 11, 10, 8, 0, 0); // Rolled back by >1 day!
      final result = clock.verifyAndResolveTime(rolledBackTime);

      expect(result.isClean, isFalse);
      expect(result.status, equals(ClockIntegrityStatus.clockRolledBack));
      // Trusted time must NOT roll backward; it advances monotonically
      expect(result.trustedTime.isAfter(initialAnchor), isTrue);
      expect(clock.tamperEventsDetected, equals(1));
    });

    test('Detects anomalous forward leap when uptime does not match wall clock jump', () {
      final jumpForwardTime = initialAnchor.add(const Duration(days: 10)); // 10 days jump
      const shortUptime = Duration(hours: 2); // But uptime is only 2 hours

      final result = clock.verifyAndResolveTime(jumpForwardTime, shortUptime);

      expect(result.isClean, isFalse);
      expect(result.status, equals(ClockIntegrityStatus.anomalousForwardJump));
      expect(result.anomalyDelta.inDays, equals(10));
      expect(clock.tamperEventsDetected, equals(1));
    });

    test('Monotonically commits anchor updates', () {
      final newTime = initialAnchor.add(const Duration(hours: 1));
      clock.commitAnchor(newTime);
      expect(clock.lastTrustedTimestamp, equals(newTime));

      // Attempting to commit an older time must be ignored
      clock.commitAnchor(initialAnchor);
      expect(clock.lastTrustedTimestamp, equals(newTime));
    });
  });
}
