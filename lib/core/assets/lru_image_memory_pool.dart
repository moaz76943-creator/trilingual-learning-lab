import 'package:flutter/foundation.dart';

/// Cached asset memory handle tracking allocation size and access recency.
class MemoryPoolEntry {
  final String key;
  final int byteSize;
  final DateTime cachedAt;
  DateTime lastAccessedAt;

  MemoryPoolEntry({
    required this.key,
    required this.byteSize,
    required this.cachedAt,
    DateTime? lastAccessedAt,
  }) : lastAccessedAt = lastAccessedAt ?? cachedAt;
}

/// Bounded LRU memory pool governing decoded vector and raster asset memory limits.
class LruImageMemoryPool {
  final int maxPoolSizeBytes;
  final Map<String, MemoryPoolEntry> _entries = {};
  int _currentPoolSizeBytes = 0;

  LruImageMemoryPool({
    this.maxPoolSizeBytes = 32 * 1024 * 1024, // 32 Megabytes cap
  });

  int get currentPoolSizeBytes => _currentPoolSizeBytes;
  int get entryCount => _entries.length;
  bool get isEmpty => _entries.isEmpty;
  double get utilizationFraction =>
      maxPoolSizeBytes > 0 ? (_currentPoolSizeBytes / maxPoolSizeBytes) : 0.0;

  /// Checks if key is present in memory pool.
  bool contains(String key) => _entries.containsKey(key);

  /// Touches and records access for [key].
  void touch(String key) {
    final entry = _entries[key];
    if (entry != null) {
      entry.lastAccessedAt = DateTime.now();
    }
  }

  /// Inserts a new memory handle, evicting oldest entries if pool exceeds [maxPoolSizeBytes].
  void put(String key, int byteSize) {
    if (byteSize <= 0) return;

    if (_entries.containsKey(key)) {
      _currentPoolSizeBytes -= _entries[key]!.byteSize;
    }

    final entry = MemoryPoolEntry(
      key: key,
      byteSize: byteSize,
      cachedAt: DateTime.now(),
    );

    _entries[key] = entry;
    _currentPoolSizeBytes += byteSize;

    _evictOldestIfOverflown();
  }

  /// Evicts specific handle by key.
  bool remove(String key) {
    final entry = _entries.remove(key);
    if (entry != null) {
      _currentPoolSizeBytes -= entry.byteSize;
      return true;
    }
    return false;
  }

  /// Evicts least recently accessed entries until memory footprint is within capacity.
  void _evictOldestIfOverflown() {
    if (_currentPoolSizeBytes <= maxPoolSizeBytes) return;

    final sorted = _entries.values.toList()
      ..sort((a, b) => a.lastAccessedAt.compareTo(b.lastAccessedAt));

    for (final entry in sorted) {
      if (_currentPoolSizeBytes <= maxPoolSizeBytes) break;
      _entries.remove(entry.key);
      _currentPoolSizeBytes -= entry.byteSize;
    }
  }

  /// Evicts [fraction] (e.g. 0.50) of entries to release memory pressure.
  void purgeFraction(double fraction) {
    final targetBytes = (_currentPoolSizeBytes * (1.0 - fraction.clamp(0.1, 1.0))).round();

    final sorted = _entries.values.toList()
      ..sort((a, b) => a.lastAccessedAt.compareTo(b.lastAccessedAt));

    for (final entry in sorted) {
      if (_currentPoolSizeBytes <= targetBytes) break;
      _entries.remove(entry.key);
      _currentPoolSizeBytes -= entry.byteSize;
    }
  }

  /// Completely clears memory pool.
  void clear() {
    _entries.clear();
    _currentPoolSizeBytes = 0;
  }
}
