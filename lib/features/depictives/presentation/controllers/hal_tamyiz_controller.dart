import 'package:flutter/foundation.dart';

enum DepictiveCategory {
  singularDepictiveHal,  // الحال المفردة المشتقة (Depictive Adjective / Partizip I)
  clausalHalWithWaw,     // الحال الجملة مع واو الحال والرابط (Clausal Hal / Während-Satz)
  specificationTamyiz,   // التمييز المحول عن الفاعل أو المفعول (Tamyiz of Proportion / Spezifikation)
  halVsNatDistinction    // الفرق الجوهري بين النعت والحال (المعرفة vs النكرة)
}

class DepictiveScenario {
  final String id;
  final DepictiveCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String salientTargetAr; // الكلمة أو الجملة المحللة مشكولة
  final String sentenceAr; // الجملة العربية الكاملة مشكولة شكلاً تاماً
  final String sentenceEn;
  final String sentenceDe;
  final String grammaticalDiagnosisAr;
  final String grammaticalDiagnosisEn;
  final String grammaticalDiagnosisDe;
  final String keyContrastRule;
  final double syntacticPrecisionScore; // 0.0 إلى 1.0

  const DepictiveScenario({
    required this.id,
    required this.category,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.salientTargetAr,
    required this.sentenceAr,
    required this.sentenceEn,
    required this.sentenceDe,
    required this.grammaticalDiagnosisAr,
    required this.grammaticalDiagnosisEn,
    required this.grammaticalDiagnosisDe,
    required this.keyContrastRule,
    required this.syntacticPrecisionScore,
  });
}

class HalTamyizState {
  final DepictiveCategory selectedCategory;
  final List<DepictiveScenario> scenarios;
  final String selectedScenarioId;
  final bool showContrastRule;
  final bool showDetailedDiagnosis;

  const HalTamyizState({
    this.selectedCategory = DepictiveCategory.singularDepictiveHal,
    this.scenarios = const [],
    this.selectedScenarioId = 'dep_hal_01',
    this.showContrastRule = true,
    this.showDetailedDiagnosis = true,
  });

  DepictiveScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  HalTamyizState copyWith({
    DepictiveCategory? selectedCategory,
    List<DepictiveScenario>? scenarios,
    String? selectedScenarioId,
    bool? showContrastRule,
    bool? showDetailedDiagnosis,
  }) {
    return HalTamyizState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showContrastRule: showContrastRule ?? this.showContrastRule,
      showDetailedDiagnosis: showDetailedDiagnosis ?? this.showDetailedDiagnosis,
    );
  }
}

class HalTamyizController extends ChangeNotifier {
  HalTamyizState _state = const HalTamyizState();
  HalTamyizState get state => _state;

  HalTamyizController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. الحال المفردة المشتقة (Depictive Secondary Predication)
      const DepictiveScenario(
        id: 'dep_hal_01',
        category: DepictiveCategory.singularDepictiveHal,
        titleAr: 'الحَالُ المُفْرَدَةُ المُشْتَقَّةُ: تَصْوِيرُ هَيْئَةِ الفَاعِلِ وَقْتَ الحَدَثِ',
        titleEn: 'Depictive Secondary Predicates: Subject State During Action',
        titleDe: 'Depiktive Prädikativa & Partizip I im Satzfeld ("lächelnd")',
        salientTargetAr: 'مُبْتَسِماً / مُسْتَبْشِراً',
        sentenceAr: 'عَادَ العَالِمُ مِنْ رِحْلَتِهِ مُبْتَسِماً مُسْتَبْشِراً بِفَضْلِ اللَّهِ.',
        sentenceEn: 'The scholar returned from his journey smiling, rejoicing in God’s grace.',
        sentenceDe: 'Der Gelehrte kehrte von seiner Reise lächelnd und voller Freude zurück.',
        grammaticalDiagnosisAr: '(مُبْتَسِماً): حَالٌ مُفْرَدَةٌ مَنْصُوبَةٌ تُجِيبُ عَنْ سُؤَالِ (كَيْفَ عَادَ؟)، وَصَاحِبُهَا مَعْرِفَةٌ (العَالِمُ).',
        grammaticalDiagnosisEn: 'English uses uninflected present participles ("smiling") or adjectives as depictive predicates distinct from manner adverbs.',
        grammaticalDiagnosisDe: 'Im Deutschen bleibt das prädikative Partizip I ("lächelnd") endungslos, im Gegensatz zum flektierten Attribut ("der lächelnde Gelehrte").',
        keyContrastRule: 'الفرق الدقيق: الحال يصف هيئة الفاعل لحظة الفعل (كَيْفَ؟)، ولا يلازمه دائماً كالنعت الثابت.',
        syntacticPrecisionScore: 0.96,
      ),

