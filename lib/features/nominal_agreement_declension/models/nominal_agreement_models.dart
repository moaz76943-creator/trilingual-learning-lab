import 'package:flutter/foundation.dart';

enum DeclensionAgreementAxis {
  weakDefiniteDeclension(
    id: 'weak_definite',
    titleAr: 'النَّعْتُ الْمُعَرَّفُ وَالتَّصْرِيفُ الضَّعِيفُ (der / die / das)',
    titleEn: 'Definite Article + Weak Adjective Declension (-e / -en)',
    titleDe: 'Schwache Deklination nach bestimmtem Artikel (der/die/das)',
  ),
  mixedIndefiniteDeclension(
    id: 'mixed_indefinite',
    titleAr: 'النَّعْتُ الْمُنَكَّرُ وَالتَّصْرِيفُ الْمُخْتَلَطُ (ein / kein / mein)',
    titleEn: 'Indefinite Article + Mixed Adjective Declension',
    titleDe: 'Gemischte Deklination nach ein / kein / Possessivartikel',
  ),
  strongZeroArticleDeclension(
    id: 'strong_zero_article',
    titleAr: 'التَّنْكِيرُ الْمَحْضُ وَالتَّصْرِيفُ الْقَوِيُّ بِدُونِ أَدَاةٍ',
    titleEn: 'Zero Article + Strong Adjective Endings',
    titleDe: 'Starke Deklination ohne Artikel (Nullartikel)',
  ),
  arabicNonHumanPluralAgreement(
    id: 'arabic_non_human_plural',
    titleAr: 'مُطَابَقَةُ جَمْعِ التَّكْسِيرِ لِغَيْرِ الْعَاقِلِ',
    titleEn: 'Arabic Non-Human Plural Feminine-Singular Agreement',
    titleDe: 'Kongruenz bei arabischen Sachpluralen vs. deutschem Plural',
  ),
  definitenessAndZeroArticle(
    id: 'definiteness_zero_article',
    titleAr: 'التَّعْرِيفُ الْجِنْسِيُّ وَالتَّجْرِيدِيُّ بَيْنَ اللُّغَاتِ',
    titleEn: 'Generic & Abstract Definiteness ("al-" vs. "the" vs. Zero)',
    titleDe: 'Bestimmter Artikel bei Abstrakta & Generika',
  ),
  predicativeVsAttributive(
    id: 'predicative_vs_attributive',
    titleAr: 'النَّعْتُ التَّابِعُ مُقَابِلَ الْخَبَرِ الْمُجَرَّدِ مِنَ اللَّوَاحِقِ',
    titleEn: 'Attributive Inflection vs. Invariable Predicative Adjectives',
    titleDe: 'Attributiv (flektiert) vs. prädikativ (unflektiert)',
  );

  const DeclensionAgreementAxis({
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
class NominalAgreementLesson {
  const NominalAgreementLesson({
    required this.id,
    required this.axis,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.exampleAr,
    required this.exampleEn,
    required this.exampleDe,
    required this.ruleAr,
    required this.ruleEn,
    required this.ruleDe,
    required this.declensionPatternTag,
    required this.pitfallAlertAr,
  });

  final String id;
  final DeclensionAgreementAxis axis;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String exampleAr;
  final String exampleEn;
  final String exampleDe;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String declensionPatternTag;
  final String pitfallAlertAr;
}

@immutable
class NominalAgreementDrill {
  const NominalAgreementDrill({
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
  final DeclensionAgreementAxis axis;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
