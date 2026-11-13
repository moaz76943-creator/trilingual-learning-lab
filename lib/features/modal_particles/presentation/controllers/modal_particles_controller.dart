import 'package:flutter/foundation.dart';

enum ParticleFunction {
  sharedPresupposition, // التذكير بالمُسلَّمات والمُشترك (Shared Knowledge / Gemeinsames Wissen - "ja")
  contradictionEmphasis, // دفع الوهم وتأكيد الاعتراض (Contradiction / Widerspruch & Nachdruck - "doch")
  softenedUrgency,       // التلطيف والتودد في الطلب (Mitigation / Höfliche Aufforderung - "mal")
  inevitableResignation  // التسليم بالأمر الواقع وحتمية الحال (Resignation / Unvermeidbarkeit - "eben / halt")
}

class ParticleScenario {
  final String id;
  final ParticleFunction function;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String bareSentenceAr; // الجملة الجافة الخالية من أحرف المعاني
  final String bareSentenceEn;
  final String bareSentenceDe;
  final String flavoredSentenceAr; // الجملة مع حرف المعنى مشكولة شكلاً تاماً
  final String flavoredSentenceEn;
  final String flavoredSentenceDe;
  final String particleAr;
  final String particleEn;
  final String particleDe;
  final String pragmaticAnalysisAr;
  final String pragmaticAnalysisEn;
  final String pragmaticAnalysisDe;
  final double emotionalWarmthIndex; // 0.0 إلى 1.0

  const ParticleScenario({
    required this.id,
    required this.function,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.bareSentenceAr,
    required this.bareSentenceEn,
    required this.bareSentenceDe,
    required this.flavoredSentenceAr,
    required this.flavoredSentenceEn,
    required this.flavoredSentenceDe,
    required this.particleAr,
    required this.particleEn,
    required this.particleDe,
    required this.pragmaticAnalysisAr,
    required this.pragmaticAnalysisEn,
    required this.pragmaticAnalysisDe,
    required this.emotionalWarmthIndex,
  });
}

class ModalParticlesState {
  final ParticleFunction selectedFunction;
  final List<ParticleScenario> scenarios;
  final String selectedScenarioId;
  final bool showPragmaticContrast;
  final bool showAbtönungTips;

  const ModalParticlesState({
    this.selectedFunction = ParticleFunction.sharedPresupposition,
    this.scenarios = const [],
    this.selectedScenarioId = 'part_ja_01',
    this.showPragmaticContrast = true,
    this.showAbtönungTips = true,
  });

  ParticleScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  ModalParticlesState copyWith({
    ParticleFunction? selectedFunction,
    List<ParticleScenario>? scenarios,
    String? selectedScenarioId,
    bool? showPragmaticContrast,
    bool? showAbtönungTips,
  }) {
    return ModalParticlesState(
      selectedFunction: selectedFunction ?? this.selectedFunction,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showPragmaticContrast: showPragmaticContrast ?? this.showPragmaticContrast,
      showAbtönungTips: showAbtönungTips ?? this.showAbtönungTips,
    );
  }
}

class ModalParticlesController extends ChangeNotifier {
  ModalParticlesState _state = const ModalParticlesState();
  ModalParticlesState get state => _state;

