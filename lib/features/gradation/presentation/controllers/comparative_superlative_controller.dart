import 'package:flutter/foundation.dart';

enum GradationPattern {
  comparativeDifferential, // المفاضلة الصريحة (أفضلُ مِنْ / -er than / größer als)
  superlativeDefinite,     // التفضيل المطلق والمقترن بأل (الأفضلُ / the best / am besten)
  periphrasticIndirect,    // التفضيل غير المباشر بالمصدر الصريح (أشدُّ اتِّقَاناً / more diligent)
  correlativeProportional  // التناسب الطردي التفضيلي (كلَّمَا ... ازدادَ / The more ... the more / Je ... desto)
}

class GradationScenario {
  final String id;
  final GradationPattern pattern;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String positiveBaseAr; // الصفة المجردة (الأصل) مشكولة
  final String gradedSentenceAr; // جملة التفضيل العربية مشكولة شكلاً تاماً
  final String gradedSentenceEn;
  final String gradedSentenceDe;
  final String morphologicalRuleAr;
  final String morphologicalRuleEn;
  final String morphologicalRuleDe;
  final String commonErrorWarning;
  final double scalarIntensityIndex; // 0.0 إلى 1.0

  const GradationScenario({
    required this.id,
    required this.pattern,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.positiveBaseAr,
    required this.gradedSentenceAr,
    required this.gradedSentenceEn,
    required this.gradedSentenceDe,
    required this.morphologicalRuleAr,
    required this.morphologicalRuleEn,
    required this.morphologicalRuleDe,
    required this.commonErrorWarning,
    required this.scalarIntensityIndex,
  });
}

class ComparativeSuperlativeState {
  final GradationPattern selectedPattern;
  final List<GradationScenario> scenarios;
  final String selectedScenarioId;
  final bool showMorphologicalRules;
  final bool showCommonErrors;

  const ComparativeSuperlativeState({
    this.selectedPattern = GradationPattern.comparativeDifferential,
    this.scenarios = const [],
    this.selectedScenarioId = 'grad_comp_01',
    this.showMorphologicalRules = true,
    this.showCommonErrors = true,
  });

  GradationScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  ComparativeSuperlativeState copyWith({
    GradationPattern? selectedPattern,
    List<GradationScenario>? scenarios,
    String? selectedScenarioId,
    bool? showMorphologicalRules,
    bool? showCommonErrors,
  }) {
    return ComparativeSuperlativeState(
      selectedPattern: selectedPattern ?? this.selectedPattern,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showMorphologicalRules: showMorphologicalRules ?? this.showMorphologicalRules,
      showCommonErrors: showCommonErrors ?? this.showCommonErrors,
    );
  }
}

class ComparativeSuperlativeController extends ChangeNotifier {
  ComparativeSuperlativeState _state = const ComparativeSuperlativeState();
  ComparativeSuperlativeState get state => _state;

  ComparativeSuperlativeController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. المفاضلة الصريحة: أَفْعَلُ مِنْ / better than / besser als
      const GradationScenario(
        id: 'grad_comp_01',
        pattern: GradationPattern.comparativeDifferential,
        titleAr: 'اسْمُ التَّفْضِيلِ المُجَرَّدُ مِنْ (أَلْ) وَالإِضَافَةِ (لُزُومُ الإِفْرَادِ وَالتَّذْكِيرِ)',
        titleEn: 'Differential Comparative: "Better than" & Invariant Arabic Form',
        titleDe: 'Komparativ mit "als": Ungleichheitsvergleich & Umlautung',
        positiveBaseAr: 'نَافِعٌ / كَبِيرٌ',
        gradedSentenceAr: 'العِلْمُ النَّافِعُ أَنْفَعُ مِنَ المَالِ الكَثِيرِ، وَالحِكْمَةُ أَكْبَرُ شَأْناً مِنْ كُنُوزِ الدُّنْيَا.',
        gradedSentenceEn: 'Beneficial knowledge is far more rewarding than abundant wealth, and wisdom is greater in stature.',
        gradedSentenceDe: 'Nützliches Wissen ist wertvoller als großer Reichtum, und Weisheit ist bedeutender als weltliche Schätze.',
        morphologicalRuleAr: 'إِذَا تَجَرَّدَ اسْمُ التَّفْضِيلِ مِنْ (أَلْ) وَالإِضَافَةِ وَجَبَ إِفْرَادُهُ وَتَذْكِيرُهُ دَائِماً (حَتَّى لَوْ كَانَ المُفَضَّلُ مُؤَنَّثاً: الحِكْمَةُ أَكْبَرُ).',
        morphologicalRuleEn: 'Short adjectives take "-er + than" ("greater than"); multi-syllable words take "more + Adj + than".',
        morphologicalRuleDe: 'Der Komparativ wird stets mit "-er" + "als" gebildet; einsilbige Vokale erhalten oft einen Umlaut (groß ➔ größer).',
        commonErrorWarning: 'الخطأ الشائع: تَأْنِيثُ اسْمِ التَّفْضِيلِ مَعَ (مِنْ) مِثْلَ (*الحِكْمَةُ كُبْرَى مِنْ)، أَوِ اسْتِعْمَالُ (wie) بَدَلاً مِنْ (als) فِي الأَلْمَانِيَّةِ.',
        scalarIntensityIndex: 0.85,
      ),

