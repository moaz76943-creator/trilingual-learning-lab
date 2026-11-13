import 'package:flutter/foundation.dart';

enum PragmaticRegisterLevel {
  diwanicFormal,   // الخطاب الرسمي والتبجيل (Formal Institutional / Sehr formell / Siezen)
  academicScholarly, // الخطاب الأكاديمي والتحليلي الموثق (Academic & Scholarly)
  professionalCorporate, // الخطاب المهني التنفيذي (Professional Workplace)
  familiarSolidarity     // الخطاب الأخوي التضامني والودي (Informal / Duzen / Intimate)
}

enum SpeechActIntent {
  requestWithPoliteness, // طلب المساعدة بأدب جم (Polite Request / Höfliche Bitte)
  disagreementRefusal,   // إبداء الرأي المخالف بلباقة (Polite Dissent / Konstruktiver Widerspruch)
  commendationGratitude, // الشكر والثناء والدعاء (Gratitude & Honorific Praise / Dank & Würdigung)
  apologyRectification   // الاعتذار وتدارك الخلل (Remediation & Sincere Apology / Entschuldigung)
}

class RegisterScenario {
  final String id;
  final PragmaticRegisterLevel level;
  final SpeechActIntent intent;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String utteranceAr; // مشكولة شكلاً تاماً
  final String utteranceEn;
  final String utteranceDe;
  final String politenessMarkerAr;
  final String politenessMarkerEn;
  final String politenessMarkerDe;
  final String pragmaticAnalysisAr;
  final String pragmaticAnalysisEn;
  final String pragmaticAnalysisDe;
  final double faceSavingScore; // 0.0 إلى 1.0 (Brown & Levinson Politeness Metric)

  const RegisterScenario({
    required this.id,
    required this.level,
    required this.intent,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.utteranceAr,
    required this.utteranceEn,
    required this.utteranceDe,
    required this.politenessMarkerAr,
    required this.politenessMarkerEn,
    required this.politenessMarkerDe,
    required this.pragmaticAnalysisAr,
    required this.pragmaticAnalysisEn,
    required this.pragmaticAnalysisDe,
    required this.faceSavingScore,
  });
}

class PragmaticRegisterState {
  final PragmaticRegisterLevel selectedLevel;
  final SpeechActIntent selectedIntent;
  final List<RegisterScenario> scenarios;
  final String selectedScenarioId;
  final bool showMitigationMarkers;
  final bool showCrossCulturalTips;

  const PragmaticRegisterState({
    this.selectedLevel = PragmaticRegisterLevel.diwanicFormal,
    this.selectedIntent = SpeechActIntent.requestWithPoliteness,
    this.scenarios = const [],
    this.selectedScenarioId = 'reg_req_01',
    this.showMitigationMarkers = true,
    this.showCrossCulturalTips = true,
  });

  RegisterScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  PragmaticRegisterState copyWith({
    PragmaticRegisterLevel? selectedLevel,
    SpeechActIntent? selectedIntent,
    List<RegisterScenario>? scenarios,
    String? selectedScenarioId,
    bool? showMitigationMarkers,
    bool? showCrossCulturalTips,
  }) {
    return PragmaticRegisterState(
      selectedLevel: selectedLevel ?? this.selectedLevel,
      selectedIntent: selectedIntent ?? this.selectedIntent,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showMitigationMarkers: showMitigationMarkers ?? this.showMitigationMarkers,
      showCrossCulturalTips: showCrossCulturalTips ?? this.showCrossCulturalTips,
    );
  }
}

class PragmaticRegisterController extends ChangeNotifier {
  PragmaticRegisterState _state = const PragmaticRegisterState();
  PragmaticRegisterState get state => _state;

