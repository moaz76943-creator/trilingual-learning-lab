import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/assets/asset_memory_cache_guard.dart';
import 'package:trilingual_learning_lab/core/assets/lru_image_memory_pool.dart';

void main() {
  group('LruImageMemoryPool & AssetMemoryCacheGuard Critical Tests', () {
    test('LruImageMemoryPool tracks byte allocations and evicts LRU entries upon overflow', () {
      final pool = LruImageMemoryPool(maxPoolSizeBytes: 1000); // 1000 bytes cap

      expect(pool.isEmpty, isTrue);
      expect(pool.currentPoolSizeBytes, equals(0));

      pool.put('svg_astrolabe', 400);
      pool.put('svg_clepsydra', 400);

      expect(pool.entryCount, equals(2));
      expect(pool.currentPoolSizeBytes, equals(800));

      // Access astrolabe to refresh its LRU timestamp
      pool.touch('svg_astrolabe');

      // Add third entry of 400 bytes -> total 1200 > 1000 -> clepsydra must be evicted
      pool.put('svg_quadrant', 400);

      expect(pool.currentPoolSizeBytes, lessThanOrEqualTo(1000));
      expect(pool.contains('svg_astrolabe'), isTrue); // Kept
      expect(pool.contains('svg_quadrant'), isTrue);   // Newly added
      expect(pool.contains('svg_clepsydra'), isFalse); // Evicted as LRU
    });

    test('AssetMemoryCacheGuard purges pool on memory pressure signals', () {
      final pool = LruImageMemoryPool(maxPoolSizeBytes: 10000);
      final guard = AssetMemoryCacheGuard(memoryPool: pool);

      pool.put('img1', 2000);
      pool.put('img2', 2000);
      pool.put('img3', 2000);
      expect(pool.currentPoolSizeBytes, equals(6000));

      // Moderate pressure trims ~35%
      guard.handleMemoryPressure(MemoryPressureLevel.moderate);
      expect(guard.currentPressure, equals(MemoryPressureLevel.moderate));
      expect(guard.purgeCount, equals(1));
      expect(pool.currentPoolSizeBytes, lessThan(5000));

      // Critical pressure purges ~85%
      guard.handleMemoryPressure(MemoryPressureLevel.critical);
      expect(guard.currentPressure, equals(MemoryPressureLevel.critical));
      expect(guard.purgeCount, equals(2));
      expect(pool.currentPoolSizeBytes, lessThan(2000));
    });

    test('AssetMemoryCacheGuard rejects single allocations exceeding safety limit', () {
      final pool = LruImageMemoryPool(maxPoolSizeBytes: 1000);
      final guard = AssetMemoryCacheGuard(memoryPool: pool);

      // Single item of 700 bytes is > 60% of 1000 bytes -> should be rejected
      expect(guard.canAllocate(700), isFalse);

      // Single item of 300 bytes is <= 60% -> allowed
      expect(guard.canAllocate(300), isTrue);
    });
  });
}
