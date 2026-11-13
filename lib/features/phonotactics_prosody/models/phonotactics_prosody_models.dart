import 'package:flutter/foundation.dart';

enum PhonotacticsCategory {
  consonantAssimilation(
    id: 'consonant_assimilation',
    titleAr: 'الْإِدْغَامُ وَالْإِبْدَالُ الصَّوْتِيُّ وَاللَّامُ الشَّمْسِيَّةُ',
    titleEn: 'Consonant Assimilation & Allomorphic Sandhi',
    titleDe: 'Konsonantenassimilation & Auslautverhärtung',
  ),
  allophonicDistribution(
    id: 'allophonic_distribution',
    titleAr: 'التَّنَاوُبُ الصَّوْتِيُّ السِّيَاقِيُّ (ch / ق / ر)',
    titleEn: 'Contextual Allophony (Ich-Laut vs. Ach-Laut)',
    titleDe: 'Allophonie: Ich-Laut [ç] vs. Ach-Laut [x]',
  ),
  vowelLengthAndOrthography(
    id: 'vowel_length_orthography',
    titleAr: 'طُولُ الصَّوَائِتِ وَالْإِمْدَادُ الْإِمْلَائِيُّ',
    titleEn: 'Vowel Quantity, Gemination & Length Orthography',
    titleDe: 'Vokallänge (Dehnungs-h, ie) vs. Konsonantenverdopplung',
  ),
  stressAndSemanticShift(
    id: 'stress_semantic_shift',
    titleAr: 'النَّبْرُ الصَّوْتِيُّ وَتَغَيُّرُ الدَّلَالَةِ',
    titleEn: 'Lexical Stress Shifts & Verb Prefix Accentuation',
    titleDe: 'Wortakzent bei trennbaren vs. untrennbaren Verben',
  ),
  morphophonemicAlternation(
    id: 'morphophonemic_alternation',
    titleAr: 'الْإِعْلَالُ وَالتَّصْرِيفُ الصَّوْتِيُّ لِلنِّهَايَاتِ',
    titleEn: 'Morphophonemic Inflectional Allomorphy (-ed / -s / الإعلال)',
    titleDe: 'Umlautung & morphophonemischer Wechsel (Tag / Tage)',
  ),
  junctureAndGlottalRules(
    id: 'juncture_glottal_rules',
    titleAr: 'هَمْزَةُ الْوَصْلِ وَالْقَطْعِ وَالْوَقْفُ الصَّوْتِيُّ',
    titleEn: 'Glottal Onset, Liaison & Word-Boundary Juncture',
    titleDe: 'Knacklaut [ʔ] (Glottisschlag) & Silbengrenzen',
  );

  const PhonotacticsCategory({
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
class PhoneticPairExample {
  const PhoneticPairExample({
    required this.orthography,
    required this.ipaTranscription,
    required this.glossAr,
  });

  final String orthography;
  final String ipaTranscription;
  final String glossAr;
}

@immutable
class PhonotacticsLesson {
  const PhonotacticsLesson({
    required this.id,
    required this.category,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.arabicExamples,
    required this.englishExamples,
    required this.germanExamples,
    required this.ruleAr,
    required this.ruleEn,
    required this.ruleDe,
    required this.articulationTipAr,
  });

  final String id;
  final PhonotacticsCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final List<PhoneticPairExample> arabicExamples;
  final List<PhoneticPairExample> englishExamples;
  final List<PhoneticPairExample> germanExamples;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String articulationTipAr;
}

@immutable
class PhonotacticsDrill {
  const PhonotacticsDrill({
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
  final PhonotacticsCategory category;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
