import 'package:flutter/foundation.dart';

enum ExclamativeCategory {
  standardExclamationMaAfala, // التعجب القياسي بصيغة (ما أفعل) و(أفعل به)
  evaluativePraiseBlame,      // أسلوب المدح والذم (نعم وبئس وحبذا)
  emphaticCorroboration,      // التوكيد المعنوي والقسمي (نفس، عين، كل، إنَّ، اللام)
  frontedInversionExclaim     // التقديم الانفعالي والتعجب بالسؤال البلاغي (How / What / Wie / Was für)
}

class ExclamativeScenario {
  final String id;
  final ExclamativeCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String neutralBaseAr; // الصيغة الخبرية الحيادية قبل التعجب والتوكيد
  final String exclamativeAr; // الصيغة الإنشائية التعجبية أو التوكيدية مشكولة شكلاً تاماً
  final String exclamativeEn;
  final String exclamativeDe;
  final String structuralFormulaAr;
  final String structuralFormulaEn;
  final String structuralFormulaDe;
  final String grammaticalNotesAr;
  final double expressiveIntensityScore; // 0.0 إلى 1.0

  const ExclamativeScenario({
    required this.id,
    required this.category,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.neutralBaseAr,
    required this.exclamativeAr,
    required this.exclamativeEn,
    required this.exclamativeDe,
    required this.structuralFormulaAr,
    required this.structuralFormulaEn,
    required this.structuralFormulaDe,
    required this.grammaticalNotesAr,
    required this.expressiveIntensityScore,
  });
}

class ExclamativeEmphasisState {
  final ExclamativeCategory selectedCategory;
  final List<ExclamativeScenario> scenarios;
  final String selectedScenarioId;
  final bool showNeutralComparison;
  final bool showStructuralFormula;

  const ExclamativeEmphasisState({
    this.selectedCategory = ExclamativeCategory.standardExclamationMaAfala,
    this.scenarios = const [],
    this.selectedScenarioId = 'exc_ma_01',
    this.showNeutralComparison = true,
    this.showStructuralFormula = true,
  });

  ExclamativeScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  ExclamativeEmphasisState copyWith({
    ExclamativeCategory? selectedCategory,
    List<ExclamativeScenario>? scenarios,
    String? selectedScenarioId,
    bool? showNeutralComparison,
    bool? showStructuralFormula,
  }) {
    return ExclamativeEmphasisState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showNeutralComparison: showNeutralComparison ?? this.showNeutralComparison,
      showStructuralFormula: showStructuralFormula ?? this.showStructuralFormula,
    );
  }
}

class ExclamativeEmphasisController extends ChangeNotifier {
  ExclamativeEmphasisState _state = const ExclamativeEmphasisState();
  ExclamativeEmphasisState get state => _state;

  ExclamativeEmphasisController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. التعجب القياسي: ما أفعله / أفعل به
      const ExclamativeScenario(
        id: 'exc_ma_01',
        category: ExclamativeCategory.standardExclamationMaAfala,
        titleAr: 'التَّعَجُّبُ القِيَاسِيُّ بِصِيغَتَيْ (مَا أَفْعَلَهُ!) وَ(أَفْعِلْ بِهِ!)',
        titleEn: 'Standard Exclamative: "How + Adj!" & "What a + Noun!"',
        titleDe: 'Ausrufesatz (Exklamativsatz): "Wie + Adjektiv!" & "Welch ein...!"',
        neutralBaseAr: 'صُنْعُ اللَّهِ فِي الكَوْنِ بَدِيعٌ وَمُتْقَنٌ.',
        exclamativeAr: 'مَا أَبْدَعَ صُنْعَ اللَّهِ فِي الكَوْنِ، وَأَعْظِمْ بِحِكْمَتِهِ البَالِغَةِ!',
        exclamativeEn: 'How exquisite is God’s handiwork in the cosmos, and what profound wisdom it manifests!',
        exclamativeDe: 'Wie wunderbar ist doch Gottes Schöpfung im Kosmos, und welch tiefe Weisheit offenbart sie!',
        structuralFormulaAr: 'مَا التَّعَجُّبِيَّةُ (مُبْتَدَأٌ) + فِعْلُ التَّعَجُّبِ المَاضِي (أَبْدَعَ) + المُتَعَجَّبُ مِنْهُ مَنْصُوباً (صُنْعَ).',
        structuralFormulaEn: 'How + Adjective + Copula + Subject! / What + (a/an) + Adjective + Noun Phrase!',
        structuralFormulaDe: 'Wie + Adjektiv + finites Verb + (Modalpartikel "doch") + Subjekt! (V2 oder Verb-Letzt).',
        grammaticalNotesAr: 'يُشْتَرَطُ فِي فِعْلِ التَّعَجُّبِ المُبَاشِرِ أَنْ يَكُونَ ثُلَاثِيّاً تَامّاً مُتَصَرِّفاً مُثْبَتاً مَبْنِيّاً لِلْمَعْلُومِ قَابِلاً لِلتَّفَاوُتِ.',
        expressiveIntensityScore: 0.98,
      ),

