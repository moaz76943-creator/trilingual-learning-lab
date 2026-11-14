import 'package:flutter/foundation.dart';

enum OrthographyCategory {
  germanCapitalizationNominalization(
    id: 'german_capitalization',
    titleAr: 'الْحُرُوفُ الْكَبِيرَةُ فِي الْأَلْمَانِيَّةِ (Großschreibung) وَالِاسْمِيَّةُ',
    titleEn: 'German Noun & Nominalization Capitalization vs. English & Arabic',
    titleDe: 'Groß- und Kleinschreibung (Nomen, Substantivierung)',
  ),
  szettVsDoubleS(
    id: 'szett_vs_double_s',
    titleAr: 'قَاعِدَةُ «ß» مُقَابِلَ «ss» (طُولُ الْحَرَكَةِ وَقِصَرُهَا)',
    titleEn: 'German ß vs. ss Rule (Long vs. Short Preceding Vowel)',
    titleDe: 's-Schreibung: ß nach langem Vokal/Diphthong vs. ss nach kurzem Vokal',
  ),
  arabicHamzaRules(
    id: 'arabic_hamza_rules',
    titleAr: 'ضَوَابِطُ الْهَمْزَةِ (الْوَصْلُ وَالْقَطْعُ وَأَقْوَى الْحَرَكَاتِ)',
    titleEn: 'Arabic Hamza Placement (Wasl/Qatʿ & Vowel-Strength Hierarchy)',
    titleDe: 'Arabische Hamza-Orthografie im Vergleich zu deutschen Umlauten',
  ),
  taaMarbutaVsHaa(
    id: 'taa_marbuta_vs_haa',
    titleAr: 'التَّاءُ الْمَرْبُوطَةُ (ـة) وَالْهَاءُ (ـه) وَالْأَلِفُ اللَّيِّنَةُ (ا / ى)',
    titleEn: 'Arabic Tāʾ Marbūṭa vs. Hāʾ & Alif Maqṣūra Distinction',
    titleDe: 'Auslaut-Unterscheidung im Arabischen (ـة vs. ـه / ا vs. ى)',
  ),
  trilingualCommaSyntax(
    id: 'trilingual_comma_syntax',
    titleAr: 'الْفَاصِلَةُ النَّحْوِيَّةُ: وُجُوبُهَا فِي الْأَلْمَانِيَّةِ مُقَابِلَ الْإِنْجِلِيزِيَّةِ',
    titleEn: 'Syntactic Comma Rules: Mandatory German Clause Commas vs. English',
    titleDe: 'Kommasetzung vor Nebensätzen („dass“, „weil“) & Infinitivgruppen',
  ),
  quotationMarksApostrophes(
    id: 'quotation_apostrophes',
    titleAr: 'عَلَامَاتُ التَّنْصِيصِ («...» / „...“) وَالْفَاصِلَةُ الْعُلْيَا (Apostroph)',
    titleEn: 'Quotation Marks & Apostrophe Rules Across Three Scripts',
    titleDe: 'Anführungszeichen („...“) & Apostroph-Verbot beim Genitiv-s',
  );

  const OrthographyCategory({
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
class OrthographyLessonUnit {
  const OrthographyLessonUnit({
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
    required this.scriptTag,
    required this.pitfallAlertAr,
  });

  final String id;
  final OrthographyCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String exampleAr;
  final String exampleEn;
  final String exampleDe;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String scriptTag;
  final String pitfallAlertAr;
}

@immutable
class OrthographyDrillItem {
  const OrthographyDrillItem({
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
  final OrthographyCategory category;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
