import 'package:flutter/foundation.dart';

enum ModalAxisCategory {
  deonticVsEpistemic(
    id: 'deontic_vs_epistemic',
    titleAr: 'الْإِلْزَامُ التَّكْلِيفِيُّ مُقَابِلَ الِاسْتِنْتَاجِ الْعَقْلِيِّ',
    titleEn: 'Deontic Obligation vs. Epistemic Deduction',
    titleDe: 'Objektive Pflicht vs. subjektive Vermutung (müssen / dürfte)',
  ),
  negationAsymmetry(
    id: 'negation_asymmetry',
    titleAr: 'عَدَمُ اللُّزُومِ (لَا يَلْزَمُ) مُقَابِلَ التَّحْرِيمِ وَالْمَنْعِ (لَا يَجُوزُ)',
    titleEn: 'Negation Asymmetry: Prohibition vs. Absence of Necessity',
    titleDe: 'Verneinung: dürfen nicht vs. müssen nicht / brauchen nicht',
  ),
  permissionVsAbility(
    id: 'permission_vs_ability',
    titleAr: 'الْقُدْرَةُ الذَّاتِيَّةُ (يَسْتَطِيعُ) مُقَابِلَ الْإِذْنِ (يَجُوزُ لَهُ)',
    titleEn: 'Dynamic Ability vs. Institutional Permission',
    titleDe: 'Fähigkeit (können) vs. Erlaubnis (dürfen)',
  ),
  evidentialModals(
    id: 'evidential_modals',
    titleAr: 'نَقْلُ الرِّوَايَةِ وَالدَّعْوَى بِالْأَفْعَالِ النَّاقِصَةِ',
    titleEn: 'Evidential Report & Claim (is said to / claims to)',
    titleDe: 'Subjektive Modalverben: sollen (Hörensagen) vs. wollen (Behauptung)',
  ),
  pastCounterfactualModals(
    id: 'past_counterfactual',
    titleAr: 'الِاسْتِدْرَاكُ عَلَى الْمَاضِي (كَانَ يَنْبَغِي / كَانَ بِإِمْكَانِهِ)',
    titleEn: 'Past Counterfactual Modals & Double Infinitive',
    titleDe: 'Vergangenheit der Modalverben & Ersatzinfinitiv (hätte sollen)',
  ),
  politeVolition(
    id: 'polite_volition',
    titleAr: 'التَّأَدُّبُ فِي الطَّلَبِ وَالرَّغْبَةِ (أَوَدُّ / هَلْ لَكَ أَنْ)',
    titleEn: 'Polite Requests & Mitigated Volition',
    titleDe: 'Höfliche Bitten & Wünsche (möchten / könnten Sie)',
  );

  const ModalAxisCategory({
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
class ModalContrastUnit {
  const ModalContrastUnit({
    required this.id,
    required this.axis,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.deonticOrBaseAr,
    required this.epistemicOrContrastAr,
    required this.deonticOrBaseEn,
    required this.epistemicOrContrastEn,
    required this.deonticOrBaseDe,
    required this.epistemicOrContrastDe,
    required this.ruleAr,
    required this.ruleEn,
    required this.ruleDe,
    required this.trapAlertAr,
    required this.modalTag,
  });

  final String id;
  final ModalAxisCategory axis;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String deonticOrBaseAr;
  final String epistemicOrContrastAr;
  final String deonticOrBaseEn;
  final String epistemicOrContrastEn;
  final String deonticOrBaseDe;
  final String epistemicOrContrastDe;
  final String ruleAr;
  final String ruleEn;
  final String ruleDe;
  final String trapAlertAr;
  final String modalTag;
}

@immutable
class ModalDrillQuestion {
  const ModalDrillQuestion({
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
  final ModalAxisCategory axis;
  final String targetLanguage;
  final String promptAr;
  final String promptEn;
  final String promptDe;
  final List<String> options;
  final int correctIndex;
  final String explanationAr;
}
