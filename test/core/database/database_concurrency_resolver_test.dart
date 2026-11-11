import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/database/database_concurrency_resolver.dart';
import 'package:trilingual_learning_lab/core/errors/failures.dart';

void main() {
  group('DatabaseConcurrencyResolver Serialization & Retry Tests', () {
    late DatabaseConcurrencyResolver resolver;

    setUp(() {
      resolver = DatabaseConcurrencyResolver();
    });

    test('Serializes concurrent write calls in strict FIFO order', () async {
      final executionOrder = <int>[];

      // Dispatch 5 concurrent writes simultaneously
      final futures = List.generate(5, (index) {
        return resolver.runSerializedWrite(() async {
          await Future.delayed(const Duration(milliseconds: 10));
          executionOrder.add(index);
          return index;
        });
      });

      final results = await Future.wait(futures);

      expect(results, equals([0, 1, 2, 3, 4]));
      expect(executionOrder, equals([0, 1, 2, 3, 4]));
      expect(resolver.concurrencyCollisions, greaterThan(0));
      expect(resolver.queueDepth, equals(0));
    });

    test('Automatically retries and succeeds on transient database lock error', () async {
      int attempts = 0;

      final result = await resolver.runSerializedWrite(() async {
        attempts++;
        if (attempts < 3) {
          throw Exception('sqlite3_step: database is locked');
        }
        return 'Write Committed';
      }, maxRetries: 3);

      expect(result, equals('Write Committed'));
      expect(attempts, equals(3));
      expect(resolver.retrySuccesses, equals(1));
    });

    test('Throws typed DatabaseTransactionFailure when retries are exhausted', () async {
      expect(
        () => resolver.runSerializedWrite(() async {
          throw Exception('Persistent disk lock failure');
        }, maxRetries: 2),
        throwsA(isA<DatabaseTransactionFailure>()),
      );
    });

    test('Clears queue state properly', () {
      resolver.clear();
      expect(resolver.queueDepth, equals(0));
      expect(resolver.isLocked, isFalse);
    });
  });
}
