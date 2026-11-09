import 'package:flutter/foundation.dart';
import '../backup/sovereign_backup_service.dart';

/// Metadata for a cached audio file on disk.
class AudioCacheEntry {
  final String key;
  final String filePath;
  final int byteSize;
  final DateTime cachedAt;
  DateTime lastAccessedAt;

  AudioCacheEntry({
    required this.key,
    required this.filePath,
    required this.byteSize,
    required this.cachedAt,
    DateTime? lastAccessedAt,
  }) : lastAccessedAt = lastAccessedAt ?? cachedAt;
}

/// Service managing offline audio caching, LRU eviction, and deterministic keys.
class LocalAudioCacheManager {
  final int maxCacheSizeBytes;
  final Map<String, AudioCacheEntry> _cacheIndex = {};
  int _currentSizeBytes = 0;

  LocalAudioCacheManager({
    this.maxCacheSizeBytes = 50 * 1024 * 1024, // 50 Megabytes default cap
  });

  int get cachedFilesCount => _cacheIndex.length;
  int get currentCacheSizeBytes => _currentSizeBytes;
  bool get isEmpty => _cacheIndex.isEmpty;

  /// Generates a deterministic SHA-256 cache key from normalized text and language.
  static String generateCacheKey(String text, String languageCode) {
    final cleanText = text.trim();
    final cleanLang = languageCode.trim().toLowerCase();
    final rawKey = '$cleanLang:$cleanText';
    return SovereignBackupService.calculateSha256(rawKey);
  }

  /// Checks if an audio file is indexed for [key].
  bool hasKey(String key) {
    return _cacheIndex.containsKey(key);
  }

  /// Retrieves the file path for [key] and refreshes its LRU timestamp.
  String? getFilePath(String key) {
    final entry = _cacheIndex[key];
    if (entry != null) {
      entry.lastAccessedAt = DateTime.now();
      return entry.filePath;
    }
    return null;
  }

  /// Inserts a new cache record and triggers eviction if size limit is exceeded.
  void put({
    required String key,
    required String filePath,
    required int byteSize,
  }) {
    if (_cacheIndex.containsKey(key)) {
      _currentSizeBytes -= _cacheIndex[key]!.byteSize;
    }

    final entry = AudioCacheEntry(
      key: key,
      filePath: filePath,
      byteSize: byteSize,
      cachedAt: DateTime.now(),
    );

    _cacheIndex[key] = entry;
    _currentSizeBytes += byteSize;

    _evictOldestIfExceeded();
  }

  /// Removes a specific cache entry by [key].
  bool evict(String key) {
    final entry = _cacheIndex.remove(key);
    if (entry != null) {
      _currentSizeBytes -= entry.byteSize;
      return true;
    }
    return false;
  }

  /// Evicts least recently accessed entries until storage is below [maxCacheSizeBytes].
  void _evictOldestIfExceeded() {
    if (_currentSizeBytes <= maxCacheSizeBytes) return;

    final sortedEntries = _cacheIndex.values.toList()
      ..sort((a, b) => a.lastAccessedAt.compareTo(b.lastAccessedAt));

    for (final entry in sortedEntries) {
      if (_currentSizeBytes <= maxCacheSizeBytes) break;
      _cacheIndex.remove(entry.key);
      _currentSizeBytes -= entry.byteSize;
    }
  }

  /// Clears the entire cache index.
  void clear() {
    _cacheIndex.clear();
    _currentSizeBytes = 0;
  }
}
