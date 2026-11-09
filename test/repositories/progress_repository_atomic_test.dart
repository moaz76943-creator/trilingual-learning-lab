import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/repositories/progress_repository.dart';

void main() {
  group('ProgressRepository Safe Atomic Persistence Tests', () {
    late Directory tempDir;
    late ProgressRepository repository;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('progress_atomic_test_');
      repository = ProgressRepository();
      await repository.init(tempDir);
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('Records concept and updates disk and memory state consistently', () async {
      final success = await repository.recordConceptMastered('concept_reading_stone_142');
      expect(success, isTrue);
      expect(repository.currentProgress.wordsLearned, 1);
      expect(repository.currentProgress.todayReviewsCount, 1);
      expect(repository.currentProgress.masteredConceptIds, contains('concept_reading_stone_142'));
    });

    test('Persists state across complete repository reinitialization', () async {
      await repository.recordConceptMastered('concept_astrolabe_143');
      await repository.recordConceptMastered('concept_armillary_144');

      // Create new repository instance pointing to same storage
      final newRepo = ProgressRepository();
      await newRepo.init(tempDir);

      expect(newRepo.currentProgress.wordsLearned, 2);
      expect(newRepo.currentProgress.masteredConceptIds, contains('concept_astrolabe_143'));
      expect(newRepo.currentProgress.masteredConceptIds, contains('concept_armillary_144'));
    });
  });
}