      // 2. التفضيل المطلق المقترن بأل: وجوب المطابقة
      const GradationScenario(
        id: 'grad_sup_01',
        pattern: GradationPattern.superlativeDefinite,
        titleAr: 'التَّفْضِيلُ المُقْتَرِنُ بِـ (أَلْ): وُجُوبُ المُطَابَقَةِ فِي الجِنْسِ وَالعَدَدِ',
        titleEn: 'Definite Superlative: "The Best / The Highest" Agreement',
        titleDe: 'Superlativ: Prädikativ ("am höchsten") vs. Attributiv ("die höchste")',
        positiveBaseAr: 'عَالٍ / فُضْلَى',
        gradedSentenceAr: 'الأَمَانَةُ هِيَ الصِّفَةُ الفُضْلَى، وَالمُخْلِصُونَ هُمُ الأَعْلَوْنَ مَنْزِلَةً عِنْدَ رَبِّهِمْ.',
        gradedSentenceEn: 'Trustworthiness is the noblest virtue, and the sincere occupy the highest rank before their Lord.',
        gradedSentenceDe: 'Vertrauenswürdigkeit ist die edelste Tugend, und die Aufrichtigen stehen im höchsten Ansehen.',
        morphologicalRuleAr: 'اسْمُ التَّفْضِيلِ المُحَلَّى بِـ(أَلْ) تَجِبُ مُطَابَقَتُهُ لِلْمَوْصُوفِ تَذْكِيراً وَتَأْنِيثاً وَإِفْرَاداً وَجَمْعاً (الصِّفَةُ الفُضْلَى / الأَعْلَوْنَ).',
        morphologicalRuleEn: 'Definite superlatives require "the" + "-est / most" and cannot combine with "more" (*"the most noblest").',
        morphologicalRuleDe: 'Attributiver Superlativ dekliniert nach Kasus/Genus ("die edelste Tugend"); prädikativer nutzt "am ...-sten".',
        commonErrorWarning: 'الخطأ الشائع: جَمْعُ الأُسْلُوبَيْنِ فِي الإِنْجِلِيزِيَّةِ (*more better / most noblest) أَوْ إِهْمَالُ تَأْنِيثِ (فُعْلَى) فِي العَرَبِيَّةِ مَعَ (أَلْ).',
        scalarIntensityIndex: 1.0,
      ),

