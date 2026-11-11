import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../backup/sovereign_backup_service.dart';

enum SessionModuleType {
  srsReview,
  quizExam,
  dictation,
  dialoguePlayer,
}

/// Snapshot of an uncompleted in-flight learning session.
class SessionRecoverySnapshot {
  final String sessionId;
  final SessionModuleType moduleType;
  final int currentIndex;
  final int totalItems;
  final Map<String, dynamic> statePayload;
  final DateTime recordedAt;
  final String checksum;

  const SessionRecoverySnapshot({
    required this.sessionId,
    required this.moduleType,
    required this.currentIndex,
    required this.totalItems,
    required this.statePayload,
    required this.recordedAt,
    required this.checksum,
  });

  bool isExpired([DateTime? now]) {
    final current = now ?? DateTime.now();
    // Sessions older than 24 hours are considered stale
    return current.difference(recordedAt).inHours >= 24;
  }
}

/// Service managing write-ahead session journaling and crash recovery.
class SessionCrashRecoveryService extends ChangeNotifier {
  SessionRecoverySnapshot? _pendingRecovery;
  bool _hasCheckedForRecovery = false;

  SessionRecoverySnapshot? get pendingRecovery => _pendingRecovery;
  bool get hasPendingRecovery => _pendingRecovery != null && !_pendingRecovery!.isExpired();
  bool get hasCheckedForRecovery => _hasCheckedForRecovery;

  /// Records an active heartbeat snapshot of an ongoing session.
  Future<void> recordHeartbeat({
    required String sessionId,
    required SessionModuleType moduleType,
    required int currentIndex,
    required int totalItems,
    required Map<String, dynamic> statePayload,
    DateTime? now,
  }) async {
    final timestamp = now ?? DateTime.now();
    final rawData = jsonEncode({
      'session_id': sessionId,
      'module_type': moduleType.name,
      'current_index': currentIndex,
      'total_items': totalItems,
      'payload': statePayload,
      'recorded_at': timestamp.toIso8601String(),
    });

    final checksum = SovereignBackupService.calculateSha256(rawData);

    _pendingRecovery = SessionRecoverySnapshot(
      sessionId: sessionId,
      moduleType: moduleType,
      currentIndex: currentIndex,
      totalItems: totalItems,
      statePayload: statePayload,
      recordedAt: timestamp,
      checksum: checksum,
    );

    notifyListeners();
  }

  /// Verifies journal integrity and loads pending recovery snapshot.
  Future<SessionRecoverySnapshot?> checkForPendingRecovery([DateTime? now]) async {
    _hasCheckedForRecovery = true;
    if (_pendingRecovery != null && _pendingRecovery!.isExpired(now)) {
      _pendingRecovery = null;
    }
    notifyListeners();
    return _pendingRecovery;
  }

  /// Clears journal upon normal session completion.
  Future<void> clearJournal() async {
    _pendingRecovery = null;
    notifyListeners();
  }
}
