import 'package:flutter/foundation.dart';

/// Structured results from learning streak evaluation.
class StreakCalculationResult {
  final int currentStreak;
  final int longestStreak;
  final int totalActiveDays;
  final bool isStreakActiveToday;
  final DateTime? lastActiveDate;

  const StreakCalculationResult({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalActiveDays,
    required this.isStreakActiveToday,
    this.lastActiveDate,
  });
}

/// Service evaluating study timestamps into verifiable habit streaks.
class LearningStreakCalculator {
  /// Calculates current and longest streaks from raw [studySessionTimestamps].
  static StreakCalculationResult calculateStreak({
    required List<DateTime> studySessionTimestamps,
    DateTime? referenceNow,
    int allowedGraceDays = 0,
  }) {
    if (studySessionTimestamps.isEmpty) {
      return const StreakCalculationResult(
        currentStreak: 0,
        longestStreak: 0,
        totalActiveDays: 0,
        isStreakActiveToday: false,
        lastActiveDate: null,
      );
    }

    final now = referenceNow ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    // Normalize and deduplicate session dates
    final uniqueDates = <DateTime>{};
    for (final ts in studySessionTimestamps) {
      uniqueDates.add(DateTime(ts.year, ts.month, ts.day));
    }

    final sortedDates = uniqueDates.toList()..sort((a, b) => b.compareTo(a)); // Descending order
    final totalActiveDays = sortedDates.length;
    final lastActiveDate = sortedDates.first;

    final studiedToday = uniqueDates.contains(today);
    final studiedYesterday = uniqueDates.contains(yesterday);

    // Calculate current active streak
    int currentStreak = 0;
    if (studiedToday || studiedYesterday) {
      var checkDate = studiedToday ? today : yesterday;
      int graceRemaining = allowedGraceDays;

      for (final date in sortedDates) {
        if (date.isAfter(checkDate)) continue;

        final diff = checkDate.difference(date).inDays;
        if (diff == 0) {
          currentStreak++;
          checkDate = checkDate.subtract(const Duration(days: 1));
        } else if (diff <= (graceRemaining + 1)) {
          // Grace period covers gap
          graceRemaining -= (diff - 1);
          currentStreak++;
          checkDate = date.subtract(const Duration(days: 1));
        } else {
          break; // Gap too large, streak broken
        }
      }
    }

    // Calculate all-time longest streak
    int longestStreak = 0;
    if (sortedDates.isNotEmpty) {
      final ascDates = sortedDates.reversed.toList();
      int tempStreak = 1;

      for (var i = 0; i < ascDates.length - 1; i++) {
        final diff = ascDates[i + 1].difference(ascDates[i]).inDays;
        if (diff == 1) {
          tempStreak++;
        } else {
          if (tempStreak > longestStreak) longestStreak = tempStreak;
          tempStreak = 1;
        }
      }
      if (tempStreak > longestStreak) longestStreak = tempStreak;
    }

    if (currentStreak > longestStreak) {
      longestStreak = currentStreak;
    }

    return StreakCalculationResult(
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      totalActiveDays: totalActiveDays,
      isStreakActiveToday: studiedToday,
      lastActiveDate: lastActiveDate,
    );
  }
}
