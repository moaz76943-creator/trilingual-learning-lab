import 'package:flutter/foundation.dart';

enum AspectualCategory {
  telicVsAtelic,       // الأفعال الغائية المحدودة مقابل المستمرة (Telic vs. Atelic / Grenzüberschreitung)
  habitualIterative,   // الديمومة والعادة والتكرار المتجدد (Habitual & Iterative / Habitualität)
  inchoativeIngressive, // لحظة الابتداء والشروع في الحدث (Ingressive & Inchoative / Beginnakt)
  anterioritySequence  // التراتبية والأسبقية الزمنية التتابعية (Anteriority & Sequence of Tenses)
}

class AspectScenario {
  final String id;
  final AspectualCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String sentenceAr; // الجملة العربية مشكولة شكلاً تاماً
  final String sentenceEn;
  final String sentenceDe;
  final String aspectualMarkerAr;
  final String aspectualMarkerEn;
  final String aspectualMarkerDe;
  final String aktionsartAnalysisAr;
  final String aktionsartAnalysisEn;
  final String aktionsartAnalysisDe;
  final double completionPercentage; // 0.0 (مستمر غير منجز) إلى 1.0 (تام منجز)

  const AspectScenario({
    required this.id,
    required this.category,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.sentenceAr,
    required this.sentenceEn,
    required this.sentenceDe,
    required this.aspectualMarkerAr,
    required this.aspectualMarkerEn,
    required this.aspectualMarkerDe,
    required this.aktionsartAnalysisAr,
    required this.aktionsartAnalysisEn,
    required this.aktionsartAnalysisDe,
    required this.completionPercentage,
  });
}

class TemporalAspectState {
  final AspectualCategory selectedCategory;
  final List<AspectScenario> scenarios;
  final String selectedScenarioId;
  final bool showAktionsartTimeline;
  final bool showAspectualContrast;

  const TemporalAspectState({
    this.selectedCategory = AspectualCategory.telicVsAtelic,
    this.scenarios = const [],
    this.selectedScenarioId = 'asp_tel_01',
    this.showAktionsartTimeline = true,
    this.showAspectualContrast = true,
  });

  AspectScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  TemporalAspectState copyWith({
    AspectualCategory? selectedCategory,
    List<AspectScenario>? scenarios,
    String? selectedScenarioId,
    bool? showAktionsartTimeline,
    bool? showAspectualContrast,
  }) {
    return TemporalAspectState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showAktionsartTimeline: showAktionsartTimeline ?? this.showAktionsartTimeline,
      showAspectualContrast: showAspectualContrast ?? this.showAspectualContrast,
    );
  }
}

class TemporalAspectController extends ChangeNotifier {
  TemporalAspectState _state = const TemporalAspectState();
  TemporalAspectState get state => _state;

  TemporalAspectController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. الأفعال الغائية (التامة) مقابل غير الغائية: أتم / يكتب
      const AspectScenario(
        id: 'asp_tel_01',
        category: AspectualCategory.telicVsAtelic,
        titleAr: 'الحَدَثُ الغَائِيُّ التَّامُّ مُقَابِلَ الحَدَثِ المَفْتُوحِ (Telic vs. Atelic)',
        titleEn: 'Telicity & Inherent Endpoint: Perfective Accomplishment vs. Activity',
        titleDe: 'Telizität: Vollendete Handlung (telisch) vs. Dauerhandlung (atelisch)',
        sentenceAr: 'أَتَمَّ البَاحِثُ تَأْلِيفَ مُؤَلَّفِهِ فِي عَامَيْنِ، بَعْدَمَا كَانَ يَكْتُبُ فِيهِ لَيْلَ نَهَارٍ.',
        sentenceEn: 'The scholar completed the authorship of his treatise in two years, after having written day and night.',
        sentenceDe: 'Der Gelehrte vollendete sein Werk innerhalb von zwei Jahren, nachdem er unablässig daran geschrieben hatte.',
        aspectualMarkerAr: 'الفِعْلُ المَزِيدُ (أَتَمَّ) دَالٌّ عَلَى التَّمَامِ الغَائِيِّ، بَيْنَمَا (كَانَ يَكْتُبُ) دَالٌّ عَلَى الاسْتِمْرَارِ.',
        aspectualMarkerEn: 'Telic accomplishment ("completed in two years") vs. atelic durative process ("having written").',
        aspectualMarkerDe: 'Perfektiver Aspekt mit Präfix-Semantik ("vollendete") vs. durative Verlaufsform.',
        aktionsartAnalysisAr: 'الأَفْعَالُ التَّامَّةُ (Telic) تَفْرِضُ وُصُولاً لِغَايَةٍ مُحَدَّدَةٍ تَسْتَوْجِبُ حَرْفَ الجَرِّ الدَّالِّ عَلَى الانْتِهَاءِ (فِي عَامَيْنِ).',
        aktionsartAnalysisEn: 'Telic predicates accept time-span adverbials ("in two years") but reject durational frame ("for two years").',
        aktionsartAnalysisDe: 'Telische Verben verlangen temporale Zeitspanne-Bestimmungen ("in zwei Jahren") statt reiner Zeitdauer.',
        completionPercentage: 1.0,
      ),

