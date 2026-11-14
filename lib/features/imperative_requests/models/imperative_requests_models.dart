import 'package:flutter/foundation.dart';

enum ImperativeCategory {
  imperativeMorphology(
    id: 'imperative_morphology',
    titleAr: 'صِيَاغَةُ فِعْلِ الْأَمْرِ (du / ihr / Sie) وَهَمْزَةُ الْوَصْلِ',
    titleEn: 'Imperative Formation: Arabic Jussive vs. German du/ihr/Sie',
    titleDe: 'Imperativformen: du (ohne -st), ihr (-t), Sie (Verb + Sie)',
  ),
  hollowDefectiveSeparable(
    id: 'hollow_defective_separable',
    titleAr: 'الْأَمْرُ مِنَ الْمُعْتَلِّ وَالْأَفْعَالِ الْمُنْفَصِلَةِ (Nimm! / Steh auf!)',
    titleEn: 'Vowel-Shift, Hollow/Defective & Separable Verb Imperatives',
    titleDe: 'Vokalwechsel (e→i: Lies!, Nimm!) & trennbare Verben (Steh auf!)',
  ),
  prohibitionVsNegation(
    id: 'prohibition_vs_negation',
    titleAr: 'النَّهْيُ (لَا النَّاهِيَةُ) مُقَابِلَ النَّفْيِ وَصِيَغِ التَّحْذِيرِ',
    titleEn: 'Prohibition (Do not / Lā al-Nāhiya) vs. Declarative Negation',
    titleDe: 'Verbot (Vergiss nicht!) vs. Verneinung',
  ),
  hortativeLetUs(
    id: 'hortative_let_us',
    titleAr: 'لَامُ الْأَمْرِ وَالْحَثُّ الْجَمَاعِيُّ (لِنَبْدَأْ / Let\'s / Fangen wir an!)',
    titleEn: '1st-Person Plural Hortatives (Let\'s vs. wir-Imperativ & Lām al-Amr)',
    titleDe: 'Adhortativ (Fangen wir an! / Lasst uns beginnen!)',
  ),
  politeMitigation(
    id: 'polite_mitigation',
    titleAr: 'تَلْطِيفُ الطَّلَبِ (Könnten Sie / Would you mind / مِنْ فَضْلِكَ)',
    titleEn: 'Polite Request Mitigation & Indirect Directives',
    titleDe: 'Höfliche Bitten (Konjunktiv II: Könnten Sie bitte...?)',
  ),
  impersonalInstructions(
    id: 'impersonal_instructions',
    titleAr: 'الْأَمْرُ غَيْرُ الشَّخْصِيِّ فِي اللَّافِتَاتِ وَالتَّعْلِيمَاتِ',
    titleEn: 'Impersonal Sign Directives & Infinitive Instructions',
    titleDe: 'Unpersönliche Anweisungen (Infinitiv: Bitte nicht stören!)',
  );

  const ImperativeCategory({
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
class ImperativeLessonUnit {
  const ImperativeLessonUnit({
    required this.id,
    required this.category,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.exampleAr,
    required this.exampleEn,
    required this.exampleDe,
    required this.ruleAr,
    required this.ruleEn,
    required this.ruleDe,
    required this.moodTag,
    required this.pitfallAlertAr,
  });

  final String id;
  final ImperativeCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String exampleAr;
  final String exampleEn;
  final String exampleDe;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String moodTag;
  final String pitfallAlertAr;
}

@immutable
class ImperativeDrillItem {
  const ImperativeDrillItem({
    required this.id,
    required this.category,
    required this.targetLanguage,
    required this.promptAr,
    required this.promptEn,
    required this.promptDe,
    required this.options,
    required this.correctIndex,
    required this.explanationAr,
  });

  final String id;
  final ImperativeCategory category;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