      // 2. أسلوب المدح والذم: نعم وبئس
      const ExclamativeScenario(
        id: 'exc_eval_01',
        category: ExclamativeCategory.evaluativePraiseBlame,
        titleAr: 'أُسْلُوبُ المَدْحِ وَالذَّمِّ البَلَاغِيِّ (نِعْمَ / بِئْسَ / حَبَّذَا)',
        titleEn: 'Evaluative Predication: Praise & Censure Constructions',
        titleDe: 'Wertende Prädikation: Lob und Tadel im gehobenen Stil',
        neutralBaseAr: 'الأَمَانَةُ وَالصِّدْقُ مِنَ الأَخْلَاقِ الحَسَنَةِ.',
        exclamativeAr: 'نِعْمَ الخُلُقُ الأَمَانَةُ، وَبِئْسَ الصِّفَةُ الخِيَانَةُ وَالغَدْرُ!',
        exclamativeEn: 'What an exemplary virtue trustworthiness truly is, and how despicable is treachery!',
        exclamativeDe: 'Welch edle Tugend ist doch die Vertrauenswürdigkeit, und wie verwerflich ist der Verrat!',
        structuralFormulaAr: 'فِعْلُ مَدْحٍ جَامِدٌ (نِعْمَ) + فَاعِلٌ مُعَرَّفٌ بِـ(أَلْ) + المَخْصُوصُ بِالمَدْحِ (مُبْتَدَأٌ مُؤَخَّرٌ مَرْفُوعٌ).',
        structuralFormulaEn: 'Evaluative NP inversion ("What an exemplary virtue X truly is!") to foreground moral judgment.',
        structuralFormulaDe: 'Substantivische Hervorhebung ("Welch edle Tugend...") gepaart mit emotionaler Bewertungsintonation.',
        grammaticalNotesAr: 'المَخْصُوصُ بِالمَدْحِ أَوِ الذَّمِّ يَجُوزُ إِعْرَابُهُ مُبْتَدَأً مُؤَخَّراً خَبَرُهُ الجُمْلَةُ الفِعْلِيَّةُ قَبْلَهُ، أَوْ خَبَراً لِمُبْتَدَأٍ مَحْذُوفٍ.',
        expressiveIntensityScore: 0.95,
      ),

