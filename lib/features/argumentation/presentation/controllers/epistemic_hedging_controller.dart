import 'package:flutter/foundation.dart';

enum EpistemicCertaintyLevel {
  apodicticCategorical, // الجزم القاطع والبرهان الحاسم (Certainty / Gewissheit / 100%)
  probabilisticStrong,  // الترجيح القوي والظن الغالب (High Probability / Hohe Wahrscheinlichkeit / 75-90%)
  concessiveHypothetical, // التسليم الجدلي المشروط (Concession / Hypothetisch / 50%)
  cautiousTentative     // التحرز المعرفي والتسييج الدقيق (Tentative Hedging / Vorsichtige Einschränkung / 25-40%)
}

class ArgumentativeUnit {
  final String id;
  final EpistemicCertaintyLevel certaintyLevel;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String unhedgedAssertionAr; // القول الجازم الخالي من التحرز
  final String unhedgedAssertionEn;
  final String unhedgedAssertionDe;
  final String scholarlyHedgingAr; // الصياغة الأكاديمية الرصينة المشكولة شكلاً تاماً
  final String scholarlyHedgingEn;
  final String scholarlyHedgingDe;
  final String hedgingMarkerAr;
  final String hedgingMarkerEn;
  final String hedgingMarkerDe;
  final String toulminFunctionAr;
  final String toulminFunctionEn;
  final String toulminFunctionDe;
  final double epistemicScore; // 0.0 إلى 1.0 (مقياس دقة التسييج المنهجي)

  const ArgumentativeUnit({
    required this.id,
    required this.certaintyLevel,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.unhedgedAssertionAr,
    required this.unhedgedAssertionEn,
    required this.unhedgedAssertionDe,
    required this.scholarlyHedgingAr,
    required this.scholarlyHedgingEn,
    required this.scholarlyHedgingDe,
    required this.hedgingMarkerAr,
    required this.hedgingMarkerEn,
    required this.hedgingMarkerDe,
    required this.toulminFunctionAr,
    required this.toulminFunctionEn,
    required this.toulminFunctionDe,
    required this.epistemicScore,
  });
}

class EpistemicHedgingState {
  final EpistemicCertaintyLevel selectedCertainty;
  final List<ArgumentativeUnit> units;
  final String selectedUnitId;
  final bool showToulminBreakdown;
  final bool showContrastiveMarkers;

  const EpistemicHedgingState({
    this.selectedCertainty = EpistemicCertaintyLevel.cautiousTentative,
    this.units = const [],
    this.selectedUnitId = 'arg_tent_01',
    this.showToulminBreakdown = true,
    this.showContrastiveMarkers = true,
  });

  ArgumentativeUnit? get currentUnit {
    if (units.isEmpty) return null;
    return units.firstWhere(
      (u) => u.id == selectedUnitId,
      orElse: () => units.first,
    );
  }

  EpistemicHedgingState copyWith({
    EpistemicCertaintyLevel? selectedCertainty,
    List<ArgumentativeUnit>? units,
    String? selectedUnitId,
    bool? showToulminBreakdown,
    bool? showContrastiveMarkers,
  }) {
    return EpistemicHedgingState(
      selectedCertainty: selectedCertainty ?? this.selectedCertainty,
      units: units ?? this.units,
      selectedUnitId: selectedUnitId ?? this.selectedUnitId,
      showToulminBreakdown: showToulminBreakdown ?? this.showToulminBreakdown,
      showContrastiveMarkers: showContrastiveMarkers ?? this.showContrastiveMarkers,
    );
  }
}

class EpistemicHedgingController extends ChangeNotifier {
  EpistemicHedgingState _state = const EpistemicHedgingState();
  EpistemicHedgingState get state => _state;

