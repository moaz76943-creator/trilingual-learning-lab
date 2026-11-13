import 'package:flutter/foundation.dart';

enum NegationCategory {
  temporalAspectual,   // النفي الزمني المخصوص (لمْ، لنْ، ما، لا / Zeitbezogene Negation)
  litotesDoubleNeg,    // التهوين والنفي المضاعف لإفادة التوكيد (Litotes / Doppelte Verneinung)
  negativePolarity,    // كلمات القطبية السالبة (Negative Polarity Items / NPIs - überhaupt / at all)
  negationScopeAmbiguity // حيز النفي ونفي الكل مقابل كل النفي (Scope of Negation / Negationsskopus)
}

class NegationScenario {
  final String id;
  final NegationCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String positiveBaseAr; // الجملة المثبتة الأصلية
  final String positiveBaseEn;
  final String positiveBaseDe;
  final String negatedSentenceAr; // الجملة المنفية مشكولة شكلاً تاماً
  final String negatedSentenceEn;
  final String negatedSentenceDe;
  final String negativeOperatorAr;
  final String negativeOperatorEn;
  final String negativeOperatorDe;
  final String semanticAnalysisAr;
  final String semanticAnalysisEn;
  final String semanticAnalysisDe;
  final double rhetoricalSubtletyIndex; // 0.0 إلى 1.0 (مؤشر البلاغة والدقة الدلالية)

  const NegationScenario({
    required this.id,
    required this.category,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.positiveBaseAr,
    required this.positiveBaseEn,
    required this.positiveBaseDe,
    required this.negatedSentenceAr,
    required this.negatedSentenceEn,
    required this.negatedSentenceDe,
    required this.negativeOperatorAr,
    required this.negativeOperatorEn,
    required this.negativeOperatorDe,
    required this.semanticAnalysisAr,
    required this.semanticAnalysisEn,
    required this.semanticAnalysisDe,
    required this.rhetoricalSubtletyIndex,
  });
}

class SemanticNegationState {
  final NegationCategory selectedCategory;
  final List<NegationScenario> scenarios;
  final String selectedScenarioId;
  final bool showScopeVisualizer;
  final bool showPolarityConstraints;

  const SemanticNegationState({
    this.selectedCategory = NegationCategory.temporalAspectual,
    this.scenarios = const [],
    this.selectedScenarioId = 'neg_temp_01',
    this.showScopeVisualizer = true,
    this.showPolarityConstraints = true,
  });

  NegationScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  SemanticNegationState copyWith({
    NegationCategory? selectedCategory,
    List<NegationScenario>? scenarios,
    String? selectedScenarioId,
    bool? showScopeVisualizer,
    bool? showPolarityConstraints,
  }) {
    return SemanticNegationState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showScopeVisualizer: showScopeVisualizer ?? this.showScopeVisualizer,
      showPolarityConstraints: showPolarityConstraints ?? this.showPolarityConstraints,
    );
  }
}

class SemanticNegationController extends ChangeNotifier {
  SemanticNegationState _state = const SemanticNegationState();
  SemanticNegationState get state => _state;

  SemanticNegationController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. النفي الزمني المخصوص: لَمْ (قلب للماضي) مقابل لَنْ (تأبيد للمستقبل)
      const NegationScenario(
        id: 'neg_temp_01',
        category: NegationCategory.temporalAspectual,
        titleAr: 'النَّفْيُ الزَّمَنِيُّ المَخْصُوصُ: (لَمْ) الجَازِمَةُ وَ(لَنْ) النَّاصِبَةُ',
        titleEn: 'Aspectual Temporal Negation: Past Completed vs. Future Prospective',
        titleDe: 'Aspektuelle Negation: Vergangenheits- vs. Zukunftsnegation',
        positiveBaseAr: 'يَخُونُ الأَمَانَةَ وَيَغْدِرُ بِالعَهْدِ.',
        positiveBaseEn: 'He betrays trust and violates commitments.',
        positiveBaseDe: 'Er bricht das Vertrauen und verletzt Zusagen.',
        negatedSentenceAr: 'لَمْ يَخُنْ أَمَانَتَهُ مَاضِياً، وَلَنْ يَغْدِرَ بِعَهْدِهِ أَبَداً.',
        negatedSentenceEn: 'He never betrayed his trust in the past, nor shall he ever break his covenant.',
        negatedSentenceDe: 'Er hat weder je seine Treue gebrochen, noch wird er je sein Bündnis verletzen.',
        negativeOperatorAr: 'لَمْ (حَرْفُ نَفْيٍ وَجَزْمٍ وَقَلْبٍ) + لَنْ (حَرْفُ نَفْيٍ وَنَصْبٍ وَاسْتِقْبَالٍ)',
        negativeOperatorEn: 'Dual-temporal operators ("never in the past" vs. "shall not ever in the future")',
        negativeOperatorDe: 'Aspektuelle Negatoren ("weder in der Vergangenheit" vs. "noch künftig jemals")',
        semanticAnalysisAr: '(لَمْ) تَقْلِبُ زَمَنَ المُضَارِعِ إِلَى المَاضِي المُنْقَطِعِ، بَيْنَمَا (لَنْ) تُخَلِّصُهُ لِلْمُسْتَقْبَلِ مُؤَكَّدَةً انْتِفَاءَ الفِعْلِ.',
        semanticAnalysisEn: 'Arabic morphological tense-inverting particle "lam" contrasts with prospective absolute negative "lan".',
        semanticAnalysisDe: 'Präzise Verknüpfung von Tempuswechsel und Modus im Arabischen im Gegensatz zu periphrastischen Konstruktionen.',
        rhetoricalSubtletyIndex: 0.98,
      ),

