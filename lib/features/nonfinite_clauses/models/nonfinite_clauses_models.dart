import 'package:flutter/foundation.dart';

enum NonFiniteCategory {
  zuInfinitivVsBare(
    id: 'zu_infinitiv_vs_bare',
    titleAr: 'الْمَصْدَرُ الْمُؤَوَّلُ (أَنْ + الْمُضَارِعُ) مُقَابِلَ zu + Infinitiv',
    titleEn: 'German "zu + Infinitiv" vs. Bare Infinitive & Arabic "an + Subjunctive"',
    titleDe: 'Infinitiv mit „zu“ vs. reiner Infinitiv (Modalverben, gehen, bleiben)',
  ),
  purposeUmZuVsDamit(
    id: 'purpose_um_zu_damit',
    titleAr: 'جُمْلَةُ الْغَايَةِ: um...zu (وَحْدَةُ الْفَاعِلِ) مُقَابِلَ damit (اخْتِلَافُهُ)',
    titleEn: 'Purpose Clauses: Same-Subject "um...zu" vs. Different-Subject "damit"',
    titleDe: 'Finalsatz: „um ... zu“ (Subjektgleichheit) vs. „damit“ (Subjektwechsel)',
  ),
  withoutInsteadOfZu(
    id: 'without_instead_of_zu',
    titleAr: '«دُونَ أَنْ / بَدَلًا مِنْ أَنْ» مُقَابِلَ ohne...zu وَwithout + -ing',
    titleEn: '"ohne...zu / statt...zu" vs. "without / instead of + -ing"',
    titleDe: '„ohne/statt ... zu“ vs. „ohne dass / statt dass“',
  ),
  participlePrenominalLinksattribut(
    id: 'participle_linksattribut',
    titleAr: 'اسْمُ الْفَاعِلِ وَاسْمُ الْمَفْعُولِ كَنَعْتٍ مُتَقَدِّمٍ (Linksattribut)',
    titleEn: 'German Extended Pre-Nominal Participles vs. Post-Nominal Arabic/English',
    titleDe: 'Partizip I (-end) & Partizip II als erweitertes Linksattribut',
  ),
  gerundVsInfinitiveSelection(
    id: 'gerund_vs_infinitive',
    titleAr: 'الِاخْتِيَارُ بَيْنَ الْمَصْدَرِ (-ing) وَ(to + V) وَالْمَصْدَرِ الصَّرِيحِ',
    titleEn: 'English Gerund (-ing) vs. Infinitive (to V) & German "es ... zu"',
    titleDe: 'Englische Gerund-Verben vs. deutsches Korrelat „es ... zu“',
  ),
  danglingControlAlignment(
    id: 'dangling_control_alignment',
    titleAr: 'مُطَابَقَةُ صَاحِبِ الْحَالِ وَتَجَنُّبُ تَعْلِيقِ اسْمِ الْفَاعِلِ',
    titleEn: 'Subject Control & Avoiding Dangling Participles Across Three Languages',
    titleDe: 'Subjektkontrolle bei Partizipial- und Infinitivkonstruktionen',
  );

  const NonFiniteCategory({
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
class NonFiniteLessonUnit {
  const NonFiniteLessonUnit({
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
    required this.clauseTag,
    required this.pitfallAlertAr,
  });

  final String id;
  final NonFiniteCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String exampleAr;
  final String exampleEn;
  final String exampleDe;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String clauseTag;
  final String pitfallAlertAr;
}

@immutable
class NonFiniteDrillItem {
  const NonFiniteDrillItem({
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
  final NonFiniteCategory category;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
