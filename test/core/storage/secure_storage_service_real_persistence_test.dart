import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/storage/secure_storage_service.dart';

void main() {
  group('SecureStorageService Real Persistence Tests', () {
    late Directory testDir;
    late SecureStorageService storage;

    setUp(() async {
      testDir = await Directory.systemTemp.createTemp('secure_storage_test_');
      storage = SecureStorageService();
      await storage.init(testDir);
    });

    tearDown(() async {
      if (await testDir.exists()) {
        await testDir.delete(recursive: true);
      }
    });

    test('Writes value to disk and reads it back', () async {
      await storage.write(key: 'user_preferred_level', value: 'B1_ADVANCED');
      final value = await storage.read(key: 'user_preferred_level');
      expect(value, equals('B1_ADVANCED'));
    });

    test('Survives complete memory wipe by reloading from physical disk', () async {
      await storage.write(key: 'learner_token', value: 'sec_token_98765');
      
      // Simulate process termination by wiping in-memory cache and state
      storage.clearMemoryCacheOnly();

      // Reinitialize service pointing to same directory
      await storage.init(testDir);
      final restored = await storage.read(key: 'learner_token');
      expect(restored, equals('sec_token_98765'));
    });

    test('Deletes value permanently from both memory and disk', () async {
      await storage.write(key: 'temp_key', value: 'temp_value');
      await storage.delete(key: 'temp_key');

      storage.clearMemoryCacheOnly();
      await storage.init(testDir);

      final result = await storage.read(key: 'temp_key');
      expect(result, isNull);
    });
  });
}