      // 2. التهوين والنفي المضاعف: ليس ببعيد / nicht unklug / not uncommon (Litotes)
      const NegationScenario(
        id: 'neg_lito_01',
        category: NegationCategory.litotesDoubleNeg,
        titleAr: 'التَّهْوِينُ البَلَاغِيُّ بِالنَّفْيِ المُضَاعَفِ (Litotes)',
        titleEn: 'Rhetorical Litotes: Double Negation as Elegant Assertion',
        titleDe: 'Rhetorische Litotes: Doppelte Verneinung als stilvolle Bejahung',
        positiveBaseAr: 'هَذَا الأَمْرُ قَرِيبٌ جِدّاً وَمَأْلُوفٌ لِلْغَايَةِ.',
        positiveBaseEn: 'This matter is extremely close and widely recognized.',
        positiveBaseDe: 'Diese Angelegenheit ist sehr nah und allseits vertraut.',
        negatedSentenceAr: 'لَيْسَ هَذَا الفَتْحُ بِبَعِيدٍ، وَلَيْسَ هَذَا الرَّأْيُ بِغَيْرِ سَدِيدٍ.',
        negatedSentenceEn: 'This breakthrough is by no means far off, and such judgment is not unwise.',
        negatedSentenceDe: 'Dieser Durchbruch ist keineswegs fern, und dieser Entschluss ist nicht unklug.',
        negativeOperatorAr: 'لَيْسَ + البَاءُ الزَّائِدَةُ لِلتَّوْكِيدِ فِي خَبَرِ النَّفْيِ ("بِبَعِيدٍ")',
        negativeOperatorEn: 'Litotes ("by no means far" / "not unwise")',
        negativeOperatorDe: 'Litotes ("keineswegs fern" / "nicht unklug")',
        semanticAnalysisAr: 'نَفْيُ الضِّدِّ (لَيْسَ بِبَعِيدٍ) يُفِيدُ تَأْكِيدَ القُرْبِ مَعَ أَدَبِ التَّهْوِينِ وَعَدَمِ المُبَالَغَةِ الفَجَّةِ.',
        semanticAnalysisEn: 'Denying the contrary affirms the positive proposition with sophisticated modesty and rhetorical restraint.',
        semanticAnalysisDe: 'Die doppelte Verneinung schwächt die Behauptung formal ab, verstärkt sie jedoch psychologisch durch Eleganz.',
        rhetoricalSubtletyIndex: 0.95,
      ),