      // 2. الديمومة والعادة والتكرار المتجدد: كَانَ يَعْتَادُ / pflegte zu / used to
      const AspectScenario(
        id: 'asp_hab_01',
        category: AspectualCategory.habitualIterative,
        titleAr: 'الأُسْلُوبُ العَادِيُّ وَالتَّكْرَارُ الاسْتِمْرَارِيُّ (Habitual Aspect)',
        titleEn: 'Habitual Aspect: Iterative Customary Conduct',
        titleDe: 'Habitualität & Iterativität: Regelmäßige Gewohnheitshandlung',
        sentenceAr: 'كَانَ الصَّالِحُونَ يَعْتَادُونَ قِيَامَ اللَّيْلِ اسْتِزَادَةً فِي القُرْبِ وَالبِرِّ.',
        sentenceEn: 'The righteous were accustomed to observing the night vigil, seeking spiritual elevation.',
        sentenceDe: 'Die Rechtschaffenen pflegten in der Nacht zu wachen, um geistige Nähe zu erlangen.',
        aspectualMarkerAr: 'تَرْكِيبُ (كَانَ + يَفْعَلُ) أَوْ (يَعْتَادُ) يَنْقُلُ الفِعْلَ مِنْ حَدَثٍ عَابِرٍ إِلَى خُلُقٍ رَاسِخٍ.',
        aspectualMarkerEn: 'Periphrastic auxiliary ("used to observe / were accustomed to observing").',
        aspectualMarkerDe: 'Halb-Hilfsverb "pflegen zu + Infinitiv" zur expliziten Markierung der Habitualität.',
        aktionsartAnalysisAr: 'دَلَالَةُ الدَّيْمُومَةِ تُعَبِّرُ عَنْ عَمَلٍ يَتَكَرَّرُ بِانْتِظَامٍ فِي فَتْرَةٍ زَمَنِيَّةٍ مَفْتُوحَةٍ.',
        aktionsartAnalysisEn: 'Habituality maps singular episodes onto an iterative enduring behavioural schema.',
        aktionsartAnalysisDe: 'Der habituelle Aspekt hebt Einzelsituationen auf eine übergeordnete Gewohnheitsebene.',
        completionPercentage: 0.70,
      ),

