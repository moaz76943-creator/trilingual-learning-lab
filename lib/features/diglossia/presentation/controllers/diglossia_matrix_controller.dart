import 'package:flutter/foundation.dart';

enum SituationalContext {
  academicConference,  // المحافل الأكاديمية والندوات العلمية (Hochformell / Formal Lecture)
  dailyMarketplace,    // المعاملات اليومية والأسواق (Alltag / Informal Transactional)
  intimateFamilyHome,  // الحديث الأسري والبيتي الودود (Familie / In-group Solidarity)
  diplomaticOfficial   // الدبلوماسية والمراسلات الرسمية (Behörden / Institutional Diwanic)
}

class DialectalScenario {
  final String id;
  final SituationalContext context;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String standardFormalAr; // الفصحى المشكولة شكلاً تاماً
  final String colloquialSpokenAr; // التعبير الشائع في اللسان الدارج الحي
  final String standardFormalEn;
  final String colloquialSpokenEn;
  final String standardHochdeutschDe;
  final String umgangssprachlichDe;
  final String sociolinguisticRuleAr;
  final String sociolinguisticRuleEn;
  final String sociolinguisticRuleDe;
  final double appropriatenessIndex; // 0.0 إلى 1.0 (مؤشر الملاءمة المقامية)

  const DialectalScenario({
    required this.id,
    required this.context,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.standardFormalAr,
    required this.colloquialSpokenAr,
    required this.standardFormalEn,
    required this.colloquialSpokenEn,
    required this.standardHochdeutschDe,
    required this.umgangssprachlichDe,
    required this.sociolinguisticRuleAr,
    required this.sociolinguisticRuleEn,
    required this.sociolinguisticRuleDe,
    required this.appropriatenessIndex,
  });
}

class DiglossiaMatrixState {
  final SituationalContext selectedContext;
  final List<DialectalScenario> scenarios;
  final String selectedScenarioId;
  final bool showPhoneticShifts;
  final bool showPragmaticSuitability;

  const DiglossiaMatrixState({
    this.selectedContext = SituationalContext.academicConference,
    this.scenarios = const [],
    this.selectedScenarioId = 'dig_acad_01',
    this.showPhoneticShifts = true,
    this.showPragmaticSuitability = true,
  });

  DialectalScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  DiglossiaMatrixState copyWith({
    SituationalContext? selectedContext,
    List<DialectalScenario>? scenarios,
    String? selectedScenarioId,
    bool? showPhoneticShifts,
    bool? showPragmaticSuitability,
  }) {
    return DiglossiaMatrixState(
      selectedContext: selectedContext ?? this.selectedContext,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showPhoneticShifts: showPhoneticShifts ?? this.showPhoneticShifts,
      showPragmaticSuitability: showPragmaticSuitability ?? this.showPragmaticSuitability,
    );
  }
}

class DiglossiaMatrixController extends ChangeNotifier {
  DiglossiaMatrixState _state = const DiglossiaMatrixState();
  DiglossiaMatrixState get state => _state;

