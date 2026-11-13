import 'package:flutter/foundation.dart';

enum ConditionalCategory {
  realisPredictive,       // الشرط المحقق والوقوع الراجح (إِنْ / إِذَا - Realis / First Conditional)
  counterfactualPast,     // الشرط الامتناعي في الماضي (لَوْ - Irrealis Vergangenheit / Third Conditional)
  presenceExclusion,      // الامتناع لوجود الغير (لَوْلَا - Counterfactual Existence / Were it not for)
  invertedSubjunctive     // التقديم الشرطي البلاغي بدون أداة (Verb-First Conditional / Had we / Wäre...)
}

class ConditionalScenario {
  final String id;
  final ConditionalCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String protasisAr; // جملة الشرط مشكولة
  final String apodosisAr; // جملة جواب الشرط مشكولة
  final String fullSentenceAr;
  final String fullSentenceEn;
  final String fullSentenceDe;
  final String operatorAnalysisAr;
  final String operatorAnalysisEn;
  final String operatorAnalysisDe;
  final String moodMechanicsAr;
  final String moodMechanicsEn;
  final String moodMechanicsDe;
  final double epistemicLikelihood; // 0.0 (امتناع تام) إلى 1.0 (تحقق قطعي)

  const ConditionalScenario({
    required this.id,
    required this.category,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.protasisAr,
    required this.apodosisAr,
    required this.fullSentenceAr,
    required this.fullSentenceEn,
    required this.fullSentenceDe,
    required this.operatorAnalysisAr,
    required this.operatorAnalysisEn,
    required this.operatorAnalysisDe,
    required this.moodMechanicsAr,
    required this.moodMechanicsEn,
    required this.moodMechanicsDe,
    required this.epistemicLikelihood,
  });
}

class ConditionalMoodState {
  final ConditionalCategory selectedCategory;
  final List<ConditionalScenario> scenarios;
  final String selectedScenarioId;
  final bool showProtasisApodosisSplit;
  final bool showMoodMechanics;

  const ConditionalMoodState({
    this.selectedCategory = ConditionalCategory.realisPredictive,
    this.scenarios = const [],
    this.selectedScenarioId = 'cond_real_01',
    this.showProtasisApodosisSplit = true,
    this.showMoodMechanics = true,
  });

  ConditionalScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  ConditionalMoodState copyWith({
    ConditionalCategory? selectedCategory,
    List<ConditionalScenario>? scenarios,
    String? selectedScenarioId,
    bool? showProtasisApodosisSplit,
    bool? showMoodMechanics,
  }) {
    return ConditionalMoodState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showProtasisApodosisSplit: showProtasisApodosisSplit ?? this.showProtasisApodosisSplit,
      showMoodMechanics: showMoodMechanics ?? this.showMoodMechanics,
    );
  }
}

class ConditionalMoodController extends ChangeNotifier {
  ConditionalMoodState _state = const ConditionalMoodState();
  ConditionalMoodState get state => _state;

  ConditionalMoodController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. الشرط المحقق والوقوع الراجح: إِنْ / إِذَا + فاء الجزاء
      const ConditionalScenario(
        id: 'cond_real_01',
        category: ConditionalCategory.realisPredictive,
        titleAr: 'الشَّرْطُ الجَازِمُ وَاقْتِرَانُ الجَوَابِ بِفَاءِ الجَزَاءِ',
        titleEn: 'Realis Predictive Conditional & Apodosis Binding',
        titleDe: 'Realer Konditionalsatz mit Indikativ und Kausalbindung',
        protasisAr: 'إِنْ تَجْتَهِدْ فِي طَلَبِ العِلْمِ وَتُخْلِصِ النِّيَّةَ',
        apodosisAr: 'فَإِنَّ اللَّهَ مُيَسِّرٌ لَكَ سُبُلَ التَّوْفِيقِ وَالهِدَايَةِ.',
        fullSentenceAr: 'إِنْ تَجْتَهِدْ فِي طَلَبِ العِلْمِ وَتُخْلِصِ النِّيَّةَ، فَإِنَّ اللَّهَ مُيَسِّرٌ لَكَ سُبُلَ التَّوْفِيقِ وَالهِدَايَةِ.',
        fullSentenceEn: 'If you strive diligently in seeking knowledge with sincere intention, then God will surely facilitate for you the paths of success.',
        fullSentenceDe: 'Wenn du dich aufrichtig und fleißig um Wissen bemühst, so wird dir der Weg zum Gelingen geebnet.',
        operatorAnalysisAr: 'إِنْ (حَرْفُ شَرْطٍ جَازِمٌ لِفِعْلَيْنِ) + الفَاءُ الرَّابِطَةُ لِجَوَابِ الشَّرْطِ (جُمْلَةٌ اسْمِيَّةٌ مُؤَكَّدَةٌ بِإِنَّ).',
        operatorAnalysisEn: 'Open predictive "if" (present simple) paired with future assurance ("will facilitate").',
        operatorAnalysisDe: 'Konditionale Subjunktion "wenn" im Indikativ Präsens mit Nebensatz-Endstellung des Verbs.',
        moodMechanicsAr: 'جَزْمُ فِعْلِ الشَّرْطِ (تَجْتَهِدْ) بِالسُّكُونِ، وَوُجُوبُ اقْتِرَانِ الجَوَابِ بِالفَاءِ لِكَوْنِهِ جُمْلَةً اسْمِيَّةً.',
        moodMechanicsEn: 'Realis mood expresses an achievable causal contingency without counterfactual distance.',
        moodMechanicsDe: 'Im realen Konditionalsatz steht der Indikativ; das konjugierte Verb wandert im Nebensatz ans Ende.',
        epistemicLikelihood: 0.90,
      ),

