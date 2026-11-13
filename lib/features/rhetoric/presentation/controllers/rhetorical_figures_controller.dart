import 'package:flutter/foundation.dart';

enum RhetoricalDomain {
  metaphor,       // الاستعارة والتشبيه (Metaphor & Simile / Metaphern)
  chiasmusAntithesis, // الطباق والمقابلة والعكس (Antithesis & Chiasmus)
  paronomasiaAssonance, // الجناس والسجع والجناس الاستهلالي (Paronomasia, Alliteration & Assonance)
  metonymyLitotes // الكناية والتهوين والإطناب (Metonymy, Litotes & Hyperbole)
}

class RhetoricalExample {
  final String id;
  final RhetoricalDomain domain;
  final String deviceNameAr;
  final String deviceNameEn;
  final String deviceNameDe;
  final String textAr; // مشكولة شكلاً تاماً
  final String textEn;
  final String textDe;
  final String explanationAr;
  final String explanationEn;
  final String explanationDe;
  final String conceptualMapping; // Source Domain -> Target Domain
  final List<String> salientKeywordsAr;
  final List<String> salientKeywordsEn;
  final List<String> salientKeywordsDe;

  const RhetoricalExample({
    required this.id,
    required this.domain,
    required this.deviceNameAr,
    required this.deviceNameEn,
    required this.deviceNameDe,
    required this.textAr,
    required this.textEn,
    required this.textDe,
    required this.explanationAr,
    required this.explanationEn,
    required this.explanationDe,
    required this.conceptualMapping,
    required this.salientKeywordsAr,
    required this.salientKeywordsEn,
    required this.salientKeywordsDe,
  });
}

class RhetoricalFiguresState {
  final RhetoricalDomain selectedDomain;
  final List<RhetoricalExample> examples;
  final String selectedExampleId;
  final bool showDeconstruction;
  final bool showTrilingualComparison;
  final double stylisticImpactScore;

  const RhetoricalFiguresState({
    this.selectedDomain = RhetoricalDomain.metaphor,
    this.examples = const [],
    this.selectedExampleId = 'met_01',
    this.showDeconstruction = true,
    this.showTrilingualComparison = true,
    this.stylisticImpactScore = 0.85,
  });

  RhetoricalExample? get currentExample {
    if (examples.isEmpty) return null;
    return examples.firstWhere(
      (e) => e.id == selectedExampleId,
      orElse: () => examples.first,
    );
  }

  RhetoricalFiguresState copyWith({
    RhetoricalDomain? selectedDomain,
    List<RhetoricalExample>? examples,
    String? selectedExampleId,
    bool? showDeconstruction,
    bool? showTrilingualComparison,
    double? stylisticImpactScore,
  }) {
    return RhetoricalFiguresState(
      selectedDomain: selectedDomain ?? this.selectedDomain,
      examples: examples ?? this.examples,
      selectedExampleId: selectedExampleId ?? this.selectedExampleId,
      showDeconstruction: showDeconstruction ?? this.showDeconstruction,
      showTrilingualComparison: showTrilingualComparison ?? this.showTrilingualComparison,
      stylisticImpactScore: stylisticImpactScore ?? this.stylisticImpactScore,
    );
  }
}

class RhetoricalFiguresController extends ChangeNotifier {
  RhetoricalFiguresState _state = const RhetoricalFiguresState();
  RhetoricalFiguresState get state => _state;

