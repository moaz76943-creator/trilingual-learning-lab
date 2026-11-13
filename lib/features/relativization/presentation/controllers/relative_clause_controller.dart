import 'package:flutter/foundation.dart';

enum RelativizationPattern {
  resumptivePronounBinding, // عائد الصلة والرابط الإسنادي (Resumptive Pronoun / A\'id)
  restrictiveVsAppositive,  // الصلة التقييدية المحددة مقابل التوضيحية (Restrictive vs. Non-Restrictive)
  prepositionStrandingPied, // الجر بالموصول والتقديم (Pied-Piping vs. Stranding / Präpositional-Relativsätze)
  asyndeticZeroRelative     // صلة النكرة بدون اسم موصول (Asyndetic Contact Clauses / النعت بالجملة)
}

class RelativizationScenario {
  final String id;
  final RelativizationPattern pattern;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String antecedentAr; // العائد عليه (Antecedent / Bezugswort)
  final String relativeMarkerAr; // الاسم الموصول (الذي / التي / مَنْ / ما)
  final String resumptivePronounAr; // الضمير العائد (الرابط)
  final String fullSentenceAr; // الجملة العربية مشكولة شكلاً تاماً
  final String fullSentenceEn;
  final String fullSentenceDe;
  final String syntacticAnalysisAr;
  final String syntacticAnalysisEn;
  final String syntacticAnalysisDe;
  final String commonTransferError; // خطأ النقل والترجمة الشائع
  final double structuralComplexityScore; // 0.0 إلى 1.0

  const RelativizationScenario({
    required this.id,
    required this.pattern,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.antecedentAr,
    required this.relativeMarkerAr,
    required this.resumptivePronounAr,
    required this.fullSentenceAr,
    required this.fullSentenceEn,
    required this.fullSentenceDe,
    required this.syntacticAnalysisAr,
    required this.syntacticAnalysisEn,
    required this.syntacticAnalysisDe,
    required this.commonTransferError,
    required this.structuralComplexityScore,
  });
}

class RelativeClauseState {
  final RelativizationPattern selectedPattern;
  final List<RelativizationScenario> scenarios;
  final String selectedScenarioId;
  final bool showResumptiveBinding;
  final bool showTransferPitfall;

  const RelativeClauseState({
    this.selectedPattern = RelativizationPattern.resumptivePronounBinding,
    this.scenarios = const [],
    this.selectedScenarioId = 'rel_resump_01',
    this.showResumptiveBinding = true,
    this.showTransferPitfall = true,
  });

  RelativizationScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  RelativeClauseState copyWith({
    RelativizationPattern? selectedPattern,
    List<RelativizationScenario>? scenarios,
    String? selectedScenarioId,
    bool? showResumptiveBinding,
    bool? showTransferPitfall,
  }) {
    return RelativeClauseState(
      selectedPattern: selectedPattern ?? this.selectedPattern,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showResumptiveBinding: showResumptiveBinding ?? this.showResumptiveBinding,
      showTransferPitfall: showTransferPitfall ?? this.showTransferPitfall,
    );
  }
}

class RelativeClauseController extends ChangeNotifier {
  RelativeClauseState _state = const RelativeClauseState();
  RelativeClauseState get state => _state;

  RelativeClauseController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. عائد الصلة والرابط الإسنادي في العربية مقابل حذفه في الإنجليزية والألمانية
      const RelativizationScenario(
        id: 'rel_resump_01',
        pattern: RelativizationPattern.resumptivePronounBinding,
        titleAr: 'عَائِدُ الصِّلَةِ المَلْفُوظُ فِي العَرَبِيَّةِ مُقَابِلَ حَذْفِهِ فِي الغَرْبِيَّةِ',
        titleEn: 'Obligatory Resumptive Pronoun vs. Traced Gap Structure',
        titleDe: 'Resumptivpronomen im Arabischen vs. Relativsatz-Lücke im Deutschen',
        antecedentAr: 'الكِتَابُ المُنِيرُ',
        relativeMarkerAr: 'الَّذِي',
        resumptivePronounAr: 'الْهَاءُ فِي (قَرَأْتُهُ)',
        fullSentenceAr: 'هَذَا هُوَ الكِتَابُ المُنِيرُ الَّذِي قَرَأْتُهُ فِي مَسِيرَتِي وَاسْتَفَدْتُ مِنْهُ.',
        fullSentenceEn: 'This is the luminous book that I read [GAP] along my path and benefited from.',
        fullSentenceDe: 'Dies ist das erhellende Buch, das ich auf meinem Weg las [LÜCKE] und von dem ich profitierte.',
        syntacticAnalysisAr: 'صِلَةُ المَوْصُولِ فِي العَرَبِيَّةِ تَفْرِضُ ضَمِيراً رَابِطاً (العَائِدَ) مَلْفُوظاً كَالْهَاءِ فِي (قَرَأْتُهُ) يَرْبِطُ الجُمْلَةَ بِالمَوْصُولِ.',
        syntacticAnalysisEn: 'English strictly forbids resumptive object pronouns (*"the book that I read it"); a phonologically null gap is licensed instead.',
        syntacticAnalysisDe: 'Das deutsche Relativpronomen "das" vertritt die Leerstelle vollständig; ein zusätzliches "es" (*"das ich es las") ist ungrammatisch.',
        commonTransferError: 'الخطأ الشائع: تَرْجَمَةُ العَائِدِ حَرْفِيّاً إِلَى الإِنْجِلِيزِيَّةِ (*"The book which I read it") أَوْ إِسْقَاطُهُ مِنَ العَرَبِيَّةِ فَيَصِيرُ التَّرْكِيبُ رَكِيكاً.',
        structuralComplexityScore: 0.96,
      ),

