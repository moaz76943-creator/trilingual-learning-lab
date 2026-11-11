import 'package:flutter/foundation.dart';

enum ClockIntegrityStatus {
  verified,
  clockRolledBack,
  anomalousForwardJump,
}

/// Evaluation result from time integrity check.
class ClockVerificationResult {
  final DateTime trustedTime;
  final ClockIntegrityStatus status;
  final Duration anomalyDelta;

  const ClockVerificationResult({
    required this.trustedTime,
    required this.status,
    this.anomalyDelta = Duration.zero,
  });

  bool get isClean => status == ClockIntegrityStatus.verified;
}

/// Service guaranteeing monotonic temporal progression for SRS intervals and streaks.
class AntiTamperReviewClock extends ChangeNotifier {
  DateTime _lastTrustedTimestamp;
  int _tamperEventsDetected = 0;

  AntiTamperReviewClock({
    DateTime? initialAnchor,
  }) : _lastTrustedTimestamp = initialAnchor ?? DateTime.now();

  DateTime get lastTrustedTimestamp => _lastTrustedTimestamp;
  int get tamperEventsDetected => _tamperEventsDetected;

  /// Verifies current [systemNow] against trusted monotonic anchor.
  ClockVerificationResult verifyAndResolveTime(DateTime systemNow, [Duration? elapsedUptime]) {
    // 1. Backwards time roll check
    if (systemNow.isBefore(_lastTrustedTimestamp)) {
      _tamperEventsDetected++;
      final rollbackDelta = _lastTrustedTimestamp.difference(systemNow);

      // Safe recovery: clamp to last trusted time + 1 second increment
      _lastTrustedTimestamp = _lastTrustedTimestamp.add(const Duration(seconds: 1));
      notifyListeners();

      return ClockVerificationResult(
        trustedTime: _lastTrustedTimestamp,
        status: ClockIntegrityStatus.clockRolledBack,
        anomalyDelta: rollbackDelta,
      );
    }

    // 2. Anomalous forward leap check (>72 hours forward without matching uptime)
    final forwardDelta = systemNow.difference(_lastTrustedTimestamp);
    if (forwardDelta.inHours > 72) {
      if (elapsedUptime != null && elapsedUptime.inHours < 48) {
        _tamperEventsDetected++;
        // Anomalous jump detected (clock rolled forward by days while uptime is low)
        _lastTrustedTimestamp = _lastTrustedTimestamp.add(elapsedUptime);
        notifyListeners();

        return ClockVerificationResult(
          trustedTime: _lastTrustedTimestamp,
          status: ClockIntegrityStatus.anomalousForwardJump,
          anomalyDelta: forwardDelta,
        );
      }
    }

    // 3. Normal verified progression
    _lastTrustedTimestamp = systemNow;
    notifyListeners();

    return ClockVerificationResult(
      trustedTime: systemNow,
      status: ClockIntegrityStatus.verified,
      anomalyDelta: Duration.zero,
    );
  }

  /// Manually commits anchor update after verified persistent write.
  void commitAnchor(DateTime timestamp) {
    if (timestamp.isAfter(_lastTrustedTimestamp)) {
      _lastTrustedTimestamp = timestamp;
      notifyListeners();
    }
  }

  /// Resets clock baseline.
  void reset([DateTime? newAnchor]) {
    _lastTrustedTimestamp = newAnchor ?? DateTime.now();
    _tamperEventsDetected = 0;
    notifyListeners();
  }
}
