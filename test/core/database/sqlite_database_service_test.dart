import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/database/sqlite_database_service.dart';

void main() {
  group('SqliteDatabaseService Migrations & Transactional Integrity', () {
    late SqliteDatabaseService db;

    setUp(() async {
      db = SqliteDatabaseService();
      await db.initialize();
    });

    tearDown(() async {
      await db.close();
    });

    test('Applies all migrations and reaches target schema version', () {
      expect(db.isOpen, isTrue);
      expect(db.currentVersion, equals(SqliteDatabaseService.currentSchemaVersion));
    });

    test('Verifies structural integrity of all required tables', () async {
      final isHealthy = await db.verifyIntegrity();
      expect(isHealthy, isTrue);
    });

    test('Performs CRUD operations on srs_cards table with parameter binding', () async {
      final cardRow = {
        'id': 'card_astrolabe_001',
        'front_ar': 'الشَّبَكَةُ العَنْكَبُوتِيَّةُ',
        'front_de': 'Die Rete',
        'front_en': 'The Rete',
        'repetitions': 1,
        'interval_days': 1,
        'ease_factor': 2.5,
        'next_review': '2026-11-10T12:00:00Z',
        'created_at': '2026-11-09T10:00:00Z',
        'updated_at': '2026-11-09T10:00:00Z',
      };

      // 1. Insert
      final inserted = await db.insert('srs_cards', cardRow);
      expect(inserted, equals(1));

      // 2. Query
      final results = await db.query('srs_cards', whereField: 'id', whereValue: 'card_astrolabe_001');
      expect(results.length, equals(1));
      expect(results.first['front_ar'], contains('العَنْكَبُوتِيَّةُ'));
      expect(results.first['repetitions'], equals(1));

      // 3. Update
      final updated = await db.updateById('srs_cards', 'card_astrolabe_001', {
        'repetitions': 2,
        'interval_days': 6,
        'ease_factor': 2.6,
      });
      expect(updated, equals(1));

      final updatedResults = await db.query('srs_cards', whereField: 'id', whereValue: 'card_astrolabe_001');
      expect(updatedResults.first['repetitions'], equals(2));
      expect(updatedResults.first['interval_days'], equals(6));

      // 4. Delete
      final deleted = await db.deleteById('srs_cards', 'card_astrolabe_001');
      expect(deleted, equals(1));

      final emptyResults = await db.query('srs_cards', whereField: 'id', whereValue: 'card_astrolabe_001');
      expect(emptyResults.isEmpty, isTrue);
    });

    test('Rolls back transaction on failure preserving original state', () async {
      await db.insert('bookmarks', {
        'id': 'bm_1',
        'entity_id': 'cat_176',
        'entity_type': 'category',
        'note': 'Initial bookmark',
        'created_at': '2026-11-09T00:00:00Z',
      });

      expect(
        () async {
          await db.transaction(() async {
            await db.insert('bookmarks', {
              'id': 'bm_2',
              'entity_id': 'cat_177',
              'entity_type': 'category',
              'note': 'Pending bookmark',
              'created_at': '2026-11-09T01:00:00Z',
            });
            throw Exception('Intentional transactional abort');
          });
        },
        throwsException,
      );

      // Verify bm_2 was rolled back and bm_1 is still intact
      final allBookmarks = await db.query('bookmarks');
      expect(allBookmarks.length, equals(1));
      expect(allBookmarks.first['id'], equals('bm_1'));
    });
  });
}