  ModalParticlesController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. التذكير بالمُسلَّمات والمُشترك (Shared Knowledge: "أَلَا تَعْلَمُ" / "as you know" / "ja")
      const ParticleScenario(
        id: 'part_ja_01',
        function: ParticleFunction.sharedPresupposition,
        titleAr: 'أَدَاةُ التَّنْبِيهِ وَالتَّذْكِيرِ بِالمَعْلُومِ المُشْتَرَكِ',
        titleEn: 'Evoking Mutual Ground: German "ja" & Arabic "أَلَا / قَدْ"',
        titleDe: 'Gemeinsames Vorwissen aktivieren: Die Modalpartikel "ja"',
        bareSentenceAr: 'العِلْمُ يَنْفَعُ صَاحِبَهُ فِي الدُّنْيَا وَالآخِرَةِ.',
        bareSentenceEn: 'Knowledge benefits its possessor in this life and the hereafter.',
        bareSentenceDe: 'Wissen nützt seinem Besitzer im Diesseits und Jenseits.',
        flavoredSentenceAr: 'أَلَا إِنَّ العِلْمَ يَنْفَعُ صَاحِبَهُ، كَمَا تَعْلَمُ، فَلَا تَتَبَاطَأْ عَنْ طَلَبِهِ.',
        flavoredSentenceEn: 'Knowledge, as you well know, surely elevates its seeker, so do not hesitate.',
        flavoredSentenceDe: 'Wissen nützt einem ja bekanntlich stets, also zögere nicht, danach zu streben.',
        particleAr: 'أَلَا الاسْتِفْتَاحِيَّةُ / التَّنْبِيهِيَّةُ ("أَلَا إِنَّ")',
        particleEn: 'Discourse marker ("as you well know / surely")',
        particleDe: 'Modalpartikel "ja" (unbetont: Verweis auf Bekanntes)',
        pragmaticAnalysisAr: 'حَرْفُ الاسْتِفْتَاحِ (أَلَا) يُنَبِّهُ السَّامِعَ وَيَسْتَحْضِرُ فِي وِجْدَانِهِ حَقِيقَةً مُسْتَقِرَّةً مُتَّفَقاً عَلَيْهَا.',
        pragmaticAnalysisEn: 'Establishes empathetic cognitive alignment, reminding the interlocutor of unquestioned shared assumptions.',
        pragmaticAnalysisDe: 'Die Partikel "ja" signalisiert, dass der Sachverhalt als unstrittig und beiden Gesprächspartnern bewusst gilt.',
        emotionalWarmthIndex: 0.95,
      ),

      // 2. دفع الوهم وتأكيد الاعتراض (Contradiction & Reassurance: "بَلْ / أَمَا" / "after all" / "doch")
      const ParticleScenario(
        id: 'part_doch_01',
        function: ParticleFunction.contradictionEmphasis,
        titleAr: 'دَفْعُ التَّرَدُّدِ وَإِثْبَاتُ العَزِيمَةِ بِمُقَابِلِ (doch)',
        titleEn: 'Overcoming Doubt & Assertive Rebuttal: German "doch"',
        titleDe: 'Zweifel zerstreuen & Nachdruck verleihen: Die Modalpartikel "doch"',
        bareSentenceAr: 'تَسْتَطِيعُ إِكْمَالَ هَذَا العَمَلِ.',
        bareSentenceEn: 'You can complete this task.',
        bareSentenceDe: 'Du kannst diese Aufgabe beenden.',
        flavoredSentenceAr: 'بَلْ أَنْتَ قَادِرٌ عَلَيْهِ يَقِيناً، فَلَا تَسْتَسْلِمْ لِلْوَهَنِ!',
        flavoredSentenceEn: 'You can do this after all! Don’t succumb to despair!',
        flavoredSentenceDe: 'Du kannst das doch schaffen! Gib jetzt bloß nicht auf!',
        particleAr: 'حَرْفُ الإِضْرَابِ وَالتَّوْكِيدِ ("بَلْ")',
        particleEn: 'Intensifier phrase ("after all / surely")',
        particleDe: 'Modalpartikel "doch" (Appell gegen resignative Annahme)',
        pragmaticAnalysisAr: 'اسْتِخْدَامُ (بَلْ) لِلإِضْرَابِ عَنْ وَهْمِ العَجْزِ وَتَثْبِيتِ القُدْرَةِ بِعَزِيمَةٍ صَادِقَةٍ.',
        pragmaticAnalysisEn: 'Counters a negative or anxious premise, injecting motivational resilience into the interlocutor.',
        pragmaticAnalysisDe: '"Doch" widerspricht hier einer impliziten Verzagtheit und fordert zur Überwindung des Zweifels auf.',
        emotionalWarmthIndex: 0.96,
      ),

