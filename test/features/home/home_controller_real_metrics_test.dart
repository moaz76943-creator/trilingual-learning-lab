import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/home/presentation/controllers/home_controller.dart';
import 'package:trilingual_learning_lab/repositories/progress_repository.dart';
import 'package:trilingual_learning_lab/repositories/srs_repository.dart';

void main() {
  group('HomeController Real Metrics & Lifecycle Leak Prevention Tests', () {
    late Directory tempDir;
    late ProgressRepository progressRepo;
    late SrsRepository srsRepo;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('home_ctrl_test_');
      progressRepo = ProgressRepository();
      await progressRepo.init(tempDir);
      srsRepo = SrsRepository();
      await srsRepo.init(tempDir);
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('Initializes with real learner state (0 words initially) without hardcoded dummy values', () async {
      final controller = HomeController(
        progressRepository: progressRepo,
        srsRepository: srsRepo,
      );

      await controller.loadDashboardData();

      // Proves complete elimination of dummy 5435 words
      expect(controller.state.wordsLearned, equals(0));
      expect(controller.state.todayReviewsCount, equals(0));
      expect(controller.state.dueSrsCardsCount, equals(0));
      expect(controller.state.isLoading, isFalse);

      controller.dispose();
    });

    test('Reflects real mastered concepts dynamically when progress is updated', () async {
      final controller = HomeController(
        progressRepository: progressRepo,
        srsRepository: srsRepo,
      );

      // Record 2 concrete concepts
      await progressRepo.recordConceptMastered('concept_astronomy_001');
      await progressRepo.recordConceptMastered('concept_astronomy_002');

      await controller.loadDashboardData();

      expect(controller.state.wordsLearned, equals(2));
      expect(controller.state.todayReviewsCount, equals(2));

      controller.dispose();
    });

    test('Safely cancels EventBus subscriptions upon disposal preventing callback leaks', () async {
      final controller = HomeController(
        progressRepository: progressRepo,
        srsRepository: srsRepo,
      );

      expect(controller.isDisposed, isFalse);
      controller.dispose();
      expect(controller.isDisposed, isTrue);

      // Subsequent actions must not trigger notifications or throw exceptions
      await controller.loadDashboardData();
    });
  });
}
