import 'package:flutter/foundation.dart';

enum InterrogativeCategory {
  negativeQuestionsBalaDoch(
    id: 'negative_questions_bala_doch',
    titleAr: 'الِاسْتِفْهَامُ الْمَنْفِيُّ وَالْجَوَابُ بـ «بَلَى» وَ«doch»',
    titleEn: 'Negative Questions & Affirmation (Arabic Balā vs. German Doch)',
    titleDe: 'Verneinte Fragen & Widerspruchspartikel „doch“',
  ),
  arabicPrepMaContraction(
    id: 'arabic_prep_ma_contraction',
    titleAr: 'حَذْفُ أَلِفِ «مَا» الِاسْتِفْهَامِيَّةِ (فِيمَ، عَمَّ، بِمَ) وَ«wo(r)-»',
    titleEn: 'Preposition + "mā" Alif Deletion vs. German wo(r)- & English Stranding',
    titleDe: 'Präpositionalfrage: „worüber / mit wem“ vs. „عَمَّ / مَعَ مَنْ“',
  ),
  spatialDirectionalWhere(
    id: 'spatial_directional_where',
    titleAr: 'أَيْنَ / إِلَى أَيْنَ / مِنْ أَيْنَ (wo / wohin / woher)',
    titleEn: 'Locative vs. Directional Interrogatives (wo / wohin / woher)',
    titleDe: 'Orts- vs. Richtungsfragen (wo? / wohin? / woher?)',
  ),
  indirectEmbeddedQuestions(
    id: 'indirect_embedded_questions',
    titleAr: 'الِاسْتِفْهَامُ غَيْرُ الْمُبَاشِرِ وَرُتْبَةُ الْفِعْلِ (ob / if)',
    titleEn: 'Indirect Embedded Questions: Verb-Final "ob" vs. English SVO',
    titleDe: 'Indirekte Fragesätze mit „ob“ und W-Wort (Verb am Ende)',
  ),
  questionTagsConfirmation(
    id: 'question_tags_confirmation',
    titleAr: 'أَسْئِلَةُ التَّأْكِيدِ الذَّيْلِيَّةُ (أَلَيْسَ كَذَلِكَ؟ / nicht wahr?)',
    titleEn: 'Variable English Echo Tags vs. Invariable German & Arabic Tags',
    titleDe: 'Bestätigungsfragen („nicht wahr?“, „oder?“) vs. Question Tags',
  ),
  selectiveWhichVsWhatKind(
    id: 'selective_which_what_kind',
    titleAr: 'التَّمِييزُ بَيْنَ التَّعْيِينِ (أَيُّ / welcher) وَالنَّوْعِ (was für ein)',
    titleEn: 'Set Selection ("which / welcher") vs. Kind/Quality ("what kind / was für ein")',
    titleDe: 'Auswahl („welcher?“) vs. Beschaffenheit („was für ein?“)',
  );

  const InterrogativeCategory({
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
class InterrogativeLessonUnit {
  const InterrogativeLessonUnit({
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
    required this.syntaxTag,
    required this.pitfallAlertAr,
  });

  final String id;
  final InterrogativeCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String exampleAr;
  final String exampleEn;
  final String exampleDe;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String syntaxTag;
  final String pitfallAlertAr;
}

@immutable
class InterrogativeDrillItem {
  const InterrogativeDrillItem({
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
  final InterrogativeCategory category;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