      // 3. التلطيف والتودد في الطلب (Mitigation: "هَلَّا / تَفَضَّلْ" / "just" / "mal")
      const ParticleScenario(
        id: 'part_mal_01',
        function: ParticleFunction.softenedUrgency,
        titleAr: 'تَلْطِيفُ الأَمْرِ وَخَفْضُ الجَنَاحِ بِمُقَابِلِ (mal)',
        titleEn: 'Polite Attenuation of Commands: German "mal" & Arabic "هَلَّا"',
        titleDe: 'Bitten abmildern & Beiläufigkeit signalisieren: "mal"',
        bareSentenceAr: 'أَعْطِنِي الكِتَابَ لِأَقْرَأَهُ.',
        bareSentenceEn: 'Give me the book to read.',
        bareSentenceDe: 'Gib mir das Buch zum Lesen.',
        flavoredSentenceAr: 'هَلَّا نَاوَلْتَنِي الكِتَابَ هُنَيْهَةً لِأَنْظُرَ فِيهِ، بَارَكَ اللَّهُ فِيكَ؟',
        flavoredSentenceEn: 'Could you just hand me that book for a moment, if you please?',
        flavoredSentenceDe: 'Könntest du mir mal kurz das Buch herreichen, bitte?',
        particleAr: 'أَدَاةُ التَّحْضِيضِ وَالتَّلَطُّفِ ("هَلَّا") مَعَ قَيْدِ اللَّحْظَةِ ("هُنَيْهَةً")',
        particleEn: 'Softener ("just / for a moment")',
        particleDe: 'Modalpartikel "mal" (Signalisiert Geringfügigkeit und Höflichkeit)',
        pragmaticAnalysisAr: 'خَفْضُ وَطْأَةِ الأَمْرِ بِتَحْوِيلِهِ إِلَى طَلَبٍ رَقِيقٍ مَقْرُونٍ بِقَيْدِ القِلَّةِ وَالدُّعَاءِ.',
        pragmaticAnalysisEn: 'Minimizes the perceived burden on the listener, transforming a blunt imperative into an effortless favor.',
        pragmaticAnalysisDe: '"Mal" nimmt der Aufforderung die Schärfe und suggeriert minimalen Aufwand für den Angesprochenen.',
        emotionalWarmthIndex: 0.98,
      ),

      // 4. التسليم بالأمر الواقع وحتمية الحال (Resignation: "قَدَرُ اللَّهِ" / "simply / just" / "eben / halt")
      const ParticleScenario(
        id: 'part_eben_01',
        function: ParticleFunction.inevitableResignation,
        titleAr: 'الرِّضَا بِالمَقْدُورِ وَالتَّسْلِيمُ بِحَتْمِيَّةِ الحَالِ (eben / halt)',
        titleEn: 'Stoic Acceptance & Inevitable Reality: German "eben / halt"',
        titleDe: 'Unabwendbare Tatsachen akzeptieren: "eben" & "halt"',
        bareSentenceAr: 'تَأَخَّرَ القِطَارُ بِسَبَبِ الثَّلْجِ.',
        bareSentenceEn: 'The train was delayed due to snow.',
        bareSentenceDe: 'Der Zug hat sich wegen Schnee verspätet.',
        flavoredSentenceAr: 'قَدَرُ اللَّهِ وَمَا شَاءَ فَعَلَ؛ هَذَا أَمْرٌ وَاقِعٌ لَا حِيلَةَ لَنَا فِيهِ.',
        flavoredSentenceEn: 'It is simply what it is; an unavoidable circumstance beyond our control.',
        flavoredSentenceDe: 'So ist das nun mal; bei diesem Schneesturm geht es halt nicht schneller.',
        particleAr: 'صِيغَةُ التَّسْلِيمِ وَالتَّفْوِيضِ الشَّرْعِيِّ ("قَدَرُ اللَّهِ")',
        particleEn: 'Resignative marker ("simply / just the way it is")',
        particleDe: 'Modalpartikeln "halt / eben" (Ausdruck unumstößlicher Notwendigkeit)',
        pragmaticAnalysisAr: 'التَّحَلِّي بِالصَّبْرِ الجَمِيلِ وَتَسْلِيمُ الأَمْرِ لِلَّهِ دُونَ جَزَعٍ مَعَ إِدْرَاكِ حُدُودِ الاسْتِطَاعَةِ.',
        pragmaticAnalysisEn: 'Conveys pragmatic equanimity in the face of immutable circumstances.',
        pragmaticAnalysisDe: '"Halt" und "eben" drücken die gelassene Hinnahme einer nicht mehr änderbaren Tatsache aus.',
        emotionalWarmthIndex: 0.94,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectFunction(ParticleFunction func) {
    final filtered = _state.scenarios.where((s) => s.function == func).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedScenarioId;
    _state = _state.copyWith(
      selectedFunction: func,
      selectedScenarioId: nextId,
    );
    notifyListeners();
  }

  void selectScenario(String id) {
    _state = _state.copyWith(selectedScenarioId: id);
    notifyListeners();
  }

  void togglePragmaticContrast() {
    _state = _state.copyWith(showPragmaticContrast: !_state.showPragmaticContrast);
    notifyListeners();
  }

  void toggleAbtönungTips() {
    _state = _state.copyWith(showAbtönungTips: !_state.showAbtönungTips);
    notifyListeners();
  }
}
