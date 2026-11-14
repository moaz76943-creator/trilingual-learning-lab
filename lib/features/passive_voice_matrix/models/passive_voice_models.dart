import 'package:flutter/foundation.dart';

enum PassiveConstructionType {
  processualVsStatal(
    id: 'processual_vs_statal',
    titleAr: 'بِنَاءُ الْحَدَثِ (werden) مُقَابِلَ وَصْفِ الْحَالَةِ (sein)',
    titleEn: 'Processual Passive (werden) vs. Statal Passive (sein)',
    titleDe: 'Vorgangspassiv (wird geöffnet) vs. Zustandspassiv (ist geöffnet)',
  ),
  arabicMajhulVocalization(
    id: 'arabic_majhul',
    titleAr: 'الْمَبْنِيُّ لِلْمَجْهُولِ وَنَائِبُ الْفَاعِلِ وَالضَّبْطُ الصَّرْفِيُّ',
    titleEn: 'Arabic Majhul Vocalic Shift & Na’ib al-Faʿil',
    titleDe: 'Arabisches Passiv (Majhul) & Perfekt mit „worden“',
  ),
  agentAndInstrument(
    id: 'agent_and_instrument',
    titleAr: 'إِظْهَارُ الْفَاعِلِ وَالْوَسِيلَةِ (von / durch / by / with)',
    titleEn: 'Agent vs. Means Prepositions (von/durch vs. by/with)',
    titleDe: 'Agensangabe: von (Person/Urheber) vs. durch (Mittel/Ursache)',
  ),
  impersonalAndPrepositionalPassive(
    id: 'impersonal_prepositional',
    titleAr: 'الْمَبْنِيُّ لِلْمَجْهُولِ مِنَ اللَّازِمِ وَشِبْهِ الْجُمْلَةِ',
    titleEn: 'Impersonal Intransitive & Prepositional Passives',
    titleDe: 'Unpersönliches Passiv (Es wird gearbeitet / Hier wird gelernt)',
  ),
  modalPassiveClusters(
    id: 'modal_passive',
    titleAr: 'الْمَبْنِيُّ لِلْمَجْهُولِ مَعَ الْأَفْعَالِ النَّاقِصَةِ',
    titleEn: 'Modal Passive Infinitives (must be checked / muss geprüft werden)',
    titleDe: 'Passiv mit Modalverben (muss/kann + Partizip II + werden)',
  ),
  passiveAlternatives(
    id: 'passive_alternatives',
    titleAr: 'بَدَائِلُ الْمَبْنِيِّ لِلْمَجْهُولِ (sich lassen / -bar / man)',
    titleEn: 'German & English Passive Substitutes',
    titleDe: 'Passiversatzformen (sich lassen, sein + zu, -bar, man)',
  );

  const PassiveConstructionType({
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
class PassiveComparisonUnit {
  const PassiveComparisonUnit({
    required this.id,
    required this.type,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.activeOrBaseAr,
    required this.passiveFormAr,
    required this.activeOrBaseEn,
    required this.passiveFormEn,
    required this.activeOrBaseDe,
    required this.passiveFormDe,
    required this.ruleAr,
    required this.ruleEn,
    required this.ruleDe,
    required this.pitfallAlertAr,
    required this.auxiliaryTag,
  });

  final String id;
  final PassiveConstructionType type;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String activeOrBaseAr;
  final String passiveFormAr;
  final String activeOrBaseEn;
  final String passiveFormEn;
  final String activeOrBaseDe;
  final String passiveFormDe;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String pitfallAlertAr;
  final String auxiliaryTag;
}

@immutable
class PassiveDrillQuestion {
  const PassiveDrillQuestion({
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
  final PassiveConstructionType type;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
