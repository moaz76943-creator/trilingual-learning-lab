import 'package:flutter/foundation.dart';

enum EllipsisPhenomenonType {
  verbalGapping(
    id: 'verbal_gapping',
    titleAr: 'حَذْفُ الْفِعْلِ فِي الْعَطْفِ',
    titleEn: 'Verbal Gapping in Coordination',
    titleDe: 'Verb-Gapping (Ersparung im zweiten Konjunkt)',
  ),
  vpEllipsisAndObligatoryDeletion(
    id: 'vp_ellipsis_obligatory',
    titleAr: 'الْحَذْفُ الْوَاجِبُ وَإِسْقَاطُ الْجُمْلَةِ الْفِعْلِيَّةِ',
    titleEn: 'VP-Ellipsis & Obligatory Predicate Deletion',
    titleDe: 'Prädikatsellipse & Modalverb-Ersparung',
  ),
  sluicing(
    id: 'sluicing',
    titleAr: 'الْحَذْفُ بَعْدَ أَدَاةِ الِاسْتِفْهَامِ',
    titleEn: 'Sluicing (Wh-Remnant Ellipsis)',
    titleDe: 'Sluicing (W-Wort-Ellipse im Nebensatz)',
  ),
  nominalAndMorphemeEllipsis(
    id: 'nominal_morpheme_ellipsis',
    titleAr: 'حَذْفُ الْمُضَافِ وَالِاخْتِزَالُ الصَّرْفِيُّ',
    titleEn: 'Nominal Ellipsis & Compound Reduction',
    titleDe: 'Gruppen- & Komposita-Ellipse (Ergänzungsstrich)',
  ),
  proFormAnaphora(
    id: 'pro_form_anaphora',
    titleAr: 'الْإِحَالَةُ الضَّمِيرِيَّةُ وَبَدَائِلُ الْجُمَلِ',
    titleEn: 'Pro-Form Substitution & Anaphoric Correlates',
    titleDe: 'Pro-Formen (da-, es, so) & Anaphorik',
  ),
  cataphoricAnticipation(
    id: 'cataphoric_anticipation',
    titleAr: 'الْإِحَالَةُ الْبَعْدِيَّةُ وَضَمِيرُ الشَّأْنِ',
    titleEn: 'Cataphoric Pronouns & Anticipatory "It/Es"',
    titleDe: 'Katapher & Korrelat-„es“',
  );

  const EllipsisPhenomenonType({
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
class RecoveryMapping {
  const RecoveryMapping({
    required this.language,
    required this.elidedSurface,
    required this.recoveredFullForm,
    required this.omittedElementNote,
  });

  final String language;
  final String elidedSurface;
  final String recoveredFullForm;
  final String omittedElementNote;
}

@immutable
class EllipsisCaseStudy {
  const EllipsisCaseStudy({
    required this.id,
    required this.type,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.surfaceAr,
    required this.recoveredAr,
    required this.surfaceEn,
    required this.recoveredEn,
    required this.surfaceDe,
    required this.recoveredDe,
    required this.analysisAr,
    required this.analysisEn,
    required this.analysisDe,
    required this.constraintWarningAr,
    required this.mappings,
  });

  final String id;
  final EllipsisPhenomenonType type;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String surfaceAr;
  final String recoveredAr;
  final String surfaceEn;
  final String recoveredEn;
  final String surfaceDe;
  final String recoveredDe;
  final String analysisAr;
  final String analysisEn;
  final String analysisDe;
  final String constraintWarningAr;
  final List<RecoveryMapping> mappings;
}

@immutable
class EllipsisDrillQuestion {
  const EllipsisDrillQuestion({
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
  final EllipsisPhenomenonType type;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