      // 2. الشرط الامتناعي في الماضي: لَوْ (حرف امتناع لامتناع) + Konjunktiv II
      const ConditionalScenario(
        id: 'cond_past_01',
        category: ConditionalCategory.counterfactualPast,
        titleAr: 'الامْتِنَاعُ لِامْتِنَاعٍ فِي الزَّمَنِ المَاضِي (لَوْ / Konjunktiv II)',
        titleEn: 'Past Counterfactual: Irrealis Regret & Retrospective Logic',
        titleDe: 'Irrealis der Vergangenheit: Konjunktiv II Plusquamperfekt',
        protasisAr: 'لَوْ تَأَنَّى المُتَعَجِّلُ فِي حُكْمِهِ قَبْلَ البَتِّ فِيهِ',
        apodosisAr: 'لَسَلِمَ مِنْ زَلَّةِ النَّدَمِ وَلَأَصَابَ وَجْهَ الصَّوَابِ.',
        fullSentenceAr: 'لَوْ تَأَنَّى المُتَعَجِّلُ فِي حُكْمِهِ قَبْلَ البَتِّ فِيهِ، لَسَلِمَ مِنْ زَلَّةِ النَّدَمِ وَلَأَصَابَ وَجْهَ الصَّوَابِ.',
        fullSentenceEn: 'Had the hasty judge deliberated before deciding, he would have been spared the slip of regret.',
        fullSentenceDe: 'Hätte der Übereilte vor seinem Urteil innegehalten, so wäre ihm die Reue erspart geblieben.',
        operatorAnalysisAr: 'لَوْ (حَرْفُ امْتِنَاعٍ لِامْتِنَاعٍ غَيْرُ جَازِمٍ) + اللَّامُ الوَاقِعَةُ فِي جَوَابِ لَوْ لِلتَّوْكِيدِ.',
        operatorAnalysisEn: 'Past perfect counterfactual ("had deliberated") + modal perfect ("would have been spared").',
        operatorAnalysisDe: 'Konjunktiv II der Vergangenheit ("hätte innegehalten" ... "wäre erspart geblieben").',
        moodMechanicsAr: 'تُفِيدُ (لَوْ) انْتِفَاءَ الجَوَابِ لِانْتِفَاءِ الشَّرْطِ فِي المَاضِي (لَمْ يَتَأَنَّ فَلَمْ يَسْلَمْ).',
        moodMechanicsEn: 'Counterfactual distance blocks real-world truth value of both protasis and apodosis.',
        moodMechanicsDe: 'Der Konjunktiv II markiert eine abgeschlossene, nicht mehr veränderbare Gegenrealität.',
        epistemicLikelihood: 0.05,
      ),