  DiglossiaMatrixController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. المحفل الأكاديمي والندوات العلمية
      const DialectalScenario(
        id: 'dig_acad_01',
        context: SituationalContext.academicConference,
        titleAr: 'طَرْحُ التَّسَاؤُلِ فِي مَحْفَلٍ أَبْحَاثِيٍّ رَصِينٍ',
        titleEn: 'Academic Inquiry: High Register vs. Conversational Shortcut',
        titleDe: 'Wissenschaftliche Fragestellung: Standarddeutsch vs. Umgangssprache',
        standardFormalAr: 'هَلْ يَتَفَضَّلُ الأُسْتَاذُ المُحَاضِرُ بِإِيضَاحِ المَنْهَجِيَّةِ المُتَّبَعَةِ فِي اسْتِخْلَاصِ هَذِهِ النَّتَائِجِ؟',
        colloquialSpokenAr: 'مُمْكِنْ دُكْتُورْ تُوَضِّحْ لَنَا كَيْفَ وَصَلْتُمْ لِهَالنَّتِيجَة؟',
        standardFormalEn: 'Could the esteemed lecturer elaborate on the empirical methodology utilized to derive these conclusions?',
        colloquialSpokenEn: 'Could you tell us real quick how you came up with these figures?',
        standardHochdeutschDe: 'Wären Sie so freundlich, die methodischen Prämissen zur Herleitung dieser Befunde näher zu erläutern?',
        umgangssprachlichDe: 'Können Sie mal kurz erklären, wie Sie auf das Ergebnis gekommen sind?',
        sociolinguisticRuleAr: 'فِي المَحَافِلِ الأَكَادِيمِيَّةِ يُلْتَزَمُ بِالفُصْحَى الكَامِلَةِ مَعَ صِيَغِ التَّبْجِيلِ وَتَجَنُّبِ الكَلِمَاتِ العَامِّيَّةِ المُقْتَضَبَةِ.',
        sociolinguisticRuleEn: 'High-formality academic register necessitates Latinate vocabulary and subjunctive honorific framing.',
        sociolinguisticRuleDe: 'Im wissenschaftlichen Diskurs ist Standarddeutsch mit Konjunktiv II und Fachterminologie obligatorisch.',
        appropriatenessIndex: 0.98,
      ),

      // 2. المعاملات اليومية والأسواق
      const DialectalScenario(
        id: 'dig_mark_01',
        context: SituationalContext.dailyMarketplace,
        titleAr: 'المُفَاوَضَةُ فِي السُّوقِ وَالتَّسَوُّقِ اليَوْمِيِّ',
        titleEn: 'Marketplace Negotiation: Pragmatic Naturalness',
        titleDe: 'Alltägliche Marktsituation: Höflichkeit & Ungezwungenheit',
        standardFormalAr: 'بِكَمْ تَبِيعُ هَذِهِ السِّلْعَةَ المُبَارَكَةَ، جَزَاكَ اللَّهُ خَيْراً؟',
        colloquialSpokenAr: 'قَدِّيشْ حَقّ هَايْ اللَّهْ يُبَارِكْ فِيكْ؟ / كَامْ دِي لَوْ سَمَحْتْ؟',
        standardFormalEn: 'What is the designated consideration for this merchandise, may you be blessed?',
        colloquialSpokenEn: 'How much are you asking for this one, please?',
        standardHochdeutschDe: 'Dürfte ich mich nach dem festgesetzten Preis für diese Ware erkundigen?',
        umgangssprachlichDe: 'Was kostet das denn hier? / Was macht das zusammen?',
        sociolinguisticRuleAr: 'اسْتِعْمَالُ الفُصْحَى التُّرَاثِيَّةِ المُتَقَعِّرَةِ فِي السُّوقِ قَدْ يَبْدُو غَرِيباً؛ يُفَضَّلُ التَّعْبِيرُ اللَّبِقُ السَّلِسُ.',
        sociolinguisticRuleEn: 'Archaic formality in everyday trade creates social distance; natural conversational idiom is standard.',
        sociolinguisticRuleDe: 'Auf dem Wochenmarkt ist eine entspannte, direkte Sprache ("Was kostet das?") angemessener als Distanz-Konjunktive.',
        appropriatenessIndex: 0.94,
      ),

