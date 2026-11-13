import 'package:flutter/foundation.dart';

enum ReportedSpeechCategory {
  declarativeShift(
    id: 'declarative_shift',
    titleAr: 'نَقْلُ الْخَبَرِ وَكَسْرُ هَمْزَةِ إِنَّ',
    titleEn: 'Declarative Shift & Backshifting',
    titleDe: 'Aussagesatz & Konjunktiv I',
  ),
  konjunktivEvidential(
    id: 'konjunktiv_evidential',
    titleAr: 'الْحِيَادُ الْإِخْبَارِيُّ وَالْبَدِيلُ الشَّرْطِيُّ',
    titleEn: 'Evidential Distance & Konjunktiv II Fallback',
    titleDe: 'Ersatzform (Konjunktiv II) & Distanz',
  ),
  interrogativeReported(
    id: 'interrogative_reported',
    titleAr: 'الِاسْتِفْهَامُ الْمَنْقُولُ وَتَرْتِيبُ الْجُمْلَةِ',
    titleEn: 'Reported Questions & Clause Order',
    titleDe: 'Indirekte Fragen & Nebensatzstellung',
  ),
  imperativeReporting(
    id: 'imperative_reporting',
    titleAr: 'نَقْلُ الْأَمْرِ وَالطَّلَبِ وَالتَّوْجِيهِ',
    titleEn: 'Reported Commands & Jussive Modals',
    titleDe: 'Indirekte Aufforderungen (sollen / mögen)',
  ),
  deicticReanchoring(
    id: 'deictic_reanchoring',
    titleAr: 'تَحَوُّلَاتُ الْإِحَالَةِ الزَّمَانِيَّةِ وَالْمَكَانِيَّةِ',
    titleEn: 'Temporal & Spatial Deictic Re-anchoring',
    titleDe: 'Deiktische Verschiebung (Ort & Zeit)',
  ),
  universalTruthException(
    id: 'universal_truth_exception',
    titleAr: 'اسْتِثْنَاءُ الْحَقَائِقِ الثَّابِتَةِ',
    titleEn: 'Universal Truth & Present-Relevance Exceptions',
    titleDe: 'Ausnahmen bei zeitlosen Wahrheiten',
  );

  const ReportedSpeechCategory({
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
class DeicticPair {
  const DeicticPair({
    required this.directAr,
    required this.indirectAr,
    required this.directEn,
    required this.indirectEn,
    required this.directDe,
    required this.indirectDe,
  });

  final String directAr;
  final String indirectAr;
  final String directEn;
  final String indirectEn;
  final String directDe;
  final String indirectDe;
}

@immutable
class ReportedSpeechScenario {
  const ReportedSpeechScenario({
    required this.id,
    required this.category,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.directAr,
    required this.indirectAr,
    required this.directEn,
    required this.indirectEn,
    required this.directDe,
    required this.indirectDe,
    required this.grammarRuleAr,
    required this.grammarRuleEn,
    required this.grammarRuleDe,
    required this.pitfallNoteAr,
    required this.deicticPairs,
    required this.registerTag,
  });

  final String id;
  final ReportedSpeechCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String directAr;
  final String indirectAr;
  final String directEn;
  final String indirectEn;
  final String directDe;
  final String indirectDe;
  final String grammarRuleAr;
  final String grammarRuleEn;
  final String grammarRuleDe;
  final String pitfallNoteAr;
  final List<DeicticPair> deicticPairs;
  final String registerTag;
}

@immutable
class ReportedSpeechDrill {
  const ReportedSpeechDrill({
    required this.id,
    required this.category,
    required this.promptAr,
    required this.promptEn,
    required this.promptDe,
    required this.options,
    required this.correctIndex,
    required this.explanationAr,
    required this.targetLanguage,
  });

  final String id;
  final ReportedSpeechCategory category;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
  final String targetLanguage;
}
