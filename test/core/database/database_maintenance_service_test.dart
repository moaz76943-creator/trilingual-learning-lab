import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/database/database_maintenance_service.dart';
import 'package:trilingual_learning_lab/core/database/sqlite_database_service.dart';

void main() {
  group('DatabaseMaintenanceService Fragmentation & Auto-Vacuum Tests', () {
    late SqliteDatabaseService db;
    late DatabaseMaintenanceService service;

    setUp(() async {
      db = SqliteDatabaseService();
      await db.initialize();
      service = DatabaseMaintenanceService(databaseService: db);
    });

    test('Inspects database health returning valid page counts and integrity state', () async {
      final health = await service.inspectHealth();

      expect(health.isIntegrityHealthy, isTrue);
      expect(health.pageSizeBytes, equals(4096));
      expect(health.totalPageCount, greaterThan(0));
      expect(health.totalSizeBytes, greaterThan(0));
    });

    test('Runs maintenance and updates lastOptimizedAt timestamp', () async {
      final initialTime = service.lastOptimizedAt;
      await Future.delayed(const Duration(milliseconds: 10));

      final success = await service.runMaintenance(forceVacuum: true);

      expect(success, isTrue);
      expect(service.isOptimizing, isFalse);
      expect(service.lastOptimizedAt.isAfter(initialTime), isTrue);
    });
  });
}
