import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/database/sqlite_database_service.dart';
import 'package:trilingual_learning_lab/features/analytics/presentation/controllers/analytics_dashboard_controller.dart';

void main() {
  group('AnalyticsDashboardController Metrics & Scholar Badges', () {
    late SqliteDatabaseService db;
    late AnalyticsDashboardController controller;

    setUp(() async {
      db = SqliteDatabaseService();
      await db.initialize();

      // Seed study sessions into learning_progress
      await db.insert('learning_progress', {
        'id': 'sess_1',
        'entity_id': 'category_174',
        'entity_type': 'category',
        'score': 100,
        'completed_at': '2026-11-10T08:00:00Z',
      });
      await db.insert('learning_progress', {
        'id': 'sess_2',
        'entity_id': 'quiz_astrolabe',
        'entity_type': 'quiz',
        'score': 90,
        'completed_at': '2026-11-09T08:00:00Z',
      });

      // Seed SRS cards
      await db.insert('srs_cards', {
        'id': 'card_1',
        'front_ar': 'أَسْطُرْلاَبٌ',
        'front_de': 'Astrolabium',
        'front_en': 'Astrolabe',
        'repetitions': 3,
        'interval_days': 12,
        'ease_factor': 2.5,
        'next_review': '2026-11-22T08:00:00Z',
        'created_at': '2026-11-01T08:00:00Z',
        'updated_at': '2026-11-10T08:00:00Z',
      });

      controller = AnalyticsDashboardController(databaseService: db);
    });

    test('Computes metrics, streaks, and unlocks initiate badge', () async {
      final refDate = DateTime(2026, 11, 10, 10, 0);
      await controller.loadAnalytics(referenceNow: refDate);

      expect(controller.isLoading, isFalse);
      final s = controller.summary!;

      expect(s.currentStreak, equals(2)); // Nov 9 & Nov 10
      expect(s.totalStudyDays, equals(2));
      expect(s.totalCardsReviewed, equals(1));
      expect(s.totalCardsMastered, equals(1)); // reps >= 3 & interval >= 10
      expect(s.completedCategories, equals(1));
      expect(s.completedQuizzes, equals(1));

      // Check Al-Khwarizmi's initiate badge is unlocked
      final khwarizmiBadge = s.badges.firstWhere((b) => b.id == 'badge_khwarizmi_initiate');
      expect(khwarizmiBadge.isUnlocked, isTrue);

      // Biruni 7-day streak badge is locked (only 2 days streak)
      final biruniBadge = s.badges.firstWhere((b) => b.id == 'badge_biruni_meridian');
      expect(biruniBadge.isUnlocked, isFalse);
    });
  });
}
