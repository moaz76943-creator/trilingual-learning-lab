import 'package:flutter/foundation.dart';

enum ExceptionTypology {
  completeAffirmative,   // التام المثبت: وجوب نصب المستثنى (Complete Affirmative / außer + Dativ)
  completeNegative,      // التام المنفي: جواز البدل والنصب (Complete Negative / Niemand außer)
  hollowedRestrictive,   // الناقص المفرَّغ: القصر والحصر البلاغي (Hollowed / Nur / Only)
  nominalPrepositional   // الاستثناء بـ (غَيْرُ وَسِوَى) وخَلَا وَعَدَا (Nominal/Verbal Exceptives / außer dass)
}

class ExceptionScenario {
  final String id;
  final ExceptionTypology typology;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String exceptionMarkerAr; // أداة الاستثناء مشكولة
  final String mustathnaMinhuAr; // المستثنى منه
  final String mustathnaAr; // المستثنى مشكولاً بالإعراب الصحيح
  final String fullSentenceAr; // الجملة العربية التامة مشكولة شكلاً تاماً
  final String fullSentenceEn;
  final String fullSentenceDe;
  final String syntacticRuleAr;
  final String syntacticRuleEn;
  final String syntacticRuleDe;
  final String semanticTrapNote; // التحذير من اللبس الدلالي (مثلاً außer vs. neben / except vs. besides)
  final double restrictivePrecisionScore; // 0.0 إلى 1.0

  const ExceptionScenario({
    required this.id,
    required this.typology,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.exceptionMarkerAr,
    required this.mustathnaMinhuAr,
    required this.mustathnaAr,
    required this.fullSentenceAr,
    required this.fullSentenceEn,
    required this.fullSentenceDe,
    required this.syntacticRuleAr,
    required this.syntacticRuleEn,
    required this.syntacticRuleDe,
    required this.semanticTrapNote,
    required this.restrictivePrecisionScore,
  });
}

class ExceptionRestrictionState {
  final ExceptionTypology selectedTypology;
  final List<ExceptionScenario> scenarios;
  final String selectedScenarioId;
  final bool showConstituentSplit;
  final bool showSemanticTraps;

  const ExceptionRestrictionState({
    this.selectedTypology = ExceptionTypology.completeAffirmative,
    this.scenarios = const [],
    this.selectedScenarioId = 'exc_comp_aff_01',
    this.showConstituentSplit = true,
    this.showSemanticTraps = true,
  });

  ExceptionScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  ExceptionRestrictionState copyWith({
    ExceptionTypology? selectedTypology,
    List<ExceptionScenario>? scenarios,
    String? selectedScenarioId,
    bool? showConstituentSplit,
    bool? showSemanticTraps,
  }) {
    return ExceptionRestrictionState(
      selectedTypology: selectedTypology ?? this.selectedTypology,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showConstituentSplit: showConstituentSplit ?? this.showConstituentSplit,
      showSemanticTraps: showSemanticTraps ?? this.showSemanticTraps,
    );
  }
}

class ExceptionRestrictionController extends ChangeNotifier {
  ExceptionRestrictionState _state = const ExceptionRestrictionState();
  ExceptionRestrictionState get state => _state;

  ExceptionRestrictionController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. الاستثناء التام المثبت: وجوب النصب
      const ExceptionScenario(
        id: 'exc_comp_aff_01',
        typology: ExceptionTypology.completeAffirmative,
        titleAr: 'الاسْتِثْنَاءُ التَّامُّ المُثْبَتُ: وُجُوبُ النَّصْبِ عَلَى الاسْتِثْنَاءِ',
        titleEn: 'Complete Affirmative Exception: Obligatory Exclusion',
        titleDe: 'Vollständige positive Ausnahme: "außer + Dativ" vs. "bis auf"',
        exceptionMarkerAr: 'إِلَّا (حَرْفُ اسْتِثْنَاءٍ)',
        mustathnaMinhuAr: 'القَوْمُ (مَذْكُورٌ فِي جُمْلَةٍ مُثْبَتَةٍ)',
        mustathnaAr: 'المُقَصِّرَ (مُسْتَثْنًى مَنْصُوبٌ وُجُوباً)',
        fullSentenceAr: 'حَضَرَ القَوْمُ مَجْلِسَ العِلْمِ إِلَّا المُقَصِّرَ فِي وَاجِبِهِ.',
        fullSentenceEn: 'All the folk attended the gathering of knowledge except the one negligent in his duty.',
        fullSentenceDe: 'Alle Leute erschienen zur Wissensrunde außer dem Nachlässigen in seiner Pflicht.',
        syntacticRuleAr: 'إِذَا ذُكِرَ المُسْتَثْنَى مِنْهُ وَكَانَ الكَلَامُ مُثْبَتاً غَيْرَ مَنْفِيٍّ، وَجَبَ نَصْبُ مَا بَعْدَ (إِلَّا) عَلَى الاسْتِثْنَاءِ.',
        syntacticRuleEn: 'Use "except / except for" to subtract a member from a universal affirmative set ("All ... except").',
        syntacticRuleDe: '"außer" verlangt in der Regel den Dativ ("außer dem Nachlässigen"), kann aber auch Kasus-Kongruenz zeigen.',
        semanticTrapNote: 'تنبيه دلالي: الخَلْطُ بَيْنَ (except = الإِخْرَاجُ وَالطَّرْحُ) وَ(besides = الإِضَافَةُ وَالضَّمُّ) يَقْلِبُ المَعْنَى رَأْساً عَلَى عَقِبٍ.',
        restrictivePrecisionScore: 0.96,
      ),