      // 2. الصلة التقييدية المحددة مقابل التوضيحية الاعتراضية (Restrictive vs. Non-Restrictive)
      const RelativizationScenario(
        id: 'rel_rest_01',
        pattern: RelativizationPattern.restrictiveVsAppositive,
        titleAr: 'الصِّلَةُ التَّقْيِيدِيَّةُ اللَّازِمَةُ مُقَابِلَ الاعْتِرَاضِيَّةِ التَّوْضِيحِيَّةِ',
        titleEn: 'Restrictive (That/Zero) vs. Non-Restrictive Appositive (Which + Comma)',
        titleDe: 'Restriktiver (notwendiger) vs. Nicht-restriktiver (erläuternder) Relativsatz',
        antecedentAr: 'العُلَمَاءُ الأَجِلَّاءُ',
        relativeMarkerAr: 'الَّذِينَ',
        resumptivePronounAr: 'وَاوُ الجَمَاعَةِ فِي (يَبْذُلُونَ)',
        fullSentenceAr: 'العُلَمَاءُ الَّذِينَ يَبْذُلُونَ جُهْدَهُمْ لِخِدْمَةِ النَّاسِ، يُقَدِّرُهُمُ المُجْتَمَعُ.',
        fullSentenceEn: 'Scholars who dedicate their efforts to serve humanity are deeply valued by society.',
        fullSentenceDe: 'Die Gelehrten, die ihren Einsatz in den Dienst der Menschheit stellen, werden von der Gesellschaft geschätzt.',
        syntacticAnalysisAr: 'الصِّلَةُ هُنَا تَقْيِيدِيَّةٌ لِأَنَّهَا تُحَدِّدُ فِئَةً مَخْصُوصَةً مِنَ العُلَمَاءِ وَلَيْسَتْ جُمْلَةً اعْتِرَاضِيَّةً زَائِدَةً.',
        syntacticAnalysisEn: 'Restrictive clauses lack commas and narrow the referent; non-restrictive clauses require commas and provide supplementary parenthetical detail.',
        syntacticAnalysisDe: 'Im Deutschen werden ausnahmslos ALLE Relativsätze durch Kommas abgetrennt, ungeachtet ihrer restriktiven oder nicht-restriktiven Semantik.',
        commonTransferError: 'الخطأ الشائع: إِسْقَاطُ الفَوَاصِلِ فِي الأَلْمَانِيَّةِ لِظَنِّ أَنَّ الجُمْلَةَ تَقْيِيدِيَّةٌ، فَالقَاعِدَةُ الأَلْمَانِيَّةُ تُوجِبُ الفَاصِلَةَ حَتْماً.',
        structuralComplexityScore: 0.92,
      ),

