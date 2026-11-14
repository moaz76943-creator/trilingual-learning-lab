import 'package:flutter/foundation.dart';

enum VerbMorphologyAxis {
  triliteralMeasureShift(
    id: 'triliteral_measure_shift',
    titleAr: 'الْمِيزَانُ الصَّرْفِيُّ وَتَحَوُّلُ الْمَعْنَى بِالزِّيَادَةِ',
    titleEn: 'Arabic Derived Measures (Awzan) & Valency Shifts',
    titleDe: 'Wortbildung & Transitivität (lernen vs. lehren)',
  ),
  strongAblautSeries(
    id: 'strong_ablaut_series',
    titleAr: 'تَصْرِيفُ الْأَفْعَالِ الْقَوِيَّةِ وَتَبَدُّلُ الصَّائِتِ (Ablaut)',
    titleEn: 'German & English Strong Verb Ablaut Series',
    titleDe: 'Starke Verben & Ablautreihen (sprechen, schreiben)',
  ),
  habenVsSeinPerfekt(
    id: 'haben_vs_sein',
    titleAr: 'بِنَاءُ الْمَاضِي الْمُرَكَّبِ: haben مُقَابِلَ sein',
    titleEn: 'German Perfekt Auxiliary Selection (haben vs. sein)',
    titleDe: 'Perfektbildung: Zustands-/Ortswechsel (sein) vs. Objekt (haben)',
  ),
  hollowAndDefectiveArabic(
    id: 'hollow_defective_arabic',
    titleAr: 'الْأَفْعَالُ الْمُعْتَلَّةُ (الْأَجْوَفُ وَالنَّاقِصُ) وَالْجَزْمُ',
    titleEn: 'Arabic Hollow & Defective Verb Inflection',
    titleDe: 'Schwache/unregelmäßige Stämme & Vokalwechsel',
  ),
  separablePrefixInflection(
    id: 'separable_prefix',
    titleAr: 'الْأَفْعَالُ الْمُنْفَصِلَةُ وَمَوْضِعُ «ge-» وَ«zu»',
    titleEn: 'Separable Prefix Verbs in Finite, Perfekt & Infinitive Clauses',
    titleDe: 'Trennbare Verben: Satzklammer, Partizip II (-ge-) & zu-Infinitiv',
  ),
  mixedAndIrregularVerbs(
    id: 'mixed_irregular',
    titleAr: 'الْأَفْعَالُ الْمُخْتَلَطَةُ (Mixed Verbs) وَالشَّوَاذُّ',
    titleEn: 'Mixed Verbs (denken, wissen, bringen) & Suppletion',
    titleDe: 'Gemischte Verben (Rückumlaut + schwache Endung)',
  );

  const VerbMorphologyAxis({
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
class VerbParadigmEntry {
  const VerbParadigmEntry({
    required this.id,
    required this.axis,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.arabicRootAndMeasure,
    required this.arabicForms,
    required this.englishForms,
    required this.germanForms,
    required this.morphologyRuleAr,
    required this.morphologyRuleEn,
    required this.morphologyRuleDe,
    required this.pitfallAlertAr,
    required this.paradigmTag,
  });

  final String id;
  final VerbMorphologyAxis axis;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String arabicRootAndMeasure;
  final String arabicForms;
  final String englishForms;
  final String germanForms;
  final String morphologyRuleAr;
  final String morphologyRuleEn;
  final String morphologyRuleDe;
  final String pitfallAlertAr;
  final String paradigmTag;
}

@immutable
class VerbParadigmDrill {
  const VerbParadigmDrill({
    required this.id,
    required this.axis,
    required this.targetLanguage,
    required this.promptAr,
    required this.promptEn,
    required this.promptDe,
    required this.options,
    required this.correctIndex,
    required this.explanationAr,
  });

  final String id;
  final VerbMorphologyAxis axis;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
