import 'package:flutter/foundation.dart';

enum ReflexiveCategory {
  akkusativVsDativReflexive(
    id: 'akkusativ_vs_dativ',
    titleAr: 'ضَمِيرُ النَّصْبِ (mich) مُقَابِلَ ضَمِيرِ الْجَرِّ (mir)',
    titleEn: 'German Akkusativ (mich) vs. Dativ (mir) Reflexives',
    titleDe: 'Reflexivpronomen: Akkusativ (mich) vs. Dativ (mir + Akk.-Objekt)',
  ),
  trueReflexivesZeroEnglish(
    id: 'true_reflexives',
    titleAr: 'الْأَفْعَالُ الِانْعِكَاسِيَّةُ اللَّازِمَةُ فِي الْأَلْمَانِيَّةِ دُونَ الْإِنْجِلِيزِيَّةِ',
    titleEn: 'German True Reflexives vs. English Zero-Reflexives',
    titleDe: 'Echte reflexive Verben (sich erinnern, sich konzentrieren)',
  ),
  reciprocalTafaala(
    id: 'reciprocal_tafaala',
    titleAr: 'صِيغَةُ «تَفَاعَلَ» لِلتَّشَارُكِ مُقَابِلَ einander وَeach other',
    titleEn: 'Reciprocal Verbs (Tafāʿala vs. each other / einander)',
    titleDe: 'Reziproke Verben (einander / sich gegenseitig)',
  ),
  arabicMutaawaMiddleVoice(
    id: 'arabic_mutaawa',
    titleAr: 'الْمُطَاوَعَةُ الصَّرْفِيَّةُ (انْفَعَلَ / تَفَعَّلَ) وَمَعْنَى التَّحَوُّلِ',
    titleEn: 'Arabic Middle-Voice Mutaʿawa vs. Ergative/Reflexive Verbs',
    titleDe: 'Zustandsänderung: sich verändern / sich öffnen',
  ),
  emphaticSelfhood(
    id: 'emphatic_selfhood',
    titleAr: 'التَّوْكِيدُ بِـ «نَفْسِهِ / عَيْنِهِ» مُقَابِلَ selbst وَ-self',
    titleEn: 'Emphatic Intensifiers ("selbst" vs. Reflexive "sich")',
    titleDe: 'Intensifikator „selbst/selber“ vs. Reflexivpronomen „sich“',
  ),
  prepositionalReflexiveCollocations(
    id: 'prepositional_reflexive',
    titleAr: 'الْأَفْعَالُ الِانْعِكَاسِيَّةُ الْمُتَعَدِّيَةُ بِحَرْفِ جَرٍّ',
    titleEn: 'Reflexive Verbs with Fixed Prepositional Complements',
    titleDe: 'Reflexive Verben mit Präposition (sich vorbereiten auf)',
  );

  const ReflexiveCategory({
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
class ReflexiveLessonUnit {
  const ReflexiveLessonUnit({
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
    required this.caseTag,
    required this.pitfallAlertAr,
  });

  final String id;
  final ReflexiveCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String exampleAr;
  final String exampleEn;
  final String exampleDe;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String caseTag;
  final String pitfallAlertAr;
}

@immutable
class ReflexiveDrillItem {
  const ReflexiveDrillItem({
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
  final ReflexiveCategory category;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
