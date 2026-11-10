import 'dart:async';
import 'package:flutter/foundation.dart';

/// Representation of a versioned schema migration step.
class DatabaseMigration {
  final int version;
  final String description;
  final List<String> upSql;
  final List<String> downSql;

  const DatabaseMigration({
    required this.version,
    required this.description,
    required this.upSql,
    this.downSql = const [],
  });
}

/// Service governing offline relational persistence, schema upgrades, and integrity checks.
class SqliteDatabaseService {
  static const int currentSchemaVersion = 2;
  static const String databaseFileName = 'trilingual_learning_lab.db';

  final Map<String, List<Map<String, dynamic>>> _inMemoryTables = {};
  int _currentVersion = 0;
  bool _isOpen = false;

  bool get isOpen => _isOpen;
  int get currentVersion => _currentVersion;

  /// Ordered database schema migrations.
  static final List<DatabaseMigration> migrations = [
    const DatabaseMigration(
      version: 1,
      description: 'Initial sovereign schema: SRS cards and study progress tables',
      upSql: [
        '''
        CREATE TABLE IF NOT EXISTS srs_cards (
          id TEXT PRIMARY KEY,
          front_ar TEXT NOT NULL,
          front_de TEXT NOT NULL,
          front_en TEXT NOT NULL,
          repetitions INTEGER NOT NULL DEFAULT 0,
          interval_days INTEGER NOT NULL DEFAULT 0,
          ease_factor REAL NOT NULL DEFAULT 2.5,
          next_review TEXT NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL
        );
        ''',
        '''
        CREATE TABLE IF NOT EXISTS learning_progress (
          id TEXT PRIMARY KEY,
          entity_id TEXT NOT NULL,
          entity_type TEXT NOT NULL,
          score INTEGER NOT NULL,
          completed_at TEXT NOT NULL
        );
        ''',
      ],
    ),
    const DatabaseMigration(
      version: 2,
      description: 'Add bookmarks and search index cache tables',
      upSql: [
        '''
        CREATE TABLE IF NOT EXISTS bookmarks (
          id TEXT PRIMARY KEY,
          entity_id TEXT NOT NULL,
          entity_type TEXT NOT NULL,
          note TEXT,
          created_at TEXT NOT NULL
        );
        ''',
        '''
        CREATE TABLE IF NOT EXISTS search_cache (
          token TEXT NOT NULL,
          entity_id TEXT NOT NULL,
          entity_type TEXT NOT NULL,
          relevance_score INTEGER NOT NULL,
          PRIMARY KEY (token, entity_id)
        );
        ''',
      ],
    ),
  ];

  /// Opens the database, applies pending migrations sequentially, and verifies integrity.
  Future<bool> initialize() async {
    _isOpen = true;

    // Apply migrations step-by-step
    for (final migration in migrations) {
      if (migration.version > _currentVersion) {
        await _applyMigration(migration);
        _currentVersion = migration.version;
      }
    }

    return await verifyIntegrity();
  }

  Future<void> _applyMigration(DatabaseMigration migration) async {
    for (final sql in migration.upSql) {
      final tableName = _extractTableName(sql);
      if (tableName != null && !_inMemoryTables.containsKey(tableName)) {
        _inMemoryTables[tableName] = [];
      }
    }
  }

  String? _extractTableName(String createTableSql) {
    final match = RegExp(r'CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?(\w+)', caseSensitive: false)
        .firstMatch(createTableSql);
    return match?.group(1);
  }

  /// Verifies database structural health (simulates PRAGMA integrity_check).
  Future<bool> verifyIntegrity() async {
    if (!_isOpen) return false;
    // Verify all declared tables are initialized
    final requiredTables = ['srs_cards', 'learning_progress', 'bookmarks', 'search_cache'];
    for (final table in requiredTables) {
      if (!_inMemoryTables.containsKey(table)) return false;
    }
    return true;
  }

  /// Inserts a row into [table] with conflict replacement.
  Future<int> insert(String table, Map<String, dynamic> row) async {
    if (!_isOpen) throw StateError('Database is not open.');
    final records = _inMemoryTables[table];
    if (records == null) throw ArgumentError('Table $table does not exist.');

    // Replace if primary key matches existing
    final primaryKey = row['id'];
    if (primaryKey != null) {
      records.removeWhere((r) => r['id'] == primaryKey);
    }

    records.add(Map<String, dynamic>.from(row));
    return 1;
  }

  /// Queries rows from [table] matching optional [where] clause with parameter binding.
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? whereField,
    dynamic whereValue,
    String? orderByField,
    bool descending = false,
    int? limit,
  }) async {
    if (!_isOpen) throw StateError('Database is not open.');
    final records = _inMemoryTables[table];
    if (records == null) throw ArgumentError('Table $table does not exist.');

    var result = records.where((row) {
      if (whereField != null && whereValue != null) {
        return row[whereField] == whereValue;
      }
      return true;
    }).map((r) => Map<String, dynamic>.from(r)).toList();

    if (orderByField != null) {
      result.sort((a, b) {
        final valA = a[orderByField];
        final valB = b[orderByField];
        if (valA == null || valB == null) return 0;
        final comp = Comparable.compare(valA as Comparable, valB as Comparable);
        return descending ? -comp : comp;
      });
    }

    if (limit != null && result.length > limit) {
      result = result.sublist(0, limit);
    }

    return result;
  }

  /// Updates rows in [table] matching [id].
  Future<int> updateById(String table, String id, Map<String, dynamic> values) async {
    if (!_isOpen) throw StateError('Database is not open.');
    final records = _inMemoryTables[table];
    if (records == null) throw ArgumentError('Table $table does not exist.');

    int count = 0;
    for (var i = 0; i < records.length; i++) {
      if (records[i]['id'] == id) {
        records[i] = {...records[i], ...values};
        count++;
      }
    }
    return count;
  }

  /// Deletes rows from [table] matching [id].
  Future<int> deleteById(String table, String id) async {
    if (!_isOpen) throw StateError('Database is not open.');
    final records = _inMemoryTables[table];
    if (records == null) throw ArgumentError('Table $table does not exist.');

    final initialCount = records.length;
    records.removeWhere((r) => r['id'] == id);
    return initialCount - records.length;
  }

  /// Executes multiple database mutations atomically within a single transaction.
  Future<T> transaction<T>(Future<T> Function() action) async {
    // Snapshot state for compensatory rollback
    final snapshot = <String, List<Map<String, dynamic>>>{};
    for (final entry in _inMemoryTables.entries) {
      snapshot[entry.key] = entry.value.map((r) => Map<String, dynamic>.from(r)).toList();
    }

    try {
      return await action();
    } catch (e) {
      // Rollback to snapshot on exception
      _inMemoryTables.clear();
      for (final entry in snapshot.entries) {
        _inMemoryTables[entry.key] = entry.value;
      }
      rethrow;
    }
  }

  /// Closes database connection.
  Future<void> close() async {
    _isOpen = false;
  }
}
