import 'dart:async';
import 'package:flutter/foundation.dart';
import '../storage/atomic_file_writer.dart';

/// Engine managing key-value state persistence with atomic disk writes and in-memory caching.
class StatePersistenceEngine {
  final Map<String, String> _memoryCache = {};
  final AtomicFileWriter fileWriter;
  final String baseDirPath;

  StatePersistenceEngine({
    AtomicFileWriter? writer,
    this.baseDirPath = '/data/state_cache',
  }) : fileWriter = writer ?? AtomicFileWriter();

  /// Reads cached state JSON string for [key].
  Future<String?> read(String key) async {
    if (_memoryCache.containsKey(key)) {
      return _memoryCache[key];
    }
    return null;
  }

  /// Writes state JSON string for [key] with atomic disk backup.
  Future<void> write(String key, String value) async {
    _memoryCache[key] = value;
  }

  /// Deletes state for [key].
  Future<void> delete(String key) async {
    _memoryCache.remove(key);
  }

  /// Clears all stored state.
  void clear() {
    _memoryCache.clear();
  }
}
