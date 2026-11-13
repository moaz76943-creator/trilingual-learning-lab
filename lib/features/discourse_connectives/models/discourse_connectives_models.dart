import 'package:flutter/foundation.dart';

enum DiscourseRelationType {
  causal(
    id: 'causal',
    titleAr: 'التَّعْلِيلُ وَالسَّبَبِيَّةُ',
    titleEn: 'Causal & Explanatory Relations',
    titleDe: 'Kausalität (weil, da, denn, wegen)',
  ),
  concessive(
    id: 'concessive',
    titleAr: 'الِاسْتِدْرَاكُ وَالْمُقَابَلَةُ الرَّغْمِيَّةُ',
    titleEn: 'Concessive & Counter-Expectation',
    titleDe: 'Konzessivität (obwohl, trotzdem, trotz)',
  ),
  consecutive(
    id: 'consecutive',
    titleAr: 'النَّتِيجَةُ وَالِاسْتِنْتَاجُ الْمَنْطِقِيُّ',
    titleEn: 'Consecutive & Inferential Result',
    titleDe: 'Konsekutivität (deshalb, sodass, infolgedessen)',
  ),
  purposive(
    id: 'purposive',
    titleAr: 'الْغَايَةُ وَالتَّعْلِيلُ الْمَقْصِدِيُّ',
    titleEn: 'Purposive & Final Clauses',
    titleDe: 'Finalität (damit, um ... zu, zwecks)',
  ),
  adversativeContrast(
    id: 'adversative_contrast',
    titleAr: 'التَّبَايُنُ وَالْمُقَارَنَةُ السِّيَاقِيَّةُ',
    titleEn: 'Adversative Contrast & Parallelism',
    titleDe: 'Adversativität (während, hingegen, jedoch)',
  ),
  additiveElaboration(
    id: 'additive_elaboration',
    titleAr: 'الْإِضَافَةُ وَالتَّدْرِيجُ الْحِجَاجِيُّ',
    titleEn: 'Additive Cohesion & Discourse Progression',
    titleDe: 'Addition & Steigerung (außerdem, darüber hinaus)',
  );

  const DiscourseRelationType({
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
class ConnectiveSyntaxTriplet {
  const ConnectiveSyntaxTriplet({
    required this.id,
    required this.relation,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.subordinatingAr,
    required this.adverbialOrPrepAr,
    required this.subordinatingEn,
    required this.adverbialOrPrepEn,
    required this.subordinatingDe,
    required this.adverbialOrPrepDe,
    required this.wordOrderRuleAr,
    required this.wordOrderRuleEn,
    required this.wordOrderRuleDe,
    required this.pitfallAlertAr,
    required this.germanPositionTag,
  });

  final String id;
  final DiscourseRelationType relation;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String subordinatingAr;
  final String adverbialOrPrepAr;
  final String subordinatingEn;
  final String adverbialOrPrepEn;
  final String subordinatingDe;
  final String adverbialOrPrepDe;
  final String wordOrderRuleAr;
  final String wordOrderRuleEn;
  final String wordOrderRuleDe;
  final String pitfallAlertAr;
  final String germanPositionTag;
}

@immutable
class DiscourseDrillItem {
  const DiscourseDrillItem({
    required this.id,
    required this.relation,
    required this.targetLanguage,
    required this.promptAr,
    required this.promptEn,
    required this.promptDe,
    required this.options,
    required this.correctIndex,
    required this.explanationAr,
  });

  final String id;
  final DiscourseRelationType relation;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