      // 3. كلمات القطبية السالبة: قَطُّ / أَحَدٌ / überhaupt / at all (NPIs)
      const NegationScenario(
        id: 'neg_npi_01',
        category: NegationCategory.negativePolarity,
        titleAr: 'كَلِمَاتُ القُطْبِيَّةِ السَّالِبَةِ المَخْصُوصَةِ (NPI Licensing)',
        titleEn: 'Negative Polarity Licensing: Strict Contextual Binding',
        titleDe: 'Negative Polaritätselemente: Strikt lizenzierte Negationsbegleiter',
        positiveBaseAr: 'رَأَيْتُ إِنْسَاناً فِي تِلْكَ البُقْعَةِ البَعِيدَةِ.',
        positiveBaseEn: 'I saw someone in that distant terrain.',
        positiveBaseDe: 'Ich sah jemanden in jener abgelegenen Gegend.',
        negatedSentenceAr: 'مَا رَأَيْتُ فِي تِلْكَ البُقْعَةِ أَحَداً قَطُّ، وَلَمْ أَرْضَ بِالظُّلْمِ طَرْفَةَ عَيْنٍ.',
        negatedSentenceEn: 'I did not see anyone whatsoever in that terrain, nor would I tolerate injustice in the slightest.',
        negatedSentenceDe: 'Ich sah in jener Gegend überhaupt niemanden, und ich duldete kein Unrecht im Geringsten.',
        negativeOperatorAr: 'مَا النَّافِيَةُ المُرَخَّصَةُ لِـ (أَحَدٍ) الاسْتِغْرَاقِيِّ وَظَرْفِ الاسْتِغْرَاقِ (قَطُّ)',
        negativeOperatorEn: 'NPI licensers ("anyone whatsoever", "in the slightest")',
        negativeOperatorDe: 'NPI-Partikeln ("überhaupt", "im Geringsten")',
        semanticAnalysisAr: 'كَلِمَاتٌ لَا تَجُوزُ إِلَّا فِي سِيَاقِ النَّفْيِ مِثْلُ (قَطُّ) لِلْمَاضِي، وَ(أَحَدٌ) لِاسْتِغْرَاقِ كُلِّ فَرْدٍ.',
        semanticAnalysisEn: 'Negative Polarity Items (NPIs) are ungrammatical in positive assertions and mandatory under downward-entailing operators.',
        semanticAnalysisDe: 'Polaritätselemente wie "überhaupt" oder "im Geringsten" verlangen zwingend einen negativen Skopus.',
        rhetoricalSubtletyIndex: 0.94,
      ),

      // 4. حيز النفي ونفي الكل مقابل كل النفي (Scope of Negation)
      const NegationScenario(
        id: 'neg_scope_01',
        category: NegationCategory.negationScopeAmbiguity,
        titleAr: 'حَيِّزُ النَّفْيِ: نَفْيُ الشُّمُولِ مُقَابِلَ شُمُولِ النَّفْيِ',
        titleEn: 'Scope Ambiguity: Partial Negation vs. Total Exclusion',
        titleDe: 'Negationsskopus: Partielle Einschränkung vs. Totale Verneinung',
        positiveBaseAr: 'كُلُّ مَا يَلْمَعُ ذَهَبٌ خَالِصٌ.',
        positiveBaseEn: 'All that glitters is pure gold.',
        positiveBaseDe: 'Alles, was glänzt, ist reines Gold.',
        negatedSentenceAr: 'لَيْسَ كُلُّ مَا يَبْرُقُ ذَهَباً (نَفْيُ البَعْضِ وَالشُّمُولِ لَا نَفْيُ الذَّاتِ).',
        negatedSentenceEn: 'Not all that glitters is gold (Partial: some glitters without being gold).',
        negatedSentenceDe: 'Nicht alles, was glänzt, ist Gold (Partielle Negation des Allquantors).',
        negativeOperatorAr: 'تَقْدِيمُ أَدَاةِ النَّفْيِ (لَيْسَ) عَلَى سُورِ الكُلِّ (كُلُّ) لِنَفْيِ الإِحَاطَةِ الشَّامِلَةِ',
        negativeOperatorEn: 'Fronted negation preceding universal quantifier ("Not all" vs. "All ... not")',
        negativeOperatorDe: 'Voranstellung der Negationspartikel vor den Allquantor ("Nicht alles")',
        semanticAnalysisAr: 'تَقْدِيمُ النَّفْيِ عَلَى (كُلّ) يَنْفِي الكُلِّيَّةَ فَقَطْ (أَيْ أَنَّ بَعْضَهُ ذَهَبٌ وَبَعْضَهُ لَيْسَ كَذَلِكَ).',
        semanticAnalysisEn: 'Negation commanding the universal quantifier (¬∀x) implies existential assertion of counter-examples.',
        semanticAnalysisDe: 'Der Skopus der Negation erfasst den Allquantor und erzeugt so eine logisch präzise Teilaussage.',
        rhetoricalSubtletyIndex: 0.96,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectCategory(NegationCategory category) {
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

  void toggleScopeVisualizer() {
    _state = _state.copyWith(showScopeVisualizer: !_state.showScopeVisualizer);
    notifyListeners();
  }

  void togglePolarityConstraints() {
    _state = _state.copyWith(showPolarityConstraints: !_state.showPolarityConstraints);
    notifyListeners();
  }
}