      // 2. الاستثناء التام المنفي: جواز البدل والنصب
      const ExceptionScenario(
        id: 'exc_comp_neg_01',
        typology: ExceptionTypology.completeNegative,
        titleAr: 'الاسْتِثْنَاءُ التَّامُّ المَنْفِيُّ: البَدَلُ المُطَابِقُ أَوِ النَّصْبُ',
        titleEn: 'Complete Negative Exception: Appositive Substitution vs. Accusative',
        titleDe: 'Vollständige verneinte Ausnahme: "Niemand außer + Dativ/Kongruenz"',
        exceptionMarkerAr: 'إِلَّا',
        mustathnaMinhuAr: 'أَحَدٌ (مَذْكُورٌ فِي سِيَاقِ النَّفْيِ)',
        mustathnaAr: 'الصَّادِقُ (بَدَلٌ مَرْفُوعٌ — وَهُوَ الأَفْصَحُ) أَوْ الصَّادِقَ (مَنْصُوبٌ)',
        fullSentenceAr: 'مَا ثَبَتَ فِي مَوْقِفِ الشِّدَّةِ أَحَدٌ إِلَّا الصَّادِقُ عَهْدُهُ.',
        fullSentenceEn: 'No one stood firm in the hour of trial save him whose covenant was sincere.',
        fullSentenceDe: 'Niemand blieb in der Stunde der Prüfung standhaft außer demjenigen, dessen Bund aufrichtig war.',
        syntacticRuleAr: 'يَجُوزُ فِي التَّامِّ المَنْفِيِّ إِعْرَابُهُ بَدَلاً تَابِعاً لِلْمُسْتَثْنَى مِنْهُ فِي الإِعْرَابِ (الرَّفْعُ هُنَا) أَوْ نَصْبُهُ عَلَى الاسْتِثْنَاءِ.',
        syntacticRuleEn: 'Negative polarity licensers ("No one ... except/save") emphasize exclusive survival of the single exception.',
        syntacticRuleDe: 'Nach verneinten Pronomen ("niemand", "nichts") steht "außer" häufig mit Dativ oder im gleichen Kasus wie das Bezugswort.',
        semanticTrapNote: 'تنبيه: البَدَلِيَّةُ فِي التَّامِّ المَنْفِيِّ هِيَ المُخْتَارَةُ فِي الفَصِيحِ؛ كَقَوْلِهِ تَعَالَى: ﴿مَا فَعَلُوهُ إِلَّا قَلِيلٌ مِنْهُمْ﴾.',
        restrictivePrecisionScore: 0.98,
      ),

