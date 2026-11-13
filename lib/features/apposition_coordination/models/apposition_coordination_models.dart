import 'package:flutter/foundation.dart';

enum AppositionCoordinationType {
  identicalApposition(
    id: 'identical_apposition',
    titleAr: 'الْبَدَلُ الْمُطَابِقُ وَتَطَابُقُ الْإِعْرَابِ',
    titleEn: 'Full Apposition & Case Agreement',
    titleDe: 'Apposition & Kasus-Kongruenz',
  ),
  partitiveAndInclusiveApposition(
    id: 'partitive_inclusive',
    titleAr: 'بَدَلُ الْبَعْضِ وَبَدَلُ الِاشْتِمَالِ',
    titleEn: 'Partitive & Associative Apposition',
    titleDe: 'Partitive & qualitative Zusatzangaben',
  ),
  sequentialCoordination(
    id: 'sequential_coordination',
    titleAr: 'عَطْفُ النَّسَقِ وَالتَّعْقِيبُ وَالتَّرَاخِي',
    titleEn: 'Sequential & Temporal Coordination',
    titleDe: 'Reihung & zeitliche Abfolge (und, dann, schließlich)',
  ),
  rectifyingCoordination(
    id: 'rectifying_coordination',
    titleAr: 'الْإِضْرَابُ وَالِاسْتِدْرَاكُ (بَلْ / لَكِنْ)',
    titleEn: 'Rectification & Contrastive Coordination',
    titleDe: 'Berichtigung & Gegensatz (sondern vs. aber)',
  ),
  clarificatoryReformulation(
    id: 'clarificatory_reformulation',
    titleAr: 'عَطْفُ الْبَيَانِ وَالتَّفْسِيرُ التَّوْضِيحِيُّ',
    titleEn: 'Clarificatory Reformulation & Exemplification',
    titleDe: 'Erläuternde Reformulierung (nämlich, d. h., bzw.)',
  ),
  parentheticalInsertion(
    id: 'parenthetical_insertion',
    titleAr: 'الْجُمْلَةُ الِاعْتِرَاضِيَّةُ وَتَخْلِيلُ الْخِطَابِ',
    titleEn: 'Parenthetical Discourse & Asides',
    titleDe: 'Parenthese & eingeschobene Erläuterungen',
  );

  const AppositionCoordinationType({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String titleDe;
}

@immutable
class StructuralComparisonItem {
  const StructuralComparisonItem({
    required this.id,
    required this.type,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.exampleAr,
    required this.exampleEn,
    required this.exampleDe,
    required this.grammarBreakdownAr,
    required this.grammarBreakdownEn,
    required this.grammarBreakdownDe,
    required this.punctuationAndCaseNoteAr,
    required this.commonMistakeAr,
    required this.registerLabel,
  });

  final String id;
  final AppositionCoordinationType type;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String exampleAr;
  final String exampleEn;
  final String exampleDe;
  final String grammarBreakdownAr;
  final String grammarBreakdownEn;
  final String grammarBreakdownDe;
  final String punctuationAndCaseNoteAr;
  final String commonMistakeAr;
  final String registerLabel;
}

@immutable
class AppositionDrillItem {
  const AppositionDrillItem({
    required this.id,
    required this.type,
    required this.targetLanguage,
    required this.promptAr,
    required this.promptEn,
    required this.promptDe,
    required this.options,
    required this.correctIndex,
    required this.rationaleAr,
  });

  final String id;
  final AppositionCoordinationType type;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String rationaleAr;
}
