import 'package:flutter/foundation.dart';

enum NumeralCategory {
  cardinalsPolarity(
    id: 'cardinals_polarity',
    titleAr: 'أَعْدَادُ ٣–١٠ وَمُخَالَفَةُ الْمَعْدُودِ',
    titleEn: 'Cardinals 3–10 & Arabic Gender Polarity',
    titleDe: 'Kardinalzahlen 3–10 & Pluralbildung',
  ),
  compoundAndReversedTens(
    id: 'compound_reversed_tens',
    titleAr: 'الْأَعْدَادُ الْمُرَكَّبَةُ (١١–١٩) وَقَلْبُ الْآحَادِ (٢١–٩٩)',
    titleEn: 'Compound Numbers (11–19) & German Reversed Units (21–99)',
    titleDe: 'Zusammengesetzte Zahlen (11–19) & Einer-vor-Zehner (21–99)',
  ),
  hundredsThousandsEinsEin(
    id: 'hundreds_thousands_eins_ein',
    titleAr: 'الْمِئَةُ وَالْأَلْفُ وَالْفَرْقُ بَيْنَ eins وَein',
    titleEn: 'Hundreds, Thousands & German eins vs. ein',
    titleDe: 'Hundert/Tausend & der Unterschied zwischen „eins“ und „ein“',
  ),
  ordinalsAndDates(
    id: 'ordinals_dates',
    titleAr: 'الْأَعْدَادُ التَّرْتِيبِيَّةُ وَصِيَغُ التَّوَارِيخِ',
    titleEn: 'Ordinal Numbers & Date Expressions',
    titleDe: 'Ordinalzahlen (-te / -ste) & Datumsangaben',
  ),
  clockTimeAsymmetry(
    id: 'clock_time_asymmetry',
    titleAr: 'السَّاعَةُ وَالتَّوْقِيتُ (halb drei = ٢:٣٠)',
    titleEn: 'Clock Time Asymmetry (German halb drei vs. half past two)',
    titleDe: 'Uhrzeit-Systematik (halb, Viertel vor/nach)',
  ),
  measurementPartitives(
    id: 'measurement_partitives',
    titleAr: 'أَسْمَاءُ الْمَقَادِيرِ وَالْمَكَايِيلِ وَتَمْيِيزُهَا',
    titleEn: 'Measurement & Partitive Nouns (Singular vs. Plural)',
    titleDe: 'Maß- und Mengenangaben (drei Liter vs. zwei Tassen)',
  );

  const NumeralCategory({
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
class NumeralsLessonUnit {
  const NumeralsLessonUnit({
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
  final NumeralCategory category;
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
class NumeralsDrillItem {
  const NumeralsDrillItem({
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
  final NumeralCategory category;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