      // 3. التوكيد المعنوي والقسمي
      const ExclamativeScenario(
        id: 'exc_emph_01',
        category: ExclamativeCategory.emphaticCorroboration,
        titleAr: 'التَّوْكِيدُ المَعْنَوِيُّ (كُلٌّ/عَيْنٌ) وَالتَّوْكِيدُ بِالقَسَمِ وَالنُّونِ',
        titleEn: 'Emphatic Corroboration & Reflexive/Auxiliary Intensification',
        titleDe: 'Nachdrückliche Bekräftigung: Reflexive & Syntaktische Emphase',
        neutralBaseAr: 'حَضَرَ العُلَمَاءُ وَأَنَا أَنْصُرُ الحَقَّ.',
        exclamativeAr: 'وَاللَّهِ لَقَدْ حَضَرَ العُلَمَاءُ جَمِيعُهُمْ أَنْفُسُهُمْ، وَلَأَنْصُرَنَّ الحَقَّ المُبِينَ!',
        exclamativeEn: 'By God, the scholars themselves did indeed all attend, and I shall most certainly uphold the manifest truth!',
        exclamativeDe: 'Wahrlich, die Gelehrten selbst sind ausnahmslos allesamt erschienen, und ich werde gewiss für die Wahrheit einstehen!',
        structuralFormulaAr: 'أُسْلُوبُ القَسَمِ + لَامُ التَّوْكِيدِ + نُونُ التَّوْكِيدِ الثَّقِيلَةُ (لَأَنْصُرَنَّ) + التَّوْكِيدُ المَعْنَوِيُّ (جَمِيعُهُمْ).',
        structuralFormulaEn: 'Emphatic "do/did" auxiliary + intensive reflexive ("themselves") + epistemic adverbial ("most certainly").',
        structuralFormulaDe: 'Verstärkende Pronomina ("selbst", "allesamt") und Modaladverbien ("wahrlich", "gewiss").',
        grammaticalNotesAr: 'التَّوْكِيدُ المَعْنَوِيُّ يَتْبَعُ المُؤَكَّدَ فِي إِعْرَابِهِ، وَيَشْتَرِطُ اتِّصَالَهُ بِضَمِيرٍ يَعُودُ عَلَى المُؤَكَّدِ وَيُطَابِقُهُ.',
        expressiveIntensityScore: 0.97,
      ),

      // 4. التقديم الانفعالي والتعجب بالسؤال البلاغي
      const ExclamativeScenario(
        id: 'exc_front_01',
        category: ExclamativeCategory.frontedInversionExclaim,
        titleAr: 'التَّقْدِيمُ الانْفِعَالِيُّ وَالاسْتِفْهَامُ التَّعَجُّبِيُّ البَلَاغِيُّ',
        titleEn: 'Fronted Adjectival Inversion & Rhetorical Exclamative',
        titleDe: 'Emphatische Vorfeldbesetzung & Rhetorischer Ausruf',
        neutralBaseAr: 'كَانَتِ الحِكْمَةُ عَمِيقَةً لِدَرَجَةِ أَنَّهَا أَذْهَلَتِ الحَاضِرِينَ.',
        exclamativeAr: 'لِلَّهِ دَرُّ هَذِهِ الحِكْمَةِ السَّامِيَةِ؛ أَيُّ نُورٍ أَشْرَقَ فِي العُقُولِ!',
        exclamativeEn: 'So profound was this noble wisdom that it illuminated every intellect present!',
        exclamativeDe: 'So tiefgründig war diese erhabene Weisheit, dass sie alle Anwesenden erleuchtete!',
        structuralFormulaAr: 'تَعَجُّبٌ سَمَاعِيٌّ (لِلَّهِ دَرُّهُ!) + كَمْ/أَيُّ التَّعَجُّبِيَّةُ (أَيُّ نُورٍ!).',
        structuralFormulaEn: 'So + Adjective + Auxiliary + Subject + that... (Subject-Auxiliary Inversion for stylistic emphasis).',
        structuralFormulaDe: 'So + Adjektiv + finites Verb (V2) + Subjekt + Konsekutivsatz ("dass...").',
        grammaticalNotesAr: 'التَّعَجُّبُ السَّمَاعِيُّ مِثْلُ (لِلَّهِ دَرُّهُ) وَ(سُبْحَانَ اللَّهِ!) يُحْفَظُ وَلَا يُقَاسُ عَلَيْهِ، وَيُفِيدُ تَعْظِيمَ النِّعْمَةِ وَالإِتْقَانِ.',
        expressiveIntensityScore: 0.94,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectCategory(ExclamativeCategory category) {
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

  void toggleNeutralComparison() {
    _state = _state.copyWith(showNeutralComparison: !_state.showNeutralComparison);
    notifyListeners();
  }

  void toggleStructuralFormula() {
    _state = _state.copyWith(showStructuralFormula: !_state.showStructuralFormula);
    notifyListeners();
  }
}