      // 3. الشروع والابتداء: شَرَعَ / طَفِقَ / began to / ansetzen zu
      const AspectScenario(
        id: 'asp_inch_01',
        category: AspectualCategory.inchoativeIngressive,
        titleAr: 'أَفْعَالُ الشُّرُوعِ وَنُقْطَةُ الانْطِلَاقِ الحَدَثِيَّةِ (Ingressive Aspect)',
        titleEn: 'Ingressive Actionality: Inception & Entry into Dynamic State',
        titleDe: 'Ingressiver Aspekt: Der Augenblick des Handlungsbeginns',
        sentenceAr: 'طَفِقَ البَنَّاؤُونَ يُشَيِّدُونَ الصَّرْحَ مَعَ أَوَّلِ ضِيَاءِ الفَجْرِ.',
        sentenceEn: 'The builders commenced erecting the citadel with the very first glimmer of dawn.',
        sentenceDe: 'Die Baumeister machten sich daran, die Burg beim ersten Morgengrauen zu errichten.',
        aspectualMarkerAr: 'أَفْعَالُ الشُّرُوعِ النَّاسِخَةُ (طَفِقَ، شَرَعَ، أَنْشَأَ) يَلِيهَا فِعْلٌ مُضَارِعٌ مُجَرَّدٌ مِنْ (أَنْ).',
        aspectualMarkerEn: 'Ingressive phasal aspect verbs ("commenced / set about erecting").',
        aspectualMarkerDe: 'Präfixe des Handlungsbeginns ("errichten", "anbrechen") und phasenbezogene Wendungen.',
        aktionsartAnalysisAr: 'التَّرْكِيزُ عَلَى لَحْظَةِ تَحَوُّلِ الفِعْلِ مِنَ السُّكُونِ إِلَى الحَرَكَةِ دُونَ النَّظَرِ إِلَى نِهَايَتِهِ.',
        aktionsartAnalysisEn: 'Ingressive focus profiles the boundary crossing from non-activity into incipient event.',
        aktionsartAnalysisDe: 'Der Fokus liegt auf dem initialen Grenzpunkt des Geschehensverlaufs.',
        completionPercentage: 0.20,
      ),

      // 4. التراتبية والأسبقية الزمنية التتابعية: لَمَّا / قَدْ فَعَلَ / Pluperfect
      const AspectScenario(
        id: 'asp_ant_01',
        category: AspectualCategory.anterioritySequence,
        titleAr: 'الأَسْبَقِيَّةُ الزَّمَنِيَّةُ التَّتَابُعِيَّةُ (Past Anteriority / Vorzeitigkeit)',
        titleEn: 'Tense Harmony & Relative Anteriority: Pluperfect Sequencing',
        titleDe: 'Vorzeitigkeit im Präteritum: Plusquamperfekt & Temporale Konnektoren',
        sentenceAr: 'لَمَّا كَانَ القَائِدُ قَدْ أَحْكَمَ الخُطَّةَ مُسْبَقاً، اسْتَقَرَّتِ الأُمُورُ بِيُسْرٍ.',
        sentenceEn: 'When the leader had already perfected the strategic plan beforehand, matters settled smoothly.',
        sentenceDe: 'Nachdem der Anführer den Plan bereits im Voraus vollendet hatte, verlief alles geordnet.',
        aspectualMarkerAr: 'اقْتِرَانُ (لَمَّا) الحِينِيَّةِ بِـ (قَدْ + الفِعْلِ المَاضِي) لِتَأْكِيدِ الفَرَاغِ التَّامِّ قَبْلَ وُقُوعِ التَّالِي.',
        aspectualMarkerEn: 'Past Perfect ("had perfected") marking relative anteriority prior to reference time ("settled").',
        aspectualMarkerDe: 'Plusquamperfekt mit Konjunktion "nachdem" zur strikten Einhaltung der Vorzeitigkeit.',
        aktionsartAnalysisAr: 'التَّمْيِيزُ الدَّقِيقُ بَيْنَ حَدَثَيْنِ مَاضِيَيْنِ لِإِثْبَاتِ أَنَّ أَحَدَهُمَا عِلَّةٌ سَابِقَةٌ لِلآخَرِ.',
        aktionsartAnalysisEn: 'Grammaticalized anteriority guarantees logical causality across consecutive narrative clauses.',
        aktionsartAnalysisDe: 'Die Consecutio Temporum verknüpft Vorzeitigkeit mit logischer Kausalabfolge.',
        completionPercentage: 1.0,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectCategory(AspectualCategory category) {
    final filtered = _state.scenarios.where((s) => s.category == category).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedScenarioId;
    _state = _state.copyWith(
      selectedCategory: category,
      selectedScenarioId: nextId,
    );
    notifyListeners();
  }

  void selectScenario(String id) {
    _state = _state.copyWith(selectedScenarioId: id);
    notifyListeners();
  }

  void toggleAktionsartTimeline() {
    _state = _state.copyWith(showAktionsartTimeline: !_state.showAktionsartTimeline);
    notifyListeners();
  }

  void toggleAspectualContrast() {
    _state = _state.copyWith(showAspectualContrast: !_state.showAspectualContrast);
    notifyListeners();
  }
}