  EpistemicHedgingController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultUnits = [
      // 1. التحرز المعرفي والتسييج الدقيق (Cautious Tentative)
      const ArgumentativeUnit(
        id: 'arg_tent_01',
        certaintyLevel: EpistemicCertaintyLevel.cautiousTentative,
        titleAr: 'التَّحَوُّطُ الاسْتِقْرَائِيُّ وَتَسْيِيجُ النَّتَائِجِ الأَوَّلِيَّةِ',
        titleEn: 'Epistemic Hedging: Mitigating Overgeneralization',
        titleDe: 'Vorsichtige Einschränkung: Vermeidendes Übergeneralisieren',
        unhedgedAssertionAr: 'هَذِهِ النَّتِيجَةُ تُثْبِتُ خَطَأَ كُلِّ النَّظَرِيَّاتِ السَّابِقَةِ.',
        unhedgedAssertionEn: 'This result proves that all previous theories are totally incorrect.',
        unhedgedAssertionDe: 'Dieses Ergebnis beweist, dass alle bisherigen Theorien völlig falsch sind.',
        scholarlyHedgingAr: 'فِي ضَوْءِ المُعْطَيَاتِ الرَّاهِنَةِ، يَسْتَأْنِسُ البَاحِثُ بِأَنَّ هَذِهِ الشَّوَاهِدَ قَدْ تُشِيرُ إِلَى مَنْحًى مُغَايِرٍ يَسْتَوْجِبُ إِعَادَةَ فَحْصِ الفَرَضِيَّةِ.',
        scholarlyHedgingEn: 'In light of current empirical data, these preliminary findings seem to suggest an alternative trajectory that may warrant re-evaluating the underlying hypothesis.',
        scholarlyHedgingDe: 'Angesichts der vorliegenden Befunde liegt die Vermutung nahe, dass diese Evidenz auf eine abweichende Tendenz hindeuten dürfte, die eine erneute Überprüfung nahelegt.',
        hedgingMarkerAr: 'يَسْتَأْنِسُ بِـ / قَدْ تُشِيرُ / يَسْتَوْجِبُ إِعَادَةَ الفَحْصِ',
        hedgingMarkerEn: 'In light of / seem to suggest / may warrant',
        hedgingMarkerDe: 'liegt die Vermutung nahe / hindeuten dürfte (Konjunktiv II) / nahelegt',
        toulminFunctionAr: 'قَيْدُ الحُجَّةِ (Qualifier): ضَبْطُ مَدَى انْطِبَاقِ الدَّعْوَى لِمَنْعِ الإِطْلَاقِ الجَزَافِيِّ.',
        toulminFunctionEn: 'Epistemic Modal Qualifier: constraining scope of claim to verified evidence.',
        toulminFunctionDe: 'Einschränkender Operator (Modalitätsqualifikator) zur wissenschaftlichen Absicherung.',
        epistemicScore: 0.98,
      ),

      // 2. الترجيح القوي والظن الغالب (Probabilistic Strong)
      const ArgumentativeUnit(
        id: 'arg_prob_01',
        certaintyLevel: EpistemicCertaintyLevel.probabilisticStrong,
        titleAr: 'التَّرْجِيحُ القَائِمُ عَلَى تَظَافُرِ القَرَائِنِ',
        titleEn: 'Probabilistic Warrants: Cumulative Corroboration',
        titleDe: 'Hohe Wahrscheinlichkeit durch konvergierende Indizien',
        unhedgedAssertionAr: 'المَشْرُوعُ سَيَنْجَحُ حَتْماً دُونَ أَدْنَى شَكٍّ.',
        unhedgedAssertionEn: 'The project will definitely succeed without any doubt.',
        unhedgedAssertionDe: 'Das Projekt wird zweifellos ohne jedes Risiko gelingen.',
        scholarlyHedgingAr: 'يُرَجِّحُ تَظَافُرُ الشَّوَاهِدِ التَّطْبِيقِيَّةِ أَنَّ المَشْرُوعَ يُوشِكُ أَنْ يُحَقِّقَ أَكْثَرَ أَهْدَافِهِ المَرْسُومَةِ بِكَفَاءَةٍ عَالِيَةٍ.',
        scholarlyHedgingEn: 'The convergence of practical evidence strongly indicates that the initiative is poised to achieve most of its strategic benchmarks with notable efficacy.',
        scholarlyHedgingDe: 'Das Zusammenspiel empirischer Indikatoren spricht mit hoher Wahrscheinlichkeit dafür, dass die Initiative ihre Zielvorgaben weitgehend erfüllen dürfte.',
        hedgingMarkerAr: 'يُرَجِّحُ تَظَافُرُ / يُوشِكُ أَنْ / أَكْثَرَ أَهْدَافِهِ',
        hedgingMarkerEn: 'convergence strongly indicates / poised to achieve / most of',
        hedgingMarkerDe: 'spricht mit hoher Wahrscheinlichkeit dafür / erfüllen dürfte',
        toulminFunctionAr: 'سَنَدُ الحُجَّةِ (Warrant): رَبْطُ المُعْطَيَاتِ بِالدَّعْوَى عَبْرَ قَرِينَةِ التَّظَافُرِ.',
        toulminFunctionEn: 'Corroborating Warrant linking multi-source data to justified probabilistic assertion.',
        toulminFunctionDe: 'Begründender Schluss (Warrant) zur Stützung der These durch konvergierende Belege.',
        epistemicScore: 0.94,
      ),

      // 3. التسليم الجدلي المشروط (Concessive Hypothetical)
      const ArgumentativeUnit(
        id: 'arg_conc_01',
        certaintyLevel: EpistemicCertaintyLevel.concessiveHypothetical,
        titleAr: 'المُوَازَنَةُ الاسْتِدْرَاكِيَّةُ وَالتَّسْلِيمُ الجَدَلِيُّ',
        titleEn: 'Concessive Counter-Balancing & Proleptic Rebuttal',
        titleDe: 'Konzessive Abwägung & Dialektische Entkräftung',
        unhedgedAssertionAr: 'رَأْيُ المُعَارِضِينَ بَاطِلٌ تَمَاماً وَلَا قِيمَةَ لَهُ.',
        unhedgedAssertionEn: 'The opponents\' view is completely invalid and utterly worthless.',
        unhedgedAssertionDe: 'Die Ansicht der Gegner ist vollkommen haltlos und wertlos.',
        scholarlyHedgingAr: 'سَلَّمْنَا جَدَلاً بِوَجَاهَةِ هَذَا المَأْخَذِ النَّظَرِيِّ، غَيْرَ أَنَّ التَّطْبِيقَ العَمَلِيَّ يُثْبِتُ اسْتِقْرَارَ النَّمُوذَجِ عِنْدَ الاخْتِبَارِ.',
        scholarlyHedgingEn: 'Even if we grant the conceptual validity of this critique for the sake of argument, practical execution demonstrates the model’s empirical resilience under rigorous testing.',
        scholarlyHedgingDe: 'Selbst wenn man diesen theoretischen Einwand hypothetisch einräumt, erweist sich das Modell in der praktischen Anwendung als bemerkenswert stabil.',
        hedgingMarkerAr: 'سَلَّمْنَا جَدَلاً بِـ / غَيْرَ أَنَّ / عِنْدَ الاخْتِبَارِ',
        hedgingMarkerEn: 'Even if we grant ... for the sake of argument / yet / under testing',
        hedgingMarkerDe: 'Selbst wenn man ... hypothetisch einräumt / erweist sich jedoch',
        toulminFunctionAr: 'الدَّفْعُ وَالاعْتِرَاضُ (Rebuttal): احْتِوَاءُ النَّقْدِ قَبْلَ رَدِّهِ بِبُرْهَانِ التَّجْرِبَةِ.',
        toulminFunctionEn: 'Anticipated Rebuttal neutralizing counter-claims through concessive reframing.',
        toulminFunctionDe: 'Dialektischer Einwand (Rebuttal) zur Vorwegnahme gegnerischer Argumente.',
        epistemicScore: 0.96,
      ),

      // 4. الجزم القاطع والبرهان الحاسم (Apodictic Categorical)
      const ArgumentativeUnit(
        id: 'arg_apod_01',
        certaintyLevel: EpistemicCertaintyLevel.apodicticCategorical,
        titleAr: 'البُرْهَانُ القَاطِعُ فِي مَقَامِ الحَقَائِقِ الثَّابِتَةِ',
        titleEn: 'Apodictic Grounds: Axiomatic Scholarly Demonstration',
        titleDe: 'Apodiktische Gewissheit bei axiomatischen Grundsätzen',
        unhedgedAssertionAr: 'أَنَا أَعْلَمُ أَنَّ الشَّمْسَ مَصْدَرُ الضَّوْءِ.',
        unhedgedAssertionEn: 'I just know that the sun gives light.',
        unhedgedAssertionDe: 'Ich weiß einfach, dass die Sonne Licht gibt.',
        scholarlyHedgingAr: 'مِمَّا ثَبَتَ بِالقَاطِعِ البُرْهَانِيِّ وَالإِجْمَاعِ العِلْمِيِّ أَنَّ الانْدِمَاجَ النَّوَوِيَّ هُوَ مَصْدَرُ إِشْعَاعِ النُّجُومِ.',
        scholarlyHedgingEn: 'It is conclusively established by deductive astrophysics and unanimous consensus that thermonuclear fusion powers stellar luminosity.',
        scholarlyHedgingDe: 'Es gilt in der Astrophysik als unumstößlich gesichert und konsensual belegt, dass Kernfusion die solare Strahlungsquelle darstellt.',
        hedgingMarkerAr: 'مِمَّا ثَبَتَ بِالقَاطِعِ البُرْهَانِيِّ / الإِجْمَاعِ العِلْمِيِّ',
        hedgingMarkerEn: 'conclusively established / unanimous consensus',
        hedgingMarkerDe: 'als unumstößlich gesichert / konsensual belegt',
        toulminFunctionAr: 'السَّنَدُ الجَذْرِيُّ (Backing): الاسْتِنَادُ إِلَى القَوَانِينِ الكُلِّيَّةِ القَطْعِيَّةِ.',
        toulminFunctionEn: 'Epistemic Backing anchoring claim in invariant scientific laws.',
        toulminFunctionDe: 'Axiomatische Stützung (Backing) durch naturwissenschaftliche Gesetzmäßigkeiten.',
        epistemicScore: 0.99,
      ),
    ];

    _state = _state.copyWith(
      units: defaultUnits,
      selectedUnitId: defaultUnits.first.id,
    );
  }

  void selectCertainty(EpistemicCertaintyLevel certainty) {
    final filtered = _state.units.where((u) => u.certaintyLevel == certainty).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedUnitId;
    _state = _state.copyWith(
      selectedCertainty: certainty,
      selectedUnitId: nextId,
    );
    notifyListeners();
  }

  void selectUnit(String id) {
    _state = _state.copyWith(selectedUnitId: id);
    notifyListeners();
  }

  void toggleToulminBreakdown() {
    _state = _state.copyWith(showToulminBreakdown: !_state.showToulminBreakdown);
    notifyListeners();
  }

  void toggleContrastiveMarkers() {
    _state = _state.copyWith(showContrastiveMarkers: !_state.showContrastiveMarkers);
    notifyListeners();
  }
}