      // 3. الامتناع لوجود الغير: لَوْلَا + المبتدأ المحذوف خبره وجوباً
      const ConditionalScenario(
        id: 'cond_pres_01',
        category: ConditionalCategory.presenceExclusion,
        titleAr: 'الامْتِنَاعُ لِوُجُودِ الغَيْرِ (لَوْلَا / Were it not for)',
        titleEn: 'Existential Counterfactual: Contingency on Essential Presence',
        titleDe: 'Existentieller Irrealis: Ohne-Konstruktion & "Wäre nicht..."',
        protasisAr: 'لَوْلَا رَحْمَةُ اللَّهِ وَلُطْفُهُ الخَفِيُّ بِالمُؤْمِنِينَ',
        apodosisAr: 'لَضَاقَتْ بِهِمُ السُّبُلُ وَلَغَلَبَهُمُ اليَأْسُ فِي الشَّدَائِدِ.',
        fullSentenceAr: 'لَوْلَا رَحْمَةُ اللَّهِ وَلُطْفُهُ الخَفِيُّ بِالمُؤْمِنِينَ، لَضَاقَتْ بِهِمُ السُّبُلُ وَلَغَلَبَهُمُ اليَأْسُ فِي الشَّدَائِدِ.',
        fullSentenceEn: 'Were it not for God’s mercy and subtle grace, pathways would have narrowed and despair would prevail.',
        fullSentenceDe: 'Wäre nicht Gottes Barmherzigkeit und feine Güte, so hätten sich die Wege verengt.',
        operatorAnalysisAr: 'لَوْلَا (حَرْفُ امْتِنَاعٍ لِوُجُودٍ) يَلِيهِ مُبْتَدَأٌ مَرْفُوعٌ خَبَرُهُ مَحْذُوفٌ وُجُوباً تَقْدِيرُهُ (مَوْجُودَةٌ).',
        operatorAnalysisEn: 'Formal existential counterfactual ("Were it not for + Noun Phrase").',
        operatorAnalysisDe: 'Uneingeleiteter Konjunktiv-II-Satz mit Negation ("Wäre nicht + Nominativ").',
        moodMechanicsAr: 'امْتَنَعَ ضِيقُ السُّبُلِ وَغَلَبَةُ اليَأْسِ بِسَبَبِ وُجُودِ رَحْمَةِ اللَّهِ وَإِحْسَانِهِ.',
        moodMechanicsEn: 'Asserts the real presence of the noun phrase as the sole barrier preventing the catastrophic consequence.',
        moodMechanicsDe: 'Das Vorhandensein des Subjekts verhindert den Eintritt der im Hauptsatz genannten Folge.',
        epistemicLikelihood: 0.10,
      ),

      // 4. التقديم الشرطي البلاغي بدون أداة (الطلب وجوابه / Verb-First Conditional)
      const ConditionalScenario(
        id: 'cond_inv_01',
        category: ConditionalCategory.invertedSubjunctive,
        titleAr: 'الجَزْمُ فِي جَوَابِ الطَّلَبِ وَالتَّقْدِيمِ الشَّرْطِيِّ بِدُونِ أَدَاةٍ',
        titleEn: 'Asyndetic & Inverted Conditionals (Imperative / Verb-First)',
        titleDe: 'Uneingeleiteter Bedingungssatz (Verb-Erst-Stellung)',
        protasisAr: 'اصْدُقِ النَّاسَ المَشُورَةَ وَالنُّصْحَ الخَالِصَ',
        apodosisAr: 'تَنَلْ مَحَبَّتَهُمْ وَتَظْفَرْ بِثِقَتِهِمْ.',
        fullSentenceAr: 'اصْدُقِ النَّاسَ المَشُورَةَ وَالنُّصْحَ الخَالِصَ، تَنَلْ مَحَبَّتَهُمْ وَتَظْفَرْ بِثِقَتِهِمْ.',
        fullSentenceEn: 'Should you counsel people with sincere integrity, you shall earn their affection and enduring trust.',
        fullSentenceDe: 'Berätst du die Menschen aufrichtig, so gewinnst du ihre Zuneigung und ihr Vertrauen.',
        operatorAnalysisAr: 'أُسْلُوبُ الأَمْرِ وَجَوَابُهُ المَجْزُومُ (تَنَلْ) بِشَرْطٍ مُقَدَّرٍ دُونَ ذِكْرِ أَدَاةِ شَرْطٍ لَفْظاً.',
        operatorAnalysisEn: 'Subject-auxiliary inversion ("Should you counsel") omitting "if" for elevated rhetorical elegance.',
        operatorAnalysisDe: 'Wegfall von "wenn/falls" durch Voranstellung des finiten Verbs an Position 1 (V1-Konditionalsatz).',
        moodMechanicsAr: 'جُزِمَ الفِعْلُ (تَنَلْ) لِأَنَّهُ جَوَابُ الطَّلَبِ المَحْضِ، فَأَغْنَى التَّرْكِيبُ عَنْ أَدَاةِ الشَّرْطِ.',
        moodMechanicsEn: 'Asyndetic conditional inversion elevates register in formal ethical and advisory discourse.',
        moodMechanicsDe: 'Die V1-Stellung wirkt prägnanter und literarisch gehobener als ein gewöhnlicher Wenn-Satz.',
        epistemicLikelihood: 0.85,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectCategory(ConditionalCategory category) {
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

  void toggleProtasisApodosisSplit() {
    _state = _state.copyWith(showProtasisApodosisSplit: !_state.showProtasisApodosisSplit);
    notifyListeners();
  }

  void toggleMoodMechanics() {
    _state = _state.copyWith(showMoodMechanics: !_state.showMoodMechanics);
    notifyListeners();
  }
}
