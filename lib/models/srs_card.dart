import 'dart:math';

class SRSCard {
  final String conceptId;
  int repetitions;
  int intervalDays;
  double easeFactor;
  DateTime nextReviewDate;
  DateTime? lastReviewedDate;

  SRSCard({
    required this.conceptId,
    this.repetitions = 0,
    this.intervalDays = 1,
    this.easeFactor = 2.5,
    required this.nextReviewDate,
    this.lastReviewedDate,
  });

  // خوارزمية SuperMemo-2 (SM-2) القياسية لحساب موعد المراجعة القادم
  void applyReview(int quality) {
    // quality: 1 = Again (خطأ), 3 = Hard (صعب), 4 = Good (جيد), 5 = Easy (سهل)
    lastReviewedDate = DateTime.now();

    if (quality >= 3) {
      if (repetitions == 0) {
        intervalDays = 1;
      } else if (repetitions == 1) {
        intervalDays = 6;
      } else {
        intervalDays = (intervalDays * easeFactor).round();
      }
      repetitions++;
    } else {
      repetitions = 0;
      intervalDays = 1;
    }

    // تعديل عامل السهولة (Ease Factor) بحد أدنى 1.3 لمنع تجمد البطاقة
    easeFactor = easeFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    easeFactor = max(1.3, easeFactor);

    nextReviewDate = DateTime.now().add(Duration(days: intervalDays));
  }

  Map<String, dynamic> toJson() => {
    'concept_id': conceptId,
    'repetitions': repetitions,
    'interval_days': intervalDays,
    'ease_factor': easeFactor,
    'next_review': nextReviewDate.toIso8601String(),
    'last_reviewed': lastReviewedDate?.toIso8601String(),
  };

  factory SRSCard.fromJson(Map<String, dynamic> json) => SRSCard(
    conceptId: json['concept_id'] ?? '',
    repetitions: json['repetitions'] ?? 0,
    intervalDays: json['interval_days'] ?? 1,
    easeFactor: (json['ease_factor'] ?? 2.5).toDouble(),
    nextReviewDate: DateTime.tryParse(json['next_review'] ?? '') ?? DateTime.now(),
    lastReviewedDate: DateTime.tryParse(json['last_reviewed'] ?? ''),
  );
}