  PragmaticRegisterController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. طلب المساعدة في سياق رسمي مبجل
      const RegisterScenario(
        id: 'reg_req_01',
        level: PragmaticRegisterLevel.diwanicFormal,
        intent: SpeechActIntent.requestWithPoliteness,
        titleAr: 'طَلَبُ الإِفَادَةِ فِي مَقَامِ التَّبْجِيلِ وَالرَّسْمِيَّةِ',
        titleEn: 'High-Formality Information Request & Honorific Addressing',
        titleDe: 'Formelles Auskunftsersuchen mit Höflichkeitsdistanz',
        utteranceAr: 'نَرْجُو مِنْ كَرَمِ سِيَادَتِكُمْ، حَفِظَكُمُ اللهُ، التَّفَضُّلَ بِتَزْوِيدِنَا بِالبَيَانَاتِ المُعْتَمَدَةِ عِنْدَ تَيَسُّرِ الأَمْرِ.',
        utteranceEn: 'Would you be so kind as to favor us with the authenticated records at your earliest convenience?',
        utteranceDe: 'Dürften wir Sie höflichst darum ersuchen, uns die beglaubigten Unterlagen bei Gelegenheit zukommen zu lassen?',
        politenessMarkerAr: 'حَفِظَكُمُ اللهُ / التَّفَضُّلَ بِـ / كَرَمِ سِيَادَتِكُمْ',
        politenessMarkerEn: 'Would you be so kind as to / favor us with / at your earliest convenience',
        politenessMarkerDe: 'Dürften wir höflichst / Sie darum ersuchen / bei Gelegenheit zukommen zu lassen (Konjunktiv II)',
        pragmaticAnalysisAr: 'اسْتِخْدَامُ صِيَغِ الدُّعَاءِ، جَمْعِ التَّعْظِيمِ، وَأَفْعَالِ الرَّجَاءِ المَقْرُونَةِ بِخَفْضِ الجَنَاحِ لِتَفَادِي فَرْضِ الطَّلَبِ.',
        pragmaticAnalysisEn: 'Negative politeness strategy mitigating Face-Threatening Acts (FTA) via counterfactual modals and deferential hedging.',
        pragmaticAnalysisDe: 'Distanzhöflichkeit durch Konjunktiv II ("dürften"), Siezen und syntaktische Dezentrierung des Appells.',
        faceSavingScore: 0.98,
      ),

      // 2. إبداء الاعتراض بلباقة في السياق الأكاديمي
      const RegisterScenario(
        id: 'reg_dis_01',
        level: PragmaticRegisterLevel.academicScholarly,
        intent: SpeechActIntent.disagreementRefusal,
        titleAr: 'إِبْدَاءُ النَّقْدِ المَنْهَجِيِّ بِأَدَبٍ عِلْمِيٍّ رَصِينٍ',
        titleEn: 'Scholarly Dissent & Mitigated Counter-Argumentation',
        titleDe: 'Akademischer Diskurs & Argumentativer Einwand',
        utteranceAr: 'مَعَ بَالِغِ التَّقْدِيرِ لِهَذَا الطَّرْحِ الرَّصِينِ، إِلَّا أَنَّ الشَّوَاهِدَ الاسْتِقْرَائِيَّةَ قَدْ تُشِيرُ إِلَى مَنْحًى مُغَايِرٍ يَسْتَوْجِبُ إِعَادَةَ النَّظَرِ.',
        utteranceEn: 'While deeply appreciative of this compelling hypothesis, empirical indicators suggest an alternate paradigm that may warrant nuanced re-examination.',
        utteranceDe: 'Bei aller Wertschätzung für diesen beachtlichen Ansatz deuten empirische Befunde womöglich auf eine abweichende Perspektive hin.',
        politenessMarkerAr: 'مَعَ بَالِغِ التَّقْدِيرِ / قَدْ تُشِيرُ / يَسْتَوْجِبُ إِعَادَةَ النَّظَرِ',
        politenessMarkerEn: 'While deeply appreciative of / suggest / may warrant nuanced re-examination',
        politenessMarkerDe: 'Bei aller Wertschätzung für / deuten womöglich hin / abweichende Perspektive',
        pragmaticAnalysisAr: 'التَّمْهِيدُ بِالثَّنَاءِ قَبْلَ النَّقْدِ، وَاسْتِعْمَالُ (قَدْ) لِلتَّقْلِيلِ وَالتَّوْطِئَةِ حِفْظاً لِكَرَامَةِ البَاحِثِ.',
        pragmaticAnalysisEn: 'Token agreement buffer followed by modal hedging ("suggest", "may") to depersonalize intellectual disagreement.',
        pragmaticAnalysisDe: 'Höfliche Antithese: Lobende Prämisse gefolgt von vorsichtiger Relativierung ("womöglich").',
        faceSavingScore: 0.94,
      ),

