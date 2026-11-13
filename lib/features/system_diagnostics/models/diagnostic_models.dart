import 'package:flutter/material.dart';

enum StudioDomainGroup {
  syntaxAndGrammar(
    id: 'syntax_grammar',
    titleAr: 'النَّحْوُ وَالتَّرَاكِيبُ الْإِعْرَابِيَّةُ',
    titleEn: 'Syntax & Grammatical Constructions',
    titleDe: 'Syntax & Satzstrukturen',
  ),
  semanticsAndPragmatics(
    id: 'semantics_pragmatics',
    titleAr: 'الدَّلَالَةُ وَالتَّدَاوُلِيَّةُ وَالْبَلَاغَةُ',
    titleEn: 'Semantics, Pragmatics & Rhetoric',
    titleDe: 'Semantik, Pragmatik & Rhetorik',
  ),
  morphologyAndPhonology(
    id: 'morphology_phonology',
    titleAr: 'الصَّرْفُ وَالِاشْتِقَاقُ وَالصَّوْتِيَّاتُ',
    titleEn: 'Morphology, Derivation & Phonotactics',
    titleDe: 'Morphologie, Wortbildung & Phonetik',
  ),
  discourseAndCorpus(
    id: 'discourse_corpus',
    titleAr: 'تَحْلِيلُ الْخِطَابِ وَالْمُتَلَازِمَاتُ اللَّفْظِيَّةُ',
    titleEn: 'Discourse Cohesion & Corpus Studies',
    titleDe: 'Diskursanalyse & Korpuslinguistik',
  );

  const StudioDomainGroup({
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
class TrilingualStudioDescriptor {
  const TrilingualStudioDescriptor({
    required this.id,
    required this.taskNumber,
    required this.group,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.summaryAr,
    required this.icon,
    required this.builder,
  });

  final String id;
  final int taskNumber;
  final StudioDomainGroup group;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String summaryAr;
  final IconData icon;
  final WidgetBuilder builder;
}

@immutable
class ModuleHealthReport {
  const ModuleHealthReport({
    required this.moduleId,
    required this.titleAr,
    required this.isHealthy,
    required this.verifiedItemsCount,
    required this.verifiedDrillsCount,
    required this.diagnosticNoteAr,
  });

  final String moduleId;
  final String titleAr;
  final bool isHealthy;
  final int verifiedItemsCount;
  final int verifiedDrillsCount;
  final String diagnosticNoteAr;
}
