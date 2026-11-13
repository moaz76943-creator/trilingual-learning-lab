import 'package:flutter/foundation.dart';

enum NominalizationPatternType {
  verbalNounInfinitive(
    id: 'verbal_noun_infinitive',
    titleAr: 'الْمَصْدَرُ الصَّرِيحُ وَمَصْدَرُ الْفِعْلِ الْمُجَرَّدِ وَالْمَزِيدِ',
    titleEn: 'Substantivized Infinitives & Derived Verbal Nouns',
    titleDe: 'Substantivierter Infinitiv (das Lesen) & Masdar',
  ),
  suffixGenderDerivation(
    id: 'suffix_gender_derivation',
    titleAr: 'الْمَصْدَرُ الصِّنَاعِيُّ وَدَلَالَةُ اللَّوَاحِقِ عَلَى الْجِنْسِ',
    titleEn: 'Abstract Suffixes & Deterministic Noun Gender',
    titleDe: 'Derivationssuffixe (-ung, -heit, -keit, -nis) & Genus',
  ),
  clausalNominalization(
    id: 'clausal_nominalization',
    titleAr: 'الْمَصْدَرُ الْمُؤَوَّلُ (أَنْ / أَنَّ) مُقَابِلَ الْأُسْلُوبِ الِاسْمِيِّ',
    titleEn: 'Clausal Nominalization (Masdar Mu’awwal vs. Nominalstil)',
    titleDe: 'Nominalstil vs. Verbalstil (bei Ankunft / als er ankam)',
  ),
  gerundVsInfinitive(
    id: 'gerund_vs_infinitive',
    titleAr: 'إِعْمَالُ الْمَصْدَرِ وَالْفَرْقُ بَيْنَ الْجِرَانْدِ وَالْمَصْدَرِ',
    titleEn: 'Gerund (-ing) vs. Action Nominal & Arabic Iʿmal al-Masdar',
    titleDe: 'Gerundium vs. zu-Infinitiv & verbale Rektion',
  ),
  instanceAndMannerNouns(
    id: 'instance_manner_nouns',
    titleAr: 'اسْمُ الْمَرَّةِ وَاسْمُ الْهَيْئَةِ وَتَقْيِيدُ الْحَدَثِ',
    titleEn: 'Nouns of Instance (Ism al-Marra) & Manner (Ism al-Hay’a)',
    titleDe: 'Einmaligkeits- und Artbezeichnungen',
  ),
  participialNominalization(
    id: 'participial_nominalization',
    titleAr: 'اسْتِخْدَامُ اسْمِ الْفَاعِلِ وَالْمَفْعُولِ كَأَسْمَاءٍ مُسْتَقِلَّةٍ',
    titleEn: 'Adjectival & Participial Nominalization (der Lernende)',
    titleDe: 'Substantivierte Partizipien (der Studierende / das Gelesene)',
  );

  const NominalizationPatternType({
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
class DerivationMatrixEntry {
  const DerivationMatrixEntry({
    required this.baseVerbOrAdj,
    required this.derivedNounAr,
    required this.derivedNounEn,
    required this.derivedNounDe,
    required this.genderOrPatternTag,
  });

  final String baseVerbOrAdj;
  final String derivedNounAr;
  final String derivedNounEn;
  final String derivedNounDe;
  final String genderOrPatternTag;
}

@immutable
class NominalizationLesson {
  const NominalizationLesson({
    required this.id,
    required this.type,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.verbalFormAr,
    required this.nominalFormAr,
    required this.verbalFormEn,
    required this.nominalFormEn,
    required this.verbalFormDe,
    required this.nominalFormDe,
    required this.morphologyRuleAr,
    required this.morphologyRuleEn,
    required this.morphologyRuleDe,
    required this.pitfallNoteAr,
    required this.matrixEntries,
  });

  final String id;
  final NominalizationPatternType type;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String verbalFormAr;
  final String nominalFormAr;
  final String verbalFormEn;
  final String nominalFormEn;
  final String verbalFormDe;
  final String nominalFormDe;
  final String morphologyRuleAr;
  final String morphologyRuleEn;
  final String morphologyRuleDe;
  final String pitfallNoteAr;
  final List<DerivationMatrixEntry> matrixEntries;
}

@immutable
class NominalizationDrill {
  const NominalizationDrill({
    required this.id,
    required this.type,
    required this.targetLanguage,
    required this.promptAr,
    required this.promptEn,
    required this.promptDe,
    required this.options,
    required this.correctIndex,
    required this.explanationAr,
  });

  final String id;
  final NominalizationPatternType type;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