      // 3. الشكر والثناء والدعاء في سياق مهني تنفيذي
      const RegisterScenario(
        id: 'reg_com_01',
        level: PragmaticRegisterLevel.professionalCorporate,
        intent: SpeechActIntent.commendationGratitude,
        titleAr: 'الشُّكْرُ المِهْنِيُّ وَالتَّقْدِيرُ التَّنْفِيذِيُّ لِلْجُهُودِ',
        titleEn: 'Executive Recognition & Collaborative Acknowledgement',
        titleDe: 'Geschäftliche Anerkennung & Professionelle Würdigung',
        utteranceAr: 'نُثَمِّنُ غَالِياً تَفَانِيَ فَرِيقِكُمُ الكَرِيمِ فِي إِتْمَامِ المَشْرُوعِ بِأَعْلَى مَعَايِيرِ الإِتْقَانِ، جَزَاكُمُ اللهُ خَيْراً.',
        utteranceEn: 'We sincerely commend your team’s exemplary commitment to delivering this milestone with exceptional rigor and excellence.',
        utteranceDe: 'Wir schätzen den herausragenden Einsatz Ihres Teams bei der fristgerechten und präzisen Umsetzung dieses Meilensteins sehr.',
        politenessMarkerAr: 'نُثَمِّنُ غَالِياً / فَرِيقِكُمُ الكَرِيمِ / جَزَاكُمُ اللهُ خَيْراً',
        politenessMarkerEn: 'sincerely commend / exemplary commitment / exceptional rigor',
        politenessMarkerDe: 'schätzen sehr / herausragenden Einsatz / präzisen Umsetzung',
        pragmaticAnalysisAr: 'مُزَاوَجَةُ التَّقْدِيرِ الإِدَارِيِّ بِالدُّعَاءِ الإِسْلامِيِّ النَّبِيلِ لِتَوْطِيدِ أُصُولِ المَوَدَّةِ وَالإِخْلاصِ.',
        pragmaticAnalysisEn: 'Positive politeness building solidarity and team cohesion via sincere appreciation and elevated praise.',
        pragmaticAnalysisDe: 'Professionelle Anerkennung mit präzisem Leistungsbezug zur Festigung partnerschaftlicher Kooperation.',
        faceSavingScore: 0.96,
      ),

      // 4. الاعتذار والاعتراف بالسهو في سياق تضامني أخوي
      const RegisterScenario(
        id: 'reg_apo_01',
        level: PragmaticRegisterLevel.familiarSolidarity,
        intent: SpeechActIntent.apologyRectification,
        titleAr: 'الاعْتِذَارُ الصَّادِقُ وَتَدَارُكُ السَّهْوِ بَيْنَ الإِخْوَةِ',
        titleEn: 'Fraternal Apology, Graceful Amends & Shared Solidarity',
        titleDe: 'Brüderliche Entschuldigung & Einvernehmliche Wiedergutmachung',
        utteranceAr: 'أَعْتَذِرُ إِلَيْكَ مِنْ صَمِيمِ قَلْبِي يَا أَخِي عَنْ هَذَا التَّأْخِيرِ غَيْرِ المَقْصُودِ، وَسَأَتَدَارَكُ الأَمْرَ سَرِيعاً بِإِذْنِ اللهِ.',
        utteranceEn: 'Please accept my heartfelt apologies, brother, for this unintentional oversight; I will promptly put things right, God willing.',
        utteranceDe: 'Verzeih mir bitte von Herzen diese unbeabsichtigte Verzögerung, lieber Bruder; ich bringe das unverzüglich in Ordnung.',
        politenessMarkerAr: 'مِنْ صَمِيمِ قَلْبِي / يَا أَخِي / بِإِذْنِ اللهِ',
        politenessMarkerEn: 'heartfelt apologies / brother / promptly put things right',
        politenessMarkerDe: 'Verzeih mir bitte / von Herzen / lieber Bruder / unverzüglich',
        pragmaticAnalysisAr: 'إِعْلاءُ رَابِطَةِ الأُخُوَّةِ مَعَ تَحَمُّلِ المَسْؤُولِيَّةِ المُبَاشِرَةِ وَرَبْطِ التَّدَارُكِ بِمَشِيئَةِ اللهِ.',
        pragmaticAnalysisEn: 'In-group solidarity marker ("brother") and unmitigated accountability restoring relational balance.',
        pragmaticAnalysisDe: 'Direkte Duz-Kultur (Duzen) mit emotionaler Aufrichtigkeit ("von Herzen") zur sofortigen Harmonisierung.',
        faceSavingScore: 0.92,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectLevel(PragmaticRegisterLevel level) {
    final filtered = _state.scenarios.where((s) => s.level == level).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedScenarioId;
    _state = _state.copyWith(
      selectedLevel: level,
      selectedScenarioId: nextId,
    );
    notifyListeners();
  }

  void selectIntent(SpeechActIntent intent) {
    final filtered = _state.scenarios.where((s) => s.intent == intent).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedScenarioId;
    _state = _state.copyWith(
      selectedIntent: intent,
      selectedScenarioId: nextId,
    );
    notifyListeners();
  }

  void selectScenario(String id) {
    _state = _state.copyWith(selectedScenarioId: id);
    notifyListeners();
  }

  void toggleMitigationMarkers() {
    _state = _state.copyWith(showMitigationMarkers: !_state.showMitigationMarkers);
    notifyListeners();
  }

  void toggleCrossCulturalTips() {
    _state = _state.copyWith(showCrossCulturalTips: !_state.showCrossCulturalTips);
    notifyListeners();
  }
}
