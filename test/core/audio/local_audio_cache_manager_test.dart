import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/audio/local_audio_cache_manager.dart';

void main() {
  group('LocalAudioCacheManager LRU & Deterministic Indexing', () {
    late LocalAudioCacheManager manager;

    setUp(() {
      manager = LocalAudioCacheManager(maxCacheSizeBytes: 1000); // 1000 bytes cap for testing
    });

    test('Generates deterministic SHA-256 keys for identical inputs', () {
      final key1 = LocalAudioCacheManager.generateCacheKey('صِنَاعَةُ الوَرَقِ', 'ar');
      final key2 = LocalAudioCacheManager.generateCacheKey('صِنَاعَةُ الوَرَقِ', 'ar');
      final keyEn = LocalAudioCacheManager.generateCacheKey('Paper making', 'en');

      expect(key1, equals(key2));
      expect(key1.length, equals(64));
      expect(key1, isNot(equals(keyEn)));
    });

    test('Puts and retrieves cached audio paths while updating access times', () {
      final key = LocalAudioCacheManager.generateCacheKey('Wasseruhr', 'de');
      manager.put(key: key, filePath: '/data/audio/de_wasseruhr.mp3', byteSize: 250);

      expect(manager.hasKey(key), isTrue);
      expect(manager.cachedFilesCount, equals(1));
      expect(manager.currentCacheSizeBytes, equals(250));

      final path = manager.getFilePath(key);
      expect(path, equals('/data/audio/de_wasseruhr.mp3'));
    });

    test('Evicts least-recently accessed entries when storage limit is exceeded', () {
      // Put 3 entries: 400 + 400 + 400 = 1200 bytes (exceeds 1000 bytes cap)
      manager.put(key: 'key_1', filePath: '/audio/1.mp3', byteSize: 400);
      manager.put(key: 'key_2', filePath: '/audio/2.mp3', byteSize: 400);

      // Access key_1 so key_2 becomes the oldest
      manager.getFilePath('key_1');

      // Now add key_3 (400 bytes). Total would be 1200, so key_2 should be evicted!
      manager.put(key: 'key_3', filePath: '/audio/3.mp3', byteSize: 400);

      expect(manager.currentCacheSizeBytes, lessThanOrEqualTo(1000));
      expect(manager.hasKey('key_1'), isTrue); // Retained because accessed
      expect(manager.hasKey('key_3'), isTrue); // Newly added
      expect(manager.hasKey('key_2'), isFalse); // Evicted as LRU
    });

    test('Clears entire cache index correctly', () {
      manager.put(key: 'a', filePath: '/a.mp3', byteSize: 100);
      manager.put(key: 'b', filePath: '/b.mp3', byteSize: 100);
      expect(manager.cachedFilesCount, equals(2));

      manager.clear();
      expect(manager.cachedFilesCount, equals(0));
      expect(manager.currentCacheSizeBytes, equals(0));
      expect(manager.isEmpty, isTrue);
    });
  });
}