      // 3. الجر بالموصول والتقديم: التقديم الكامل (Pied-Piping) مقابل تعليق الجار (Preposition Stranding)
      const RelativizationScenario(
        id: 'rel_prep_01',
        pattern: RelativizationPattern.prepositionStrandingPied,
        titleAr: 'تَقْدِيمُ حَرْفِ الجَرِّ مَعَ المَوْصُولِ (Pied-Piping) مُقَابِلَ تَعْلِيقِهِ (Stranding)',
        titleEn: 'Formal Pied-Piping ("In which / Auf dem") vs. Colloquial Stranding ("Which ... in")',
        titleDe: 'Obligatorisches Pied-Piping im Deutschen ("an dem") vs. Stranding im Englischen',
        antecedentAr: 'المَبْدَأُ الرَّصِينُ',
        relativeMarkerAr: 'الَّذِي مَسْبُوقاً بِحَرْفِ الجَرِّ (عَلَيْهِ)',
        resumptivePronounAr: 'الهَاءُ فِي (عَلَيْهِ)',
        fullSentenceAr: 'هَذَا هُوَ المَبْدَأُ الرَّصِينُ الَّذِي ارْتَكَزَ عَلَيْهِ فِي بِنَاءِ مَنْهَجِهِ.',
        fullSentenceEn: 'This is the solid principle on which he anchored his methodology (Colloquial: which he anchored his methodology on).',
        fullSentenceDe: 'Dies ist der feste Grundsatz, auf den er seine Methodik stützte.',
        syntacticAnalysisAr: 'فِي العَرَبِيَّةِ يَتَّصِلُ حَرْفُ الجَرِّ بِالضَّمِيرِ العَائِدِ (عَلَيْهِ) مَعَ تَأَخُّرِهِ مَعَ الفِعْلِ الرَّابِطِ.',
        syntacticAnalysisEn: 'Formal academic English prefers pied-piping ("on which"), whereas spoken English permits preposition stranding ("which ... on").',
        syntacticAnalysisDe: 'Das Deutsche verbietet Preposition Stranding ausnahmslos (*"den er stützte auf"); die Präposition muss zwingend vor das Relativpronomen.',
        commonTransferError: 'الخطأ الشائع: مُحَاوَلَةُ فَصْلِ حَرْفِ الجَرِّ فِي الأَلْمَانِيَّةِ أَوْ تَرْكِهِ فِي آخِرِ الجُمْلَةِ كَمَا فِي الإِنْجِلِيزِيَّةِ المَحْكِيَّةِ.',
        structuralComplexityScore: 0.95,
      ),

      // 4. صلة النكرة بدون اسم موصول: الجمل بعد النكرات صفات (Asyndetic Zero-Relative)
      const RelativizationScenario(
        id: 'rel_zero_01',
        pattern: RelativizationPattern.asyndeticZeroRelative,
        titleAr: 'جُمْلَةُ النَّعْتِ لِلنَّكِرَةِ دُونَ اسْمِ مَوْصُولٍ (الجُمَلُ بَعْدَ النَّكِرَاتِ صِفَاتٌ)',
        titleEn: 'Asyndetic Zero-Relative & Contact Clauses with Indefinite Antecedent',
        titleDe: 'Attributsätze bei unbestimmten Nomen (Arabischer asyndetischer Relativsatz)',
        antecedentAr: 'نَبِيٌّ كَرِيمٌ (نَكِرَةٌ)',
        relativeMarkerAr: 'مَحْذُوفٌ وُجُوباً (لَا يُسْتَعْمَلُ "الَّذِي" مَعَ النَّكِرَةِ)',
        resumptivePronounAr: 'الضَّمِيرُ المُسْتَتِرُ فِي (يَهْدِي)',
        fullSentenceAr: 'بَعَثَ اللَّهُ نَبِيّاً كَرِيماً يَهْدِي النَّاسَ إِلَى صِرَاطٍ مُسْتَقِيمٍ.',
        fullSentenceEn: 'God sent a noble prophet guiding humanity toward an upright path.',
        fullSentenceDe: 'Gott sandte einen edlen Propheten, der die Menschen auf den geraden Pfad leitet.',
        syntacticAnalysisAr: 'القَاعِدَةُ العَرَبِيَّةُ الخَالِدَةُ: (الجُمَلُ بَعْدَ النَّكِرَاتِ صِفَاتٌ، وَبَعْدَ المَعَارِفِ أَحْوَالٌ)؛ فَلَا يَدْخُلُ الاسْمُ المَوْصُولُ عَلَى نَكِرَةٍ أَبَداً.',
        syntacticAnalysisEn: 'Arabic strictly forbids relative pronouns with indefinite antecedents, using a direct syndetic finite verbal clause as adjective.',
        syntacticAnalysisDe: 'Das Deutsche MUSS auch bei unbestimmten Nomen ein Relativpronomen setzen ("einen Propheten, der...").',
        commonTransferError: 'الخطأ الشائع: إِدْخَالُ الاسْمِ المَوْصُولِ عَلَى النَّكِرَةِ فِي العَرَبِيَّةِ مِثْلَ (*"بَعَثَ نَبِيّاً الَّذِي يَهْدِي") وَهُوَ لَحْنٌ فَاحِشٌ.',
        structuralComplexityScore: 0.98,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectPattern(RelativizationPattern pattern) {
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

  void toggleResumptiveBinding() {
    _state = _state.copyWith(showResumptiveBinding: !_state.showResumptiveBinding);
    notifyListeners();
  }

  void toggleTransferPitfall() {
    _state = _state.copyWith(showTransferPitfall: !_state.showTransferPitfall);
    notifyListeners();
  }
}