      // 3. الحديث الأسري والبيتي الودود
      const DialectalScenario(
        id: 'dig_fam_01',
        context: SituationalContext.intimateFamilyHome,
        titleAr: 'التَّحَاوُرُ الأُسَرِيُّ وَالتَّرَاحُمُ المَنْزِلِيُّ',
        titleEn: 'Family Warmth: In-Group Bonding vs. Hyper-Formality',
        titleDe: 'Familiäre Zuneigung & Brüderlicher Austausch',
        standardFormalAr: 'كَيْفَ كَانَ يَوْمُكَ يَا أَخِي الكَرِيمَ، هَلْ وَجَدْتَ رَاحَةً فِي عَمَلِكَ؟',
        colloquialSpokenAr: 'كَيْفْ كَانْ يَوْمَكْ يَا غَالِي؟ كُلّ شِي تَمَامْ؟',
        standardFormalEn: 'How transpired your diurnal endeavor today, my beloved sibling?',
        colloquialSpokenEn: 'How was your day, dear? Everything went well?',
        standardHochdeutschDe: 'Wie gestaltete sich der heutige Tag für dich, mein verehrter Bruder?',
        umgangssprachlichDe: 'Wie war dein Tag heute? Alles glattgelaufen?',
        sociolinguisticRuleAr: 'تَسُودُ صِيَغُ القُرْبِ وَالمَوَدَّةِ التَّلْقَائِيَّةِ مَعَ الدُّعَاءِ الصَّادِقِ دُونَ تَكَلُّفٍ لَفْظِيٍّ مُعَقَّدٍ.',
        sociolinguisticRuleEn: 'Intimate domestic domain prioritizes warmth, emotional prosody, and idiomatic contractions.',
        sociolinguisticRuleDe: 'In der Familie wirkt steifes Hochdeutsch distanzierend; hier herrschen Nähe und Duzen vor.',
        appropriatenessIndex: 0.96,
      ),

      // 4. الدبلوماسية والمراسلات الرسمية
      const DialectalScenario(
        id: 'dig_diplo_01',
        context: SituationalContext.diplomaticOfficial,
        titleAr: 'المُخَاطَبَةُ الدِّبْلُومَاسِيَّةُ وَالمُرَاسَلَاتُ الحُكُومِيَّةُ',
        titleEn: 'Diplomatic Protocol: Strict Institutional Invariance',
        titleDe: 'Diplomatisches Protokoll: Amtliche Verbindlichkeit',
        standardFormalAr: 'نَرْفَعُ إِلَى سِيَادَتِكُمْ أَسْمَى آيَاتِ التَّقْدِيرِ وَالاحْتِرَامِ، مُعْرِبِينَ عَنْ حِرْصِنَا عَلَى تَعْزِيزِ التَّعَاوُنِ.',
        colloquialSpokenAr: 'بِنْبَعْتِلْكُم كُلّ التَّحِيَّة وَحَابِّينْ نِشْتَغِلْ مَعْ بَعْضْ أَكْثَر.',
        standardFormalEn: 'We convey to your excellency the assurances of our highest consideration, reaffirming our commitment to mutual partnership.',
        colloquialSpokenEn: 'Sending you warm wishes and hoping we can work together more.',
        standardHochdeutschDe: 'Wir beehren uns, Eurer Exzellenz den Ausdruck unserer vorzüglichsten Hochachtung zu übermitteln.',
        umgangssprachlichDe: 'Schöne Grüße an Sie, wir freuen uns auf mehr Zusammenarbeit.',
        sociolinguisticRuleAr: 'حَظْرٌ قَاطِعٌ لِأَيِّ تَعْبِيرٍ دَارِجٍ أَوْ عَامِّيٍّ فِي الخِطَابِ الدِّبْلُومَاسِيِّ؛ اللُّغَةُ هُنَا سِيَادِيَّةٌ مُنْضَبِطَةٌ.',
        sociolinguisticRuleEn: 'Zero tolerance for colloquialisms in official diplomacy; fixed protocol formulas govern discourse.',
        sociolinguisticRuleDe: 'Diplomatischer Notenwechsel erfordert strikte Einhaltung diplomatischer Floskeln ohne jede Saloppheit.',
        appropriatenessIndex: 0.99,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectContext(SituationalContext context) {
    final filtered = _state.scenarios.where((s) => s.context == context).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedScenarioId;
    _state = _state.copyWith(
      selectedContext: context,
      selectedScenarioId: nextId,
    );
    notifyListeners();
  }

  void selectScenario(String id) {
    _state = _state.copyWith(selectedScenarioId: id);
    notifyListeners();
  }

  void togglePhoneticShifts() {
    _state = _state.copyWith(showPhoneticShifts: !_state.showPhoneticShifts);
    notifyListeners();
  }

  void togglePragmaticSuitability() {
    _state = _state.copyWith(showPragmaticSuitability: !_state.showPragmaticSuitability);
    notifyListeners();
  }
}
