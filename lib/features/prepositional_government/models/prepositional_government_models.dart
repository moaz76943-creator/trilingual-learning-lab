import 'package:flutter/foundation.dart';

enum PrepositionDomain {
  wechselpraepositionen(
    id: 'wechselpraepositionen',
    titleAr: 'الثَّبَاتُ الْمَكَانِيُّ مُقَابِلَ الْحَرَكَةِ وَالِاتِّجَاهِ',
    titleEn: 'Static Location vs. Directional Motion',
    titleDe: 'Wechselpräpositionen (Wo? Dativ vs. Wohin? Akkusativ)',
  ),
  verbalValencyContrast(
    id: 'verbal_valency_contrast',
    titleAr: 'تَغَيُّرُ الْمَعْنَى بِتَغَيُّرِ حَرْفِ الْجَرِّ (رَغِبَ فِي / عَنْ)',
    titleEn: 'Meaning Shifts via Preposition Alternation',
    titleDe: 'Bedeutungswechsel durch Präpositionswahl',
  ),
  fixedPrepositionalRektion(
    id: 'fixed_rektion',
    titleAr: 'التَّعَدِّي اللَّازِمُ بِالْحَرْفِ وَحِفْظُ التَّلَازُمِ',
    titleEn: 'Fixed Prepositional Government (Colligations)',
    titleDe: 'Feste Präpositionalrektion (warten auf, denken an)',
  ),
  temporalAnchoring(
    id: 'temporal_anchoring',
    titleAr: 'الظَّرْفِيَّةُ الزَّمَنِيَّةُ (مُنْذُ / قَبْلَ / خِلَالَ)',
    titleEn: 'Temporal Prepositions (at/on/in vs. seit/vor/in)',
    titleDe: 'Temporale Präpositionen (seit, vor, in, bis)',
  ),
  instrumentalAndCausal(
    id: 'instrumental_causal',
    titleAr: 'الْبَاءُ السَّبَبِيَّةُ وَالِاسْتِعَانَةُ وَالتَّعْلِيلُ',
    titleEn: 'Instrumental, Causal & Means Prepositions',
    titleDe: 'Instrumentale & kausale Präpositionen (durch, mit, wegen)',
  ),
  abstractMetaphoricalSpace(
    id: 'abstract_metaphorical',
    titleAr: 'الِاسْتِعْمَالُ الْمَجَازِيُّ لِحُرُوفِ الْجَرِّ',
    titleEn: 'Abstract & Metaphorical Prepositional Extensions',
    titleDe: 'Abstrakte & übertragene Präpositionalbedeutungen',
  );

  const PrepositionDomain({
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
class PrepositionalContrastPair {
  const PrepositionalContrastPair({
    required this.id,
    required this.domain,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.patternAAr,
    required this.patternBAr,
    required this.patternAEn,
    required this.patternBEn,
    required this.patternADe,
    required this.patternBDe,
    required this.caseOrValencyRuleAr,
    required this.caseOrValencyRuleEn,
    required this.caseOrValencyRuleDe,
    required this.pitfallAlertAr,
    required this.germanCaseTag,
  });

  final String id;
  final PrepositionDomain domain;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String patternAAr;
  final String patternBAr;
  final String patternAEn;
  final String patternBEn;
  final String patternADe;
  final String patternBDe;
  final String caseOrValencyRuleAr;
  final String caseOrValencyRuleEn;
  final String caseOrValencyRuleDe;
  final String pitfallAlertAr;
  final String germanCaseTag;
}

@immutable
class PrepositionDrillItem {
  const PrepositionDrillItem({
    required this.id,
    required this.domain,
    required this.targetLanguage,
    required this.promptAr,
    required this.promptEn,
    required this.promptDe,
    required this.options,
    required this.correctIndex,
    required this.explanationAr,
  });

  final String id;
  final PrepositionDomain domain;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