      // 3. الاستثناء الناقص المفرغ: أسلوب القصر والحصر
      const ExceptionScenario(
        id: 'exc_holl_01',
        typology: ExceptionTypology.hollowedRestrictive,
        titleAr: 'الاسْتِثْنَاءُ المُفَرَّغُ (النَّاقِصُ): القَصْرُ وَالحَصْرُ البَلَاغِيُّ',
        titleEn: 'Hollowed Exception & Restrictive Focus: "Only / Nothing But / Nur"',
        titleDe: 'Restriktive Fokuspartikeln: "nur / lediglich" als arabisches Al-Mufarragh',
        exceptionMarkerAr: 'مَا ... إِلَّا (أَدَاةُ حَصْرٍ مُلْغَاةُ العَمَلِ)',
        mustathnaMinhuAr: 'مَحْذُوفٌ (نَاقِصٌ مَنْفِيٌّ)',
        mustathnaAr: 'المُخْلِصُونَ (فَاعِلٌ مَرْفُوعٌ بِالوَاوِ تَفْرِيغاً)',
        fullSentenceAr: 'مَا يَرْتَقِي إِلَى مَرَاتِبِ السُّؤْدَدِ إِلَّا المُخْلِصُونَ فِي أَعْمَالِهِمْ.',
        fullSentenceEn: 'None ascend to the heights of nobility save the sincere in their deeds (Only the sincere ascend).',
        fullSentenceDe: 'Nur diejenigen steigen zu wahrer Würde auf, die in ihren Taten aufrichtig sind.',
        syntacticRuleAr: 'إِذَا حُذِفَ المُسْتَثْنَى مِنْهُ فِي النَّفْيِ، تُلْغَى (إِلَّا) وَيُعْرَبُ مَا بَعْدَهَا حَسَبَ مَوْقِعِهِ (فَاعِلٌ) لِإِفَادَةِ الحَصْرِ التَّامِّ.',
        syntacticRuleEn: 'Negation + exception ("nothing but" / "none save") translates functionally to positive restrictive focus ("only").',
        syntacticRuleDe: 'Die arabische Verneinung mit "illa" entspricht im Deutschen meist der Fokuspartikel "nur" oder "lediglich".',
        semanticTrapNote: 'فائدة أسلوبية: القَصْرُ بِالنَّفْيِ وَالاسْتِثْنَاءِ (مَا ... إِلَّا) أَقْوَى فِي دَفْعِ الإِنْكَارِ مِنَ الإِثْبَاتِ المُجَرَّدِ.',
        restrictivePrecisionScore: 0.99,
      ),

      // 4. الاستثناء بالأسماء (غير وسوى) والأفعال (خلا وعدا وحاشا)
      const ExceptionScenario(
        id: 'exc_nom_01',
        typology: ExceptionTypology.nominalPrepositional,
        titleAr: 'الاسْتِثْنَاءُ بِالْأَسْمَاءِ (غَيْرُ وَسِوَى) وَحُرُوفِ التَّعْلِيقِ (خَلَا/عَدَا)',
        titleEn: 'Nominal Exceptives (Ghayr/Siwa) & Prepositional Exclusions',
        titleDe: 'Nominale Ausnahmeformen ("abgesehen von", "ausgenommen")',
        exceptionMarkerAr: 'غَيْرَ / سِوَى (تَأْخُذُ حُكْمَ المُسْتَثْنَى وَمَا بَعْدَهَا مُضَافٌ إِلَيْهِ)',
        mustathnaMinhuAr: 'الطُّلَّابُ',
        mustathnaAr: 'غَيْرَ (مَنْصُوبَةٌ) + وَاحِدٍ (مُضَافٌ إِلَيْهِ مَجْرُورٌ)',
        fullSentenceAr: 'أَتْقَنَ الطُّلَّابُ المَسْأَلَةَ غَيْرَ وَاحِدٍ تَأَخَّرَ عَنِ الدَّرْسِ.',
        fullSentenceEn: 'The students mastered the theorem, apart from one who arrived late to the lecture.',
        fullSentenceDe: 'Die Studenten beherrschten das Thema, abgesehen von einem, der sich verspätete.',
        syntacticRuleAr: '(غَيْرُ وَسِوَى) اسْمَانِ يَأْخُذَانِ إِعْرَابَ مَا بَعْدَ (إِلَّا)، وَيَكُونُ الاسْمُ التَّالِي لَهُمَا مَجْرُوراً بِالإِضَافَةِ دَائِماً.',
        syntacticRuleEn: 'Nominal exceptive prepositions ("apart from", "barring", "aside from") take noun phrases or gerunds.',
        syntacticRuleDe: '"abgesehen von + Dativ" oder das Partizip "ausgenommen" (mit Akkusativ/Kongruenz) ersetzen "außer" im gehobenen Stil.',
        semanticTrapNote: 'تنبيه إعرابي: لا يُنْصَبُ المَعْدُودُ بَعْدَ (غَيْرَ) أَبَداً؛ فَحَقُّهُ الجَرُّ بِالإِضَافَةِ، وَالْإِعْرَابُ الظَّاهِرُ يَقَعُ عَلَى (غَيْر) نَفْسِهَا.',
        restrictivePrecisionScore: 0.94,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectTypology(ExceptionTypology typology) {
    final filtered = _state.scenarios.where((s) => s.typology == typology).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedScenarioId;
    _state = _state.copyWith(
      selectedTypology: typology,
      selectedScenarioId: nextId,
    );
    notifyListeners();
  }

  void selectScenario(String id) {
    _state = _state.copyWith(selectedScenarioId: id);
    notifyListeners();
  }

  void toggleConstituentSplit() {
    _state = _state.copyWith(showConstituentSplit: !_state.showConstituentSplit);
    notifyListeners();
  }

  void toggleSemanticTraps() {
    _state = _state.copyWith(showSemanticTraps: !_state.showSemanticTraps);
    notifyListeners();
  }
}
