import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/models/srs_card.dart';
import 'package:trilingual_learning_lab/repositories/srs_repository.dart';

void main() {
  group('SM-2 SRS Due-Date and Interval Tests (Anti-Day-Only Bug)', () {
    late Directory tempDir;
    late SrsRepository repository;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('srs_repo_test_');
      repository = SrsRepository();
      repository.clearForTesting();
      await repository.init(tempDir);
    });

    tearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('Prevents false positive due-date when day matches but month/year differ', () {
      final now = DateTime(2026, 11, 9);
      // Card scheduled for next month on the 9th day
      final futureCard = SrsCard(
        id: 'card_future',
        conceptId: 'concept_001',
        repetitions: 2,
        easeFactor: 2.5,
        intervalDays: 30,
        nextReviewDate: DateTime(2026, 12, 9), // Same day-of-month, different month!
        lastReviewedDate: now,
      );

      // In the old bug: 9 == 9 would return TRUE!
      // In the new fix: it must return FALSE
      expect(futureCard.isDue(now), isFalse);

      // Same card checked on its actual due date must return TRUE
      expect(futureCard.isDue(DateTime(2026, 12, 9)), isTrue);
    });

    test('Executes SM-2 intervals (1 day, 6 days, and EF multiplication)', () {
      final start = DateTime(2026, 11, 9);
      var card = SrsCard(
        id: 'card_sm2',
        conceptId: 'concept_002',
        nextReviewDate: start,
        lastReviewedDate: start,
      );

      // First successful review (quality = 5) -> interval = 1 day
      card = card.review(5, start);
      expect(card.repetitions, 1);
      expect(card.intervalDays, 1);
      expect(card.nextReviewDate, equals(start.add(const Duration(days: 1))));

      // Second successful review (quality = 4) -> interval = 6 days
      card = card.review(4, card.nextReviewDate);
      expect(card.repetitions, 2);
      expect(card.intervalDays, 6);

      // Third successful review -> interval = (6 * EF).round()
      final thirdReviewDate = card.nextReviewDate;
      card = card.review(5, thirdReviewDate);
      expect(card.repetitions, 3);
      expect(card.intervalDays, greaterThanOrEqualTo(15));
    });

    test('Resets interval to 1 on review failure (quality < 3) while keeping EF >= 1.3 floor', () {
      final now = DateTime(2026, 11, 9);
      var card = SrsCard(
        id: 'card_fail',
        conceptId: 'concept_003',
        repetitions: 4,
        easeFactor: 1.4,
        intervalDays: 24,
        nextReviewDate: now,
        lastReviewedDate: now.subtract(const Duration(days: 24)),
      );

      // Failed review (quality = 1)
      card = card.review(1, now);
      expect(card.repetitions, 0);
      expect(card.intervalDays, 1);
      expect(card.easeFactor, greaterThanOrEqualTo(1.3)); // SM-2 absolute minimum floor
    });
  });
}
