import 'package:flutter/foundation.dart';

enum FalseFriendCategory {
  verbSemantics(
    id: 'verb_semantics',
    titleAr: 'الْأَفْعَالُ الْمُتَشَابِهَةُ لَفْظًا وَالْمُخْتَلِفَةُ دَلَالَةً',
    titleEn: 'Deceptive Verb Cognates (bekommen vs. become)',
    titleDe: 'Verb-Verwechslungen (bekommen, übersehen, leihen)',
  ),
  adverbAndModalTraps(
    id: 'adverb_modal_traps',
    titleAr: 'الظُّرُوفُ وَالرَّوَابِطُ الْخَادِعَةُ (eventuell / fast)',
    titleEn: 'Adverbial & Temporal Traps (eventuell vs. eventually)',
    titleDe: 'Adverb-Fallen (aktuell, eventuell, fast, bald)',
  ),
  adjectiveNuances(
    id: 'adjective_nuances',
    titleAr: 'الصِّفَاتُ الْمُشْتَرَكَةُ الْأَصْلِ وَالْمُتَبَايِنَةُ مَعْنًى',
    titleEn: 'Adjectival False Friends (sensibel vs. sensible)',
    titleDe: 'Adjektiv-Fallen (sensibel, genial, seriös, sympathisch)',
  ),
  institutionalAndAcademic(
    id: 'institutional_academic',
    titleAr: 'الْمُصْطَلَحَاتُ الْأَكَادِيمِيَّةُ وَالْمُؤَسَّسِيَّةُ',
    titleEn: 'Academic & Institutional Traps (Gymnasium, Hochschule)',
    titleDe: 'Bildung & Institutionen (Gymnasium, Konfession, Chef)',
  ),
  everydayNouns(
    id: 'everyday_nouns',
    titleAr: 'الْأَسْمَاءُ الْيَوْمِيَّةُ الْمُتَقَارِبَةُ رَسْمًا',
    titleEn: 'Everyday Noun Divergences (Gift, Rat, Mappe)',
    titleDe: 'Alltagsnomen (Gift, Rat, Wand, Fabrik)',
  ),
  arabicCognateDivergence(
    id: 'arabic_cognate_divergence',
    titleAr: 'الْمُقْتَرَضَاتُ وَالدَّلَالَةُ الْمُتَحَوِّلَةُ بَيْنَ اللُّغَاتِ',
    titleEn: 'Loanword & Semantic Shift Across Arabic, English & German',
    titleDe: 'Bedeutungswandel bei Lehn- und Fremdwörtern',
  );

  const FalseFriendCategory({
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
class FalseFriendEntry {
  const FalseFriendEntry({
    required this.id,
    required this.category,
    required this.germanTerm,
    required this.englishLookalike,
    required this.trueGermanMeaningAr,
    required this.trueGermanMeaningEn,
    required this.trueGermanEquivalentEn,
    required this.trueEnglishMeaningAr,
    required this.trueEnglishEquivalentDe,
    required this.exampleDe,
    required this.exampleEn,
    required this.exampleAr,
    required this.warningNoteAr,
    required this.severityLabel,
  });

  final String id;
  final FalseFriendCategory category;
  final String germanTerm;
  final String englishLookalike;
  final String trueGermanMeaningAr;
  final String trueGermanMeaningEn;
  final String trueGermanEquivalentEn;
  final String trueEnglishMeaningAr;
  final String trueEnglishEquivalentDe;
  final String exampleDe;
  final String exampleEn;
  final String exampleAr;
  final String warningNoteAr;
  final String severityLabel;
}

@immutable
class FalseFriendDrillItem {
  const FalseFriendDrillItem({
    required this.id,
    required this.category,
    required this.promptAr,
    required this.promptEn,
    required this.promptDe,
    required this.options,
    required this.correctIndex,
    required this.explanationAr,
  });

  final String id;
  final FalseFriendCategory category;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
