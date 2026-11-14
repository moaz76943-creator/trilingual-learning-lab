import 'package:flutter/foundation.dart';

enum PassageDomain {
  scientificHeritage(
    id: 'scientific_heritage',
    titleAr: 'التُّرَاثُ الْعِلْمِيُّ وَالْمَنْهَجُ التَّجْرِيبِيُّ',
    titleEn: 'Scientific Heritage & Empirical Method',
    titleDe: 'Wissenschaftserbe & Empirie',
  ),
  ethicalLeadership(
    id: 'ethical_leadership',
    titleAr: 'الْأَمَانَةُ وَالْإِتْقَانُ فِي الْعَمَلِ',
    titleEn: 'Integrity & Excellence in Work',
    titleDe: 'Verantwortung & Sorgfalt im Beruf',
  ),
  linguisticsAndTranslation(
    id: 'linguistics_translation',
    titleAr: 'عِلْمُ التَّرْجَمَةِ وَالْأَمَانَةُ الدَّلَالِيَّةُ',
    titleEn: 'Translation Science & Semantic Fidelity',
    titleDe: 'Übersetzungswissenschaft & Texttreue',
  ),
  sustainableEngineering(
    id: 'sustainable_engineering',
    titleAr: 'الْهَنْدَسَةُ الْمُسْتَدَامَةُ وَحِفْظُ الْمَوَارِدِ',
    titleEn: 'Sustainable Engineering & Resource Stewardship',
    titleDe: 'Nachhaltige Technik & Ressourcenschutz',
  ),
  travelAndCulture(
    id: 'travel_culture',
    titleAr: 'أَدَبُ الرِّحْلَةِ وَالتَّعَارُفُ الْحَضَارِيُّ',
    titleEn: 'Travel Literature & Cultural Exchange',
    titleDe: 'Reisekultur & Interkultureller Austausch',
  ),
  digitalCraftsmanship(
    id: 'digital_craftsmanship',
    titleAr: 'صِنَاعَةُ الْبَرْمَجِيَّاتِ وَالِاخْتِبَارُ الدَّقِيقُ',
    titleEn: 'Software Craftsmanship & Rigorous Testing',
    titleDe: 'Softwarequalität & Systematisches Testen',
  );

  const PassageDomain({
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
class TrilingualReadingPassage {
  const TrilingualReadingPassage({
    required this.id,
    required this.domain,
    required this.levelBadge,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.bodyAr,
    required this.bodyEn,
    required this.bodyDe,
    required this.keyTermsSummary,
  });

  final String id;
  final PassageDomain domain;
  final String levelBadge;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String bodyAr;
  final String bodyEn;
  final String bodyDe;
  final List<String> keyTermsSummary;
}

@immutable
class ClozeBlankItem {
  const ClozeBlankItem({
    required this.id,
    required this.domain,
    required this.targetLanguage,
    required this.sentenceWithBlankAr,
    required this.sentenceWithBlankEn,
    required this.sentenceWithBlankDe,
    required this.options,
    required this.correctIndex,
    required this.grammarReasonAr,
  });

  final String id;
  final PassageDomain domain;
  final String targetLanguage;
  final String sentenceWithBlankAr;
  final String sentenceWithBlankEn;
  final String sentenceWithBlankDe;
  final List<String> options;
  final int correctIndex;
  final String grammarReasonAr;
}
