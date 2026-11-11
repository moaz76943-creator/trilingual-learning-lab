import 'dart:async';
import 'package:flutter/foundation.dart';
import '../errors/failures.dart';

/// Mutex queue item holding a pending write operation and its completer.
class _QueuedWriteOperation<T> {
  final Future<T> Function() operation;
  final Completer<T> completer;
  final DateTime queuedAt;

  _QueuedWriteOperation({
    required this.operation,
    required this.completer,
    required this.queuedAt,
  });
}

/// Service serializing concurrent database writes and resolving transient lock contentions.
class DatabaseConcurrencyResolver extends ChangeNotifier {
  final List<_QueuedWriteOperation<dynamic>> _writeQueue = [];
  bool _isProcessingQueue = false;
  int _concurrencyCollisions = 0;
  int _retrySuccesses = 0;

  int get queueDepth => _writeQueue.length;
  int get concurrencyCollisions => _concurrencyCollisions;
  int get retrySuccesses => _retrySuccesses;
  bool get isLocked => _isProcessingQueue;

  /// Executes [writeAction] within a serialized FIFO queue with exponential retry backoff.
  Future<T> runSerializedWrite<T>(
    Future<T> Function() writeAction, {
    int maxRetries = 3,
    Duration initialRetryDelay = const Duration(milliseconds: 30),
  }) {
    final completer = Completer<T>();

    final item = _QueuedWriteOperation<T>(
      operation: writeAction,
      completer: completer,
      queuedAt: DateTime.now(),
    );

    _writeQueue.add(item);
    if (_writeQueue.length > 1) {
      _concurrencyCollisions++;
    }

    _processQueue(maxRetries, initialRetryDelay);
    return completer.future;
  }

  Future<void> _processQueue(int maxRetries, Duration initialDelay) async {
    if (_isProcessingQueue) return;
    _isProcessingQueue = true;

    while (_writeQueue.isNotEmpty) {
      final current = _writeQueue.first;

      int attempt = 0;
      bool succeeded = false;

      while (!succeeded && attempt <= maxRetries) {
        try {
          final result = await current.operation();
          current.completer.complete(result);
          succeeded = true;
          if (attempt > 0) {
            _retrySuccesses++;
          }
        } catch (error, stack) {
          attempt++;
          if (attempt > maxRetries) {
            current.completer.completeError(
              DatabaseTransactionFailure(
                reason: 'Database write contention timeout after $maxRetries retries: $error',
                originalError: error,
                stackTrace: stack,
              ),
            );
            break;
          } else {
            // Exponential backoff
            final delayMs = initialDelay.inMilliseconds * (1 << (attempt - 1));
            await Future.delayed(Duration(milliseconds: delayMs));
          }
        }
      }

      _writeQueue.removeAt(0);
      notifyListeners();
    }

    _isProcessingQueue = false;
  }

  /// Resets queue and statistics.
  void clear() {
    _writeQueue.clear();
    _isProcessingQueue = false;
    _concurrencyCollisions = 0;
    _retrySuccesses = 0;
    notifyListeners();
  }
}