      // 2. الحال الجملة مع واو الحال والضمير الرابط
      const DepictiveScenario(
        id: 'dep_claus_01',
        category: DepictiveCategory.clausalHalWithWaw,
        titleAr: 'جُمْلَةُ الحَالِ المَقْرُونَةُ بِوَاوِ الحَالِ وَالضَّمِيرِ الرَّابِطِ',
        titleEn: 'Clausal Depictives & Simultaneous Circumstantial Clauses',
        titleDe: 'Modale Gleichzeitigkeitssätze mit "während / indem"',
        salientTargetAr: 'وَقَلْبُهُ خَاشِعٌ',
        sentenceAr: 'دَخَلَ المُصَلِّي المَسْجِدَ وَقَلْبُهُ خَاشِعٌ لِذِكْرِ اللَّهِ.',
        sentenceEn: 'The worshipper entered the mosque while his heart was humble in remembrance of God.',
        sentenceDe: 'Der Betende betrat die Moschee, während sein Herz in Gottesgedenken ehrfürchtig war.',
        grammaticalDiagnosisAr: '(وَقَلْبُهُ خَاشِعٌ): جُمْلَةٌ اسْمِيَّةٌ فِي مَحَلِّ نَصْبِ حَالٍ، ارْتَبَطَتْ بِصَاحِبِ الحَالِ بِوَاوِ الحَالِ وَالضَّمِيرِ (الهَاءِ).',
        grammaticalDiagnosisEn: 'Circumstantial simultaneous subordinator ("while / with his heart humble") captures synchronous background state.',
        grammaticalDiagnosisDe: 'Die Konjunktion "während" (oder "wobei") leitet einen Nebensatz der Gleichzeitigkeit mit Endstellung des Verbs ein.',
        keyContrastRule: 'القاعدة الذهبية: الجُمْلَةُ الاسْمِيَّةُ الوَاقِعَةُ حَالاً تَحْتَاجُ غَالِباً إِلَى وَاوِ الحَالِ أَوْ الضَّمِيرِ، وَتَجْتَمِعَانِ هُنَا لِقُوَّةِ الرَّبْطِ.',
        syntacticPrecisionScore: 0.98,
      ),

