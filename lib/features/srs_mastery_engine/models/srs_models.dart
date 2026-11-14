import 'package:flutter/foundation.dart';

enum RecallGrade {
  again(quality: 1, labelAr: 'أَنْسَاهُ (إِعَادَةٌ)', labelEn: 'Again', labelDe: 'Nochmal'),
  hard(quality: 3, labelAr: 'صَعْبٌ', labelEn: 'Hard', labelDe: 'Schwer'),
  good(quality: 4, labelAr: 'جَيِّدٌ', labelEn: 'Good', labelDe: 'Gut'),
  easy(quality: 5, labelAr: 'سَهْلٌ', labelEn: 'Easy', labelDe: 'Leicht');

  const RecallGrade({
    required this.quality,
    required this.labelAr,
    required this.labelEn,
    required this.labelDe,
  });

  final int quality;
  final String labelAr;
  final String labelEn;
  final String labelDe;
}

enum SrsDeckDomain {
  arabicSyntax(
    id: 'arabic_syntax',
    titleAr: 'دَقَائِقُ النَّحْوِ وَالْإِعْرَابِ',
    titleEn: 'Arabic Syntax & Case',
  ),
  germanRektionAndGender(
    id: 'german_rektion',
    titleAr: 'التَّعَدِّي وَالْأَجْنَاسُ الْأَلْمَانِيَّةُ',
    titleEn: 'German Rektion & Genus',
  ),
  englishContrastiveUsage(
    id: 'english_contrastive',
    titleAr: 'الْفُرُوقُ التَّرْكِيبِيَّةُ الْإِنْجِلِيزِيَّةُ',
    titleEn: 'English Contrastive Usage',
  ),
  trilingualCore(
    id: 'trilingual_core',
    titleAr: 'الْمُقَارَنَةُ الثُّلَاثِيَّةُ الْمُشْتَرَكَةُ',
    titleEn: 'Trilingual Cross-Mapping',
  );

  const SrsDeckDomain({
    required this.id,
    required this.titleAr,
    required this.titleEn,
  });

  final String id;
  final String titleAr;
  final String titleEn;
}

@immutable
class SrsReviewCard {
  const SrsReviewCard({
    required this.id,
    required this.domain,
    required this.promptAr,
    required this.promptEn,
    required this.promptDe,
    required this.answerAr,
    required this.answerEn,
    required this.answerDe,
    required this.mnemonicAr,
    required this.easeFactor,
    required this.intervalDays,
    required this.repetitions,
    required this.lapses,
    required this.dueEpochDays,
  });

  final String id;
  final SrsDeckDomain domain;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final String answerAr;
  final String answerEn;
  final String answerDe;
  final String mnemonicAr;
  final double easeFactor;
  final int intervalDays;
  final int repetitions;
  final int lapses;
  final int dueEpochDays;

  bool isDueOn(int currentEpochDays) => dueEpochDays <= currentEpochDays;

  bool get isMastered => repetitions >= 3 && intervalDays >= 6 && lapses == 0;

  SrsReviewCard copyWith({
    double? easeFactor,
    int? intervalDays,
    int? repetitions,
    int? lapses,
    int? dueEpochDays,
  }) {
    return SrsReviewCard(
      id: id,
      domain: domain,
      promptAr: promptAr,
      promptEn: promptEn,
      promptDe: promptDe,
      answerAr: answerAr,
      answerEn: answerEn,
      answerDe: answerDe,
      mnemonicAr: mnemonicAr,
      easeFactor: easeFactor ?? this.easeFactor,
      intervalDays: intervalDays ?? this.intervalDays,
      repetitions: repetitions ?? this.repetitions,
      lapses: lapses ?? this.lapses,
      dueEpochDays: dueEpochDays ?? this.dueEpochDays,
    );
  }

  Map<String, Object?> toJson() => {
        'id': id,
        'domain': domain.id,
        'promptAr': promptAr,
        'promptEn': promptEn,
        'promptDe': promptDe,
        'answerAr': answerAr,
        'answerEn': answerEn,
        'answerDe': answerDe,
        'mnemonicAr': mnemonicAr,
        'easeFactor': easeFactor,
        'intervalDays': intervalDays,
        'repetitions': repetitions,
        'lapses': lapses,
        'dueEpochDays': dueEpochDays,
      };

  factory SrsReviewCard.fromJson(Map<String, Object?> json) {
    final domainId = json['domain'] as String? ?? SrsDeckDomain.trilingualCore.id;
    final resolvedDomain = SrsDeckDomain.values.firstWhere(
      (d) => d.id == domainId,
      orElse: () => SrsDeckDomain.trilingualCore,
    );
    return SrsReviewCard(
      id: json['id'] as String,
      domain: resolvedDomain,
      promptAr: json['promptAr'] as String,
      promptEn: json['promptEn'] as String,
      promptDe: json['promptDe'] as String,
      answerAr: json['answerAr'] as String,
      answerEn: json['answerEn'] as String,
      answerDe: json['answerDe'] as String,
      mnemonicAr: json['mnemonicAr'] as String,
      easeFactor: (json['easeFactor'] as num).toDouble(),
      intervalDays: (json['intervalDays'] as num).toInt(),
      repetitions: (json['repetitions'] as num).toInt(),
      lapses: (json['lapses'] as num).toInt(),
      dueEpochDays: (json['dueEpochDays'] as num).toInt(),
    );
  }
}
