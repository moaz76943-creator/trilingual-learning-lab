import 'package:flutter/foundation.dart';

enum DialogueContextDomain {
  academicLibrary(
    id: 'academic_library',
    titleAr: 'الْمَكْتَبَةُ وَالْبَحْثُ الْعِلْمِيُّ',
    titleEn: 'Academic & Library Desk',
    titleDe: 'Bibliothek & Forschung',
  ),
  pharmacyAndCare(
    id: 'pharmacy_care',
    titleAr: 'الصَّيْدَلِيَّةُ وَالِاسْتِشَارَةُ الصِّحِّيَّةُ',
    titleEn: 'Pharmacy & Health Inquiry',
    titleDe: 'Apotheke & Beratung',
  ),
  transitAndTravel(
    id: 'transit_travel',
    titleAr: 'مَحَطَّةُ الْقِطَارِ وَتَنْظِيمُ السَّفَرِ',
    titleEn: 'Transit & Schedule Changes',
    titleDe: 'Bahnhof & Reiseplanung',
  ),
  technicalCollaboration(
    id: 'technical_collaboration',
    titleAr: 'الْحِوَارُ التِّقْنِيُّ وَمُرَاجَعَةُ الْأَعْمَالِ',
    titleEn: 'Technical Review & Teamwork',
    titleDe: 'Technische Abstimmung',
  ),
  hospitalityAndEtiquette(
    id: 'hospitality_etiquette',
    titleAr: 'آدَابُ الضِّيَافَةِ وَالِاسْتِقْبَالِ',
    titleEn: 'Hospitality & Noble Etiquette',
    titleDe: 'Gastfreundschaft & Höflichkeit',
  ),
  conversationalRepair(
    id: 'conversational_repair',
    titleAr: 'اسْتِرَاتِيجِيَّاتُ التَّوْضِيحِ وَإِعَادَةِ الصِّيَاغَةِ',
    titleEn: 'Conversational Repair & Clarification',
    titleDe: 'Nachfragen & Missverständnisse klären',
  );

  const DialogueContextDomain({
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
class DialogueTurn {
  const DialogueTurn({
    required this.speakerRoleAr,
    required this.speakerRoleEn,
    required this.lineAr,
    required this.lineEn,
    required this.lineDe,
    required this.pragmaticNoteAr,
  });

  final String speakerRoleAr;
  final String speakerRoleEn;
  final String lineAr;
  final String lineEn;
  final String lineDe;
  final String pragmaticNoteAr;
}

@immutable
class SituationalDialogueScenario {
  const SituationalDialogueScenario({
    required this.id,
    required this.domain,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.registerBadge,
    required this.culturalTipAr,
    required this.turns,
  });

  final String id;
  final DialogueContextDomain domain;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String registerBadge;
  final String culturalTipAr;
  final List<DialogueTurn> turns;
}

@immutable
class RoleplayTurnChallenge {
  const RoleplayTurnChallenge({
    required this.id,
    required this.domain,
    required this.targetLanguage,
    required this.incomingPromptAr,
    required this.incomingPromptEn,
    required this.incomingPromptDe,
    required this.options,
    required this.correctIndex,
    required this.feedbackAr,
  });

  final String id;
  final DialogueContextDomain domain;
  final String targetLanguage;
  final String incomingPromptAr;
  final String incomingPromptEn;
  final String incomingPromptDe;
  final List<String> options;
  final int correctIndex;
  final String feedbackAr;
}