      // 3. التمييز المحول (تمييز النسبة)
      const DepictiveScenario(
        id: 'dep_tam_01',
        category: DepictiveCategory.specificationTamyiz,
        titleAr: 'تَمْيِيزُ النِّسْبَةِ المُحَوَّلُ عَنِ الفَاعِلِ أَوِ المَفْعُولِ',
        titleEn: 'Accusative of Specification (Tamyiz): "Pure in Soul / Rich in Knowledge"',
        titleDe: 'Akkusativ / Präpositionalangabe der Spezifikation ("an Wissen", "im Herzen")',
        salientTargetAr: 'نَفْساً / يَقِيناً',
        sentenceAr: 'طَابَ المُؤْمِنُ نَفْساً وَازْدَادَ عِلْماً وَيَقِيناً بِالقُرْآنِ الكَرِيمِ.',
        sentenceEn: 'The believer became serene in soul and increased in knowledge and certainty.',
        sentenceDe: 'Der Gläubige wurde rein im Herzen und wuchs an Wissen sowie an Gewissheit.',
        grammaticalDiagnosisAr: '(نَفْساً) وَ(عِلْماً): تَمْيِيزُ نِسْبَةٍ مَنْصُوبٌ؛ يَرْفَعُ الإِبْهَامَ عَنْ جُمْلَةِ (طَابَ المُؤْمِنُ)، وَأَصْلُهُ (طَابَتْ نَفْسُ المُؤْمِنِ).',
        grammaticalDiagnosisEn: 'English expresses Arabic Tamyiz via prepositional specification ("in soul", "in knowledge", "with respect to").',
        grammaticalDiagnosisDe: 'Das Deutsche nutzt präpositionale Eingrenzungen mit "an + Dativ" ("reich an Wissen") oder "in + Dativ".',
        keyContrastRule: 'الفرق الحاسم بين الحال والتمييز: الحال مُشْتَقٌّ (مبتسماً) يدل على الهيئة، والتمييز جَامِدٌ (نفساً/علماً) يبين جهة النسبة (بمعنى مِنْ حَيْثُ).',
        syntacticPrecisionScore: 0.97,
      ),

      // 4. الفرق البنيوي الحاسم بين النعت والحال (الجمل بعد النكرات vs بعد المعارف)
      const DepictiveScenario(
        id: 'dep_nat_01',
        category: DepictiveCategory.halVsNatDistinction,
        titleAr: 'مِعْيَارُ التَّفْرِيقِ بَيْنَ النَّعْتِ وَالحَالِ (النَّكِرَةُ مُقَابِلَ المَعْرِفَةِ)',
        titleEn: 'Attributive Modifier vs. Depictive Predicate: Definiteness Trigger',
        titleDe: 'Attributivsatz vs. Modale Beschreibung: Die Bestimmtheitsregel',
        salientTargetAr: 'يَحْمِلُ مِصْبَاحاً (نعت) مقابل يَحْمِلُ مِصْبَاحاً (حال)',
        sentenceAr: 'رَأَيْتُ دَاعِياً يَحْمِلُ مِصْبَاحاً (نَعْتٌ لِنَكِرَةٍ) — مُقَابِلَ: رَأَيْتُ الدَّاعِيَ يَحْمِلُ مِصْبَاحاً (حَالٌ لِمَعْرِفَةٍ).',
        sentenceEn: 'I saw a caller carrying a lantern (Attributive) vs. I saw the caller as he carried a lantern (Depictive).',
        sentenceDe: 'Ich sah einen Rufer, der eine Laterne trug (Attribut) vs. Ich sah den Rufer, wie er eine Laterne trug (Prädikativ).',
        grammaticalDiagnosisAr: 'الجُمْلَةُ بَعْدَ النَّكِرَةِ (دَاعِياً) تَقَعُ نَعْتاً تَابِعاً فِي الإِعْرَابِ، وَبَعْدَ المَعْرِفَةِ (الدَّاعِيَ) تَقَعُ حَالاً مَنْصُوباً دَائِماً.',
        grammaticalDiagnosisEn: 'Definiteness of the antecedent governs secondary predication interpretation across discourse.',
        grammaticalDiagnosisDe: 'Im Deutschen unterscheidet die Syntax zwischen Relativsatz ("der... trug") und modalem Wie-Satz ("wie er... trug").',
        keyContrastRule: 'القاعدة البلاغية الجامعة: الجُمَلُ بَعْدَ النَّكِرَاتِ صِفَاتٌ، وَبَعْدَ المَعَارِفِ أَحْوَالٌ.',
        syntacticPrecisionScore: 0.99,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectCategory(DepictiveCategory category) {
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

  void toggleContrastRule() {
    _state = _state.copyWith(showContrastRule: !_state.showContrastRule);
    notifyListeners();
  }

  void toggleDetailedDiagnosis() {
    _state = _state.copyWith(showDetailedDiagnosis: !_state.showDetailedDiagnosis);
    notifyListeners();
  }
}
