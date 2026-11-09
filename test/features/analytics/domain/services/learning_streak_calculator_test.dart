import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/analytics/domain/services/learning_streak_calculator.dart';

void main() {
  group('LearningStreakCalculator Habit Mechanics', () {
    final refToday = DateTime(2026, 11, 10, 15, 0); // Reference time 3:00 PM

    test('Returns zero streak when no sessions exist', () {
      final result = LearningStreakCalculator.calculateStreak(
        studySessionTimestamps: const [],
        referenceNow: refToday,
      );

      expect(result.currentStreak, equals(0));
      expect(result.longestStreak, equals(0));
      expect(result.totalActiveDays, equals(0));
      expect(result.isStreakActiveToday, isFalse);
    });

    test('Calculates active streak including today and deduplicates same-day sessions', () {
      final sessions = [
        DateTime(2026, 11, 10, 8, 30),  // Today morning
        DateTime(2026, 11, 10, 14, 0),  // Today afternoon (dedup)
        DateTime(2026, 11, 9, 20, 0),   // Yesterday
        DateTime(2026, 11, 8, 19, 0),   // 2 days ago
      ];

      final result = LearningStreakCalculator.calculateStreak(
        studySessionTimestamps: sessions,
        referenceNow: refToday,
      );

      expect(result.currentStreak, equals(3));
      expect(result.longestStreak, equals(3));
      expect(result.totalActiveDays, equals(3));
      expect(result.isStreakActiveToday, isTrue);
    });

    test('Maintains streak if studied yesterday but not yet today', () {
      final sessions = [
        DateTime(2026, 11, 9, 21, 0), // Yesterday
        DateTime(2026, 11, 8, 20, 0), // 2 days ago
      ];

      final result = LearningStreakCalculator.calculateStreak(
        studySessionTimestamps: sessions,
        referenceNow: refToday,
      );

      expect(result.currentStreak, equals(2));
      expect(result.isStreakActiveToday, isFalse); // Pending study today
    });

    test('Breaks streak if missing more than allowed gap without grace', () {
      final sessions = [
        DateTime(2026, 11, 10, 9, 0), // Today
        // Missed Nov 9!
        DateTime(2026, 11, 8, 9, 0),  // 2 days ago
        DateTime(2026, 11, 7, 9, 0),  // 3 days ago
        DateTime(2026, 11, 6, 9, 0),  // 4 days ago
      ];

      final result = LearningStreakCalculator.calculateStreak(
        studySessionTimestamps: sessions,
        referenceNow: refToday,
        allowedGraceDays: 0,
      );

      expect(result.currentStreak, equals(1)); // Only today
      expect(result.longestStreak, equals(3)); // Nov 6, 7, 8
      expect(result.totalActiveDays, equals(4));
    });

    test('Grace day bridges a 1-day missed gap', () {
      final sessions = [
        DateTime(2026, 11, 10, 9, 0), // Today
        // Missed Nov 9!
        DateTime(2026, 11, 8, 9, 0),  // 2 days ago
      ];

      final result = LearningStreakCalculator.calculateStreak(
        studySessionTimestamps: sessions,
        referenceNow: refToday,
        allowedGraceDays: 1, // 1 grace day allowed
      );

      expect(result.currentStreak, equals(2));
    });
  });
}
