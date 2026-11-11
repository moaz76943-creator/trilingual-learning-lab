import 'package:flutter/foundation.dart';
import 'lru_image_memory_pool.dart';

enum MemoryPressureLevel {
  normal,
  moderate, // High memory usage: trim 30% of pool
  critical, // System low memory signal: purge 80% of pool
}

/// Service monitoring memory pressure and safeguarding UI from OOM crashes.
class AssetMemoryCacheGuard extends ChangeNotifier {
  final LruImageMemoryPool pool;
  MemoryPressureLevel _currentPressure = MemoryPressureLevel.normal;
  int _purgeCount = 0;

  AssetMemoryCacheGuard({LruImageMemoryPool? memoryPool})
      : pool = memoryPool ?? LruImageMemoryPool();

  MemoryPressureLevel get currentPressure => _currentPressure;
  int get purgeCount => _purgeCount;

  /// Handles incoming system memory pressure signals.
  void handleMemoryPressure(MemoryPressureLevel level) {
    _currentPressure = level;

    switch (level) {
      case MemoryPressureLevel.normal:
        break;
      case MemoryPressureLevel.moderate:
        pool.purgeFraction(0.35); // Relieve 35%
        _purgeCount++;
        break;
      case MemoryPressureLevel.critical:
        pool.purgeFraction(0.85); // Critical: purge 85% of asset cache
        _purgeCount++;
        break;
    }

    notifyListeners();
  }

  /// Allocates asset memory with pre-flight check.
  bool canAllocate(int byteSize) {
    if (byteSize <= 0) return false;
    // Disallow single allocation larger than 60% of total pool capacity
    return byteSize < (pool.maxPoolSizeBytes * 0.60);
  }

  /// Records successful asset memory allocation.
  void registerAsset(String assetKey, int byteSize) {
    if (canAllocate(byteSize)) {
      pool.put(assetKey, byteSize);
      notifyListeners();
    }
  }
}