      // 3. التفضيل غير المباشر بالمصدر الصريح المنصوب على التمييز
      const GradationScenario(
        id: 'grad_peri_01',
        pattern: GradationPattern.periphrasticIndirect,
        titleAr: 'التَّفْضِيلُ غَيْرُ المُبَاشِرِ لِلْمَصَادِرِ الخُمَاسِيَّةِ وَالسُّدَاسِيَّةِ وَالأَلْوَانِ',
        titleEn: 'Periphrastic Gradation: "More Diligent / More Vibrant"',
        titleDe: 'Analytische Steigerung & Partizipialkomparative im Deutschen',
        positiveBaseAr: 'اجْتِهَادٌ / إِتْقَانٌ (مَصَادِرُ مَزِيدَةٌ)',
        gradedSentenceAr: 'الطَّالِبُ المُثَابِرُ أَكْثَرُ اجْتِهَاداً وَأَشَدُّ إِتْقَاناً فِي تَحْصِيلِ العُلُومِ.',
        gradedSentenceEn: 'The persevering student is significantly more diligent and thorough in acquiring sciences.',
        gradedSentenceDe: 'Der beharrliche Student ist weitaus fleißiger und gründlicher beim Erwerb der Wissenschaften.',
        morphologicalRuleAr: 'مَا خَالَفَ شُرُوطَ التَّفْضِيلِ (كَالفِعْلِ المَزِيدِ أَوِ الدَّالِّ عَلَى لَوْنٍ) يُؤْتَى بِمَصْدَرِهِ مَنْصُوباً عَلَى التَّمْيِيزِ بَعْدَ (أَشَدُّ / أَكْثَرُ).',
        morphologicalRuleEn: 'Long derived adjectives and participles use analytical "more/most" + uninflected base.',
        morphologicalRuleDe: 'Im Deutschen erhalten auch lange Adjektive und Partizipien regulär "-er/-ste" ("beeindruckender", nicht *"mehr beeindruckend").',
        commonErrorWarning: 'الخطأ الشائع: صِيَاغَةُ التَّفْضِيلِ مُبَاشَرَةً مِنَ المَزِيدِ (*أَجْتَهَدُ مِنْ) أَوْ تَرْجَمَةُ (more) حَرْفِيّاً بِـ (*mehr fleißig) فِي الأَلْمَانِيَّةِ.',
        scalarIntensityIndex: 0.90,
      ),

      // 4. التناسب الطردي التفضيلي: كلما ... كلما / The more ... the more / Je ... desto
      const GradationScenario(
        id: 'grad_corr_01',
        pattern: GradationPattern.correlativeProportional,
        titleAr: 'التَّنَاسُبُ الطَّرْدِيُّ التَّفْضِيلِيُّ (كُلَّمَا ... ازْدَادَ / Je ... desto)',
        titleEn: 'Correlative Proportional Comparative ("The more ..., the more ...")',
        titleDe: 'Proportionalsatz mit "Je + Komparativ ... desto/umso + Komparativ"',
        positiveBaseAr: 'تَوَاضَعَ ➔ رَفَعَهُ اللَّهُ',
        gradedSentenceAr: 'كُلَّمَا ازْدَادَ العَالِمُ تَوَاضُعاً وَتَبَصُّراً، كَانَ أَرْفَعَ قَدْراً وَأَعْظَمَ أَثَراً.',
        gradedSentenceEn: 'The more deeply a scholar practices humility, the higher his rank and the greater his impact become.',
        gradedSentenceDe: 'Je bescheidener ein Gelehrter wird, desto höher steigt sein Ansehen und desto tiefer wirkt sein Wissen.',
        morphologicalRuleAr: 'أُسْلُوبُ الشَّرْطِ التَّكْرَارِيِّ بِـ (كُلَّمَا) يَرْبِطُ الزِّيَادَةَ المُطَّرِدَةَ فِي الصِّفَةِ الأُولَى بِتَنَاسُبِهَا فِي النَّتِيجَةِ.',
        morphologicalRuleEn: 'Parallel correlative construction ("The + comparative + S + V, the + comparative + S + V").',
        morphologicalRuleDe: 'Im "Je"-Satz steht das finite Verb am Ende (Nebensatz), im "desto/umso"-Satz direkt nach dem Komparativ (Position 2!).',
        commonErrorWarning: 'الخطأ الشائع: تَكْرَارُ (كُلَّمَا) فِي الجَوَابِ (*كُلَّمَا اجْتَهَدْتَ كُلَّمَا نَجَحْتَ) وَالصَّوَابُ حَذْفُهَا فِي الجَوَابِ؛ وَكَلِمَةُ (desto) تَتْبَعُهَا الصِّفَةُ ثُمَّ الفِعْلُ مُبَاشَرَةً.',
        scalarIntensityIndex: 0.95,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectPattern(GradationPattern pattern) {
    final filtered = _state.scenarios.where((s) => s.pattern == pattern).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedScenarioId;
    _state = _state.copyWith(
      selectedPattern: pattern,
      selectedScenarioId: nextId,
    );
    notifyListeners();
  }

  void selectScenario(String id) {
    _state = _state.copyWith(selectedScenarioId: id);
    notifyListeners();
  }

  void toggleMorphologicalRules() {
    _state = _state.copyWith(showMorphologicalRules: !_state.showMorphologicalRules);
    notifyListeners();
  }

  void toggleCommonErrors() {
    _state = _state.copyWith(showCommonErrors: !_state.showCommonErrors);
    notifyListeners();
  }
}