  RhetoricalFiguresController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultExamples = [
      // 1. الاستعارة والتشبيه: العلم نور / Wissen ist Licht / Knowledge is Light
      const RhetoricalExample(
        id: 'met_01',
        domain: RhetoricalDomain.metaphor,
        deviceNameAr: 'الاسْتِعَارَةُ المَكْنِيَّةُ وَالتَّصْرِيحِيَّةُ',
        deviceNameEn: 'Conceptual Metaphor & Tenor-Vehicle Mapping',
        deviceNameDe: 'Kognitive Metapher (Bildspender & Bildempfänger)',
        textAr: 'العِلْمُ نُورٌ يَبْدُدُ ظُلُمَاتِ الجَهْلِ المُرَكَّبِ.',
        textEn: 'Knowledge is a radiant beacon dispelling the gloom of ignorance.',
        textDe: 'Wissen ist ein strahlendes Licht, das das Dunkel der Unwissenheit vertreibt.',
        explanationAr: 'شُبِّهَ العِلْمُ بِالنُّورِ لِجَامِعِ الهِدَايَةِ وَكَشْفِ الحَقَائِقِ، مَعَ حَذْفِ أَدَاةِ التَّشْبِيهِ تَوْكِيداً.',
        explanationEn: 'KNOWLEDGE IS LIGHT conceptual metaphor: understanding maps onto visual clarity, ignorance maps onto darkness.',
        explanationDe: 'Kognitive Übertragung: Die Quell-Domäne (Licht) strukturiert die Ziel-Domäne (Erkenntnis).',
        conceptualMapping: 'Source: [Light/Radiation] ➔ Target: [Intellectual Discernment]',
        salientKeywordsAr: ['العِلْمُ', 'نُورٌ', 'ظُلُمَاتِ', 'الجَهْلِ'],
        salientKeywordsEn: ['Knowledge', 'beacon', 'gloom', 'ignorance'],
        salientKeywordsDe: ['Wissen', 'Licht', 'Dunkel', 'Unwissenheit'],
      ),
      // 2. الطباق والمقابلة: الليل والنهار / Nacht und Tag / Night and Day
      const RhetoricalExample(
        id: 'chi_01',
        domain: RhetoricalDomain.chiasmusAntithesis,
        deviceNameAr: 'الطِّبَاقُ وَالمُقَابَلَةُ وَالتَّوْزِيعُ التَّصَالُبِيُّ',
        deviceNameEn: 'Antithesis & Chiasmus Structure',
        deviceNameDe: 'Antithese & Chiasmus (Überkreuzstellung)',
        textAr: 'يَجْمَعُونَ بِاللَّيْلِ حِكْمَةً وَيَنْثُرُونَ فِي النَّهَارِ بَيَاناً.',
        textEn: 'In the night they gather quiet wisdom, and by day they scatter eloquent truth.',
        textDe: 'In der Nacht sammeln sie weise Stille, am Tag verbreiten sie beredte Klarheit.',
        explanationAr: 'مُقَابَلَةٌ بَدِيعِيَّةٌ بَيْنَ (يَجْمَعُونَ/اللَّيْلِ) وَ(يَنْثُرُونَ/النَّهَارِ) تُظْهِرُ تَوَازُنَ الجَمْعِ وَالعَطَاءِ.',
        explanationEn: 'Syntactic and semantic antithesis contrasting diurnal revelation and nocturnal contemplation.',
        explanationDe: 'Rhetorischer Parallelismus und inhaltlicher Gegensatz zur Verstärkung des gedanklichen Rhythmus.',
        conceptualMapping: 'Contrast Matrix: [Night/Gathering] vs. [Day/Dissemination]',
        salientKeywordsAr: ['يَجْمَعُونَ', 'اللَّيْلِ', 'يَنْثُرُونَ', 'النَّهَارِ'],
        salientKeywordsEn: ['night', 'gather', 'day', 'scatter'],
        salientKeywordsDe: ['Nacht', 'sammeln', 'Tag', 'verbreiten'],
      ),
      // 3. الجناس والسجع: حزم وعزم / Alliteration & Assonance
      const RhetoricalExample(
        id: 'par_01',
        domain: RhetoricalDomain.paronomasiaAssonance,
        deviceNameAr: 'الجِنَاسُ النَّاقِصُ وَالسَّجْعُ الصَّوْتِيُّ',
        deviceNameEn: 'Paronomasia, Alliteration & Phonetic Resonance',
        deviceNameDe: 'Paronomasie, Alliteration & Klangfiguren',
        textAr: 'مَنْ تَحَلَّى بِالحَزْمِ بَلَغَ غَايَةَ العَزْمِ، وَأَدْرَكَ نَيْلَ الفَوْزِ وَالفَهْمِ.',
        textEn: 'Firm fortitude forges focused resolution and deep comprehension.',
        textDe: 'Kluge Klarheit krönt kühne Entschlossenheit.',
        explanationAr: 'جِنَاسٌ نَاقِصٌ بَيْنَ (الحَزْمِ) وَ(العَزْمِ)، مَعَ سَجْعٍ مُرَصَّعٍ يُضْفِي جَرَسَاً مُوسِيقِيّاً آسِراً.',
        explanationEn: 'Phonological symmetry through alliterative velar plosives and assonant metric rhyme.',
        explanationDe: 'Stilistische Alliteration zur Festigung moralischer Merkverse durch rhythmischen Wohlklang.',
        conceptualMapping: 'Phonetic Harmony: Consonance [ح-ز-م / ع-ز-م] ➔ Cognitive Memorability',
        salientKeywordsAr: ['الحَزْمِ', 'العَزْمِ', 'الفَوْزِ', 'الفَهْمِ'],
        salientKeywordsEn: ['Firm', 'fortitude', 'forges', 'focused'],
        salientKeywordsDe: ['Kluge', 'Klarheit', 'krönt', 'kühne'],
      ),
      // 4. الكناية والتهوين: كثير الرماد / Metonymy & Litotes
      const RhetoricalExample(
        id: 'meto_01',
        domain: RhetoricalDomain.metonymyLitotes,
        deviceNameAr: 'الكِنَايَةُ عَنْ صِفَةٍ (الجُودُ وَالسَّخَاءُ)',
        deviceNameEn: 'Metonymy, Synecdoche & Litotes',
        deviceNameDe: 'Metonymie & Litotes (Doppelte Verneinung)',
        textAr: 'فُلاَنٌ كَثِيرُ الرَّمَادِ إِذَا مَا الشِّتَاءُ أَطَلَّ.',
        textEn: 'He is not unfamiliar with setting a welcoming hearth for the weary traveler.',
        textDe: 'Er geizt keineswegs mit herzlicher Gastfreundschaft in kalter Stunde.',
        explanationAr: 'كِنَايَةٌ عَنْ صِفَةِ الكَرَمِ وَالجُودِ؛ لِأَنَّ كَثْرَةَ الرَّمَادِ تَدُلُّ عَلَى كَثْرَةِ إِيقَادِ النَّارِ لِلطَّبْخِ لِلضُّيُوفِ.',
        explanationEn: 'Arabic cultural metonymy for abundant generosity paired with English understatement (litotes).',
        explanationDe: 'Metonymische Verknüpfung (Ursache/Wirkung) kombiniert mit stilistischer Untertreibung.',
        conceptualMapping: 'Indexical Association: [Copious Hearth Ash] ➔ [Boundless Generosity]',
        salientKeywordsAr: ['كَثِيرُ', 'الرَّمَادِ', 'الشِّتَاءُ'],
        salientKeywordsEn: ['not unfamiliar', 'welcoming hearth', 'weary traveler'],
        salientKeywordsDe: ['geizt keineswegs', 'Gastfreundschaft', 'kalter Stunde'],
      ),
    ];

    _state = _state.copyWith(
      examples: defaultExamples,
      selectedExampleId: defaultExamples.first.id,
    );
  }

  void selectDomain(RhetoricalDomain domain) {
    final filtered = _state.examples.where((e) => e.domain == domain).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedExampleId;
    _state = _state.copyWith(
      selectedDomain: domain,
      selectedExampleId: nextId,
    );
    notifyListeners();
  }

  void selectExample(String id) {
    _state = _state.copyWith(selectedExampleId: id);
    notifyListeners();
  }

  void toggleDeconstruction() {
    _state = _state.copyWith(showDeconstruction: !_state.showDeconstruction);
    notifyListeners();
  }

  void toggleTrilingualComparison() {
    _state = _state.copyWith(showTrilingualComparison: !_state.showTrilingualComparison);
    notifyListeners();
  }

  void adjustStylisticImpact(double impact) {
    _state = _state.copyWith(stylisticImpactScore: impact.clamp(0.0, 1.0));
    notifyListeners();
  }
}
