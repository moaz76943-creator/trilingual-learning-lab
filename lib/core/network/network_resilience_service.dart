import 'dart:async';
import 'package:flutter/foundation.dart';

enum NetworkStatus {
  online,
  offline,
  unknown,
}

/// Execution result from the resilience gate.
class NetworkExecutionResult<T> {
  final T data;
  final bool isFromFallback;
  final String? errorMessage;

  const NetworkExecutionResult({
    required this.data,
    required this.isFromFallback,
    this.errorMessage,
  });

  bool get isSuccessful => !isFromFallback;
}

/// A queued offline task to be executed once connectivity resumes.
class QueuedOfflineTask {
  final String id;
  final String taskType;
  final Map<String, dynamic> payload;
  final DateTime queuedAt;

  const QueuedOfflineTask({
    required this.id,
    required this.taskType,
    required this.payload,
    required this.queuedAt,
  });
}

/// Service managing offline-first network state, resilient timeouts, and deferred queues.
class NetworkResilienceService {
  NetworkStatus _status = NetworkStatus.offline; // Default to sovereign offline mode
  final StreamController<NetworkStatus> _statusController = StreamController<NetworkStatus>.broadcast();
  final Map<String, QueuedOfflineTask> _offlineQueue = {};

  NetworkStatus get status => _status;
  bool get isOnline => _status == NetworkStatus.online;
  Stream<NetworkStatus> get onStatusChanged => _statusController.stream;
  int get queuedTaskCount => _offlineQueue.length;
  List<QueuedOfflineTask> get queuedTasks => _offlineQueue.values.toList();

  /// Sets connectivity status and notifies listeners if changed.
  void setNetworkStatus(NetworkStatus newStatus) {
    if (_status != newStatus) {
      _status = newStatus;
      _statusController.add(_status);
    }
  }

  /// Executes [networkTask] safely:
  /// - If offline, returns [fallbackValue] immediately without network attempt.
  /// - If online, executes with bounded [timeout]. On error or timeout, safely returns [fallbackValue].
  Future<NetworkExecutionResult<T>> executeWithFallback<T>({
    required Future<T> Function() networkTask,
    required T fallbackValue,
    Duration timeout = const Duration(seconds: 3),
  }) async {
    if (!isOnline) {
      return NetworkExecutionResult<T>(
        data: fallbackValue,
        isFromFallback: true,
        errorMessage: 'Device is offline. Sovereign local fallback applied.',
      );
    }

    try {
      final result = await networkTask().timeout(timeout);
      return NetworkExecutionResult<T>(
        data: result,
        isFromFallback: false,
      );
    } catch (e) {
      return NetworkExecutionResult<T>(
        data: fallbackValue,
        isFromFallback: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// Queues a task for deferred execution when back online (idempotent by taskId).
  void queueOfflineTask({
    required String taskId,
    required String taskType,
    required Map<String, dynamic> payload,
  }) {
    _offlineQueue[taskId] = QueuedOfflineTask(
      id: taskId,
      taskType: taskType,
      payload: payload,
      queuedAt: DateTime.now(),
    );
  }

  /// Removes a task from the deferred queue after successful sync.
  bool removeQueuedTask(String taskId) {
    return _offlineQueue.remove(taskId) != null;
  }

  /// Clears all queued offline tasks.
  void clearQueue() {
    _offlineQueue.clear();
  }

  void dispose() {
    _statusController.close();
  }
}
