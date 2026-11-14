import 'package:flutter/foundation.dart';

enum WordOrderTopic {
  v2AndInversion(
    id: 'v2_and_inversion',
    titleAr: 'قَاعِدَةُ الْمَوْقِعِ الثَّانِي (V2) وَتَقْدِيمُ الظَّرْفِ',
    titleEn: 'V2 Verb-Second Constraint & Fronted Adverbials',
    titleDe: 'V2-Regel & Inversion bei besetztem Vorfeld',
  ),
  satzklammer(
    id: 'satzklammer',
    titleAr: 'الْقَوْسُ الْفِعْلِيُّ الْأَلْمَانِيُّ (Satzklammer)',
    titleEn: 'German Verb Bracket vs. Contiguous Verbal Clusters',
    titleDe: 'Satzklammer (Linke & Rechte Klammer im Hauptsatz)',
  ),
  tekamoloVsMpt(
    id: 'tekamolo_vs_mpt',
    titleAr: 'تَرْتِيبُ الظُّرُوفِ: TeKaMoLo مُقَابِلَ MPT',
    titleEn: 'Adverbial Sequencing: German TeKaMoLo vs. English MPT',
    titleDe: 'Mittelfeld-Reihenfolge: Temporal–Kausal–Modal–Lokal',
  ),
  dativeAccusativePronouns(
    id: 'dative_accusative_pronouns',
    titleAr: 'تَرْتِيبُ الْمَفْعُولَيْنِ وَالضَّمَائِرِ الْمُتَّصِلَةِ وَالْمُنْفَصِلَةِ',
    titleEn: 'Double-Object & Pronoun Ordering (Dativ vs. Akkusativ)',
    titleDe: 'Objektfolge: Nomen (Dativ→Akk) vs. Pronomen (Akk→Dativ)',
  ),
  arabicVsoVsSvo(
    id: 'arabic_vso_svo',
    titleAr: 'الْجُمْلَةُ الْفِعْلِيَّةُ (VSO) وَتَقْدِيمُ الْخَبَرِ وُجُوبًا',
    titleEn: 'Arabic VSO/SVO Alternation & Obligatory Predicate Fronting',
    titleDe: 'Arabische VSO-Grundstellung vs. SVO-Topikalisierung',
  ),
  negativeInversionAndEmphaticFronting(
    id: 'negative_inversion',
    titleAr: 'الْقَلْبُ التَّرْكِيبِيُّ عِنْدَ التَّقْدِيمِ النَّفْيِيِّ وَالْحَصْرِيِّ',
    titleEn: 'Negative & Restrictive Inversion in English & Arabic',
    titleDe: 'Hervorhebung im Vorfeld ohne Nebensatz-Spaltung',
  );

  const WordOrderTopic({
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
class WordOrderPattern {
  const WordOrderPattern({
    required this.id,
    required this.topic,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.sentenceAr,
    required this.sentenceEn,
    required this.sentenceDe,
    required this.slotBreakdownDe,
    required this.ruleAr,
    required this.ruleEn,
    required this.ruleDe,
    required this.pitfallAlertAr,
    required this.topologyTag,
  });

  final String id;
  final WordOrderTopic topic;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String sentenceAr;
  final String sentenceEn;
  final String sentenceDe;
  final String slotBreakdownDe;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String pitfallAlertAr;
  final String topologyTag;
}

@immutable
class WordOrderDrill {
  const WordOrderDrill({
    required this.id,
    required this.topic,
    required this.targetLanguage,
    required this.promptAr,
    required this.promptEn,
    required this.promptDe,
    required this.options,
    required this.correctIndex,
    required this.explanationAr,
  });

  final String id;
  final WordOrderTopic topic;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
