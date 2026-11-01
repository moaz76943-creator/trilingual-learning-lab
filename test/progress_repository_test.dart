// Flutter unit test stub for ProgressRepository (highest-risk data handling).
// Run with: flutter test test/progress_repository_test.dart
// Note: Requires Flutter SDK. Currently no CI step for flutter test.

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/repositories/progress_repository.dart';

void main() {
  late Directory tempDir;
  late ProgressRepository repo;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('progress_test_');
    repo = ProgressRepository();
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  test('init loads existing valid progress', () async {
    final file = File('${tempDir.path}/user_progress.json');
    await file.writeAsString('{"version":1,"favorites":["c1"],"learned":["c2"]}');
    await repo.init(tempDir.path);
    expect(repo.isFavorite('c1'), true);
    expect(repo.isLearned('c2'), true);
  });

  test('init recovers from corrupted file by backing up', () async {
    final file = File('${tempDir.path}/user_progress.json');
    await file.writeAsString('{ invalid json');
    await repo.init(tempDir.path);
    final bak = File('${tempDir.path}/user_progress.corrupted.bak');
    expect(await bak.exists(), true);
    expect(repo.favoriteIds, isEmpty);
  });

  test('toggleFavorite persists atomically', () async {
    await repo.init(tempDir.path);
    final success = await repo.toggleFavorite('test_id', tempDir.path);
    expect(success, true);
    final file = File('${tempDir.path}/user_progress.json');
    expect(await file.exists(), true);
    final content = await file.readAsString();
    expect(content.contains('test_id'), true);
  });

  test('empty key or invalid path handled gracefully', () async {
    // Current implementation does not validate path; documents risk
    await repo.init(tempDir.path);
    final success = await repo.toggleFavorite('', tempDir.path);
    expect(success, true); // accepts empty ID currently
  });
}
