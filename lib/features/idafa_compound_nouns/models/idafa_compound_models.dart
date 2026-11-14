import 'package:flutter/foundation.dart';

enum CompoundIdafaCategory {
  idafaVsKomposita(
    id: 'idafa_vs_komposita',
    titleAr: 'الْإِضَافَةُ مُقَابِلَ الْمُرَكَّبَاتِ الْأَلْمَانِيَّةِ (Komposita)',
    titleEn: 'Arabic Head-Initial Idafa vs. German Head-Final Komposita',
    titleDe: 'Bestimmungswort + Grundwort (Genus folgt dem letzten Wort)',
  ),
  fugenElements(
    id: 'fugen_elements',
    titleAr: 'حُرُوفُ الرَّبْطِ (Fugenelemente) وَتَجْرِيدُ الْمُضَافِ',
    titleEn: 'German Linking Elements (-s-, -n-, -er-) & Idafa Bare Head',
    titleDe: 'Fugenelemente (-s-, -n-, -er-) bei Komposita',
  ),
  genitiveVsVonDativ(
    id: 'genitive_vs_von_dativ',
    titleAr: 'الْجَرُّ بِالْإِضَافَةِ مُقَابِلَ Genitiv وَvon + Dativ وَ\'s',
    titleEn: 'Genitive Possession: Arabic Idafa vs. German Genitiv & English \'s/of',
    titleDe: 'Genitiv-Attribut vs. umgangssprachliches „von + Dativ“',
  ),
  adjectivePlacementInIdafa(
    id: 'adjective_placement_idafa',
    titleAr: 'مَوْقِعُ النَّعْتِ فِي الْإِضَافَةِ وَالْمُرَكَّبِ الِاسْمِيِّ',
    titleEn: 'Adjective Placement & Case Marking in Idafa & Compounds',
    titleDe: 'Adjektiv-Kongruenz vor Komposita (die neue Universitätsbibliothek)',
  ),
  verbalSyntheticCompounds(
    id: 'verbal_synthetic_compounds',
    titleAr: 'الْإِضَافَةُ اللَّفْظِيَّةُ وَالْمُرَكَّبَاتُ الْمُشْتَقَّةُ',
    titleEn: 'Arabic Verbal Idafa vs. Synthetic Agentive Compounds',
    titleDe: 'Synthetische Komposita (-leser, -lehrer) & verbale Rektion',
  ),
  semanticAmbiguityScope(
    id: 'semantic_ambiguity_scope',
    titleAr: 'الْإِضَافَةُ الْمُتَسَلْسِلَةُ وَضَبْطُ اللَّبْسِ بِالشَّرْطَةِ',
    titleEn: 'Multi-Level Chains & Hyphenation (Bindestrich) Clarity',
    titleDe: 'Mehrfachkomposita & Durchkopplung mit Bindestrich',
  );

  const CompoundIdafaCategory({
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
class CompoundIdafaLessonUnit {
  const CompoundIdafaLessonUnit({
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
    required this.structureTag,
    required this.pitfallAlertAr,
  });

  final String id;
  final CompoundIdafaCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String exampleAr;
  final String exampleEn;
  final String exampleDe;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String structureTag;
  final String pitfallAlertAr;
}

@immutable
class CompoundIdafaDrillItem {
  const CompoundIdafaDrillItem({
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
  final CompoundIdafaCategory category;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
