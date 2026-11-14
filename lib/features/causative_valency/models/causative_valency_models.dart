import 'package:flutter/foundation.dart';

enum CausativeCategory {
  arabicMorphologicalCausative(
    id: 'arabic_morphological_causative',
    titleAr: 'التَّعْدِيَةُ الصَّرْفِيَّةُ (أَفْعَلَ / فَعَّلَ) وَمُقَابِلُهَا',
    titleEn: 'Arabic Morphological Causatives (Afʿala / Faʿʿala)',
    titleDe: 'Kausative Ableitung vs. analytisches „lassen / machen“',
  ),
  germanLassenDualUse(
    id: 'german_lassen_dual',
    titleAr: 'فِعْلُ «lassen» بَيْنَ الْإِذْنِ وَالتَّكْلِيفِ وَالْمَصْدَرِ الْمُزْدَوَجِ',
    titleEn: 'German "lassen": Permissive vs. Commissioned Causative',
    titleDe: '„lassen“ (Erlaubnis vs. Veranlassung) & Ersatzinfinitiv',
  ),
  englishCausativeVerbs(
    id: 'english_causative_verbs',
    titleAr: 'أَفْعَالُ السَّبَبِيَّةِ الْإِنْجِلِيزِيَّةُ (make / have / get / let)',
    titleEn: 'English Causatives: Bare Infinitive vs. "to"-Infinitive & Passive',
    titleDe: 'Englische Kausativa (make/have/get) im Vergleich zum Deutschen',
  ),
  factitivePosturePairs(
    id: 'factitive_posture_pairs',
    titleAr: 'أَزْوَاجُ الْفِعْلِ اللَّازِمِ وَالْمُتَعَدِّي (stellen/stehen، lay/lie)',
    titleEn: 'Factitive vs. Stative Pairs (stellen/stehen, legen/liegen, lay/lie)',
    titleDe: 'Kausative Positionsverben (legen/stellen/setzen vs. liegen/stehen/sitzen)',
  ),
  delegatedPassiveCausative(
    id: 'delegated_passive_causative',
    titleAr: 'التَّكْلِيفُ دُونَ ذِكْرِ الْمُنفِّذِ (had it repaired / reparieren lassen)',
    titleEn: 'Delegated Action Without Agent (have/get + V3 vs. lassen + Infinitiv)',
    titleDe: 'Passivischer Kausativ („Ich lasse das Buch binden“)',
  ),
  benefactiveDativeInterest(
    id: 'benefactive_dative_interest',
    titleAr: 'لَامُ التَّعْلِيلِ وَالِانْتِفَاعِ (Dativus Commodi / Benefactive)',
    titleEn: 'Benefactive Dative & "for"-Alternation Across Three Languages',
    titleDe: 'Dativus Commodi („Ich koche dir Tee“ / „Ich lasse mir helfen“)',
  );

  const CausativeCategory({
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
class CausativeLessonUnit {
  const CausativeLessonUnit({
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
    required this.valencyTag,
    required this.pitfallAlertAr,
  });

  final String id;
  final CausativeCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String exampleAr;
  final String exampleEn;
  final String exampleDe;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String valencyTag;
  final String pitfallAlertAr;
}

@immutable
class CausativeDrillItem {
  const CausativeDrillItem({
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
  final CausativeCategory category;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
