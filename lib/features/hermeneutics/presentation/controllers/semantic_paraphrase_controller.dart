import 'package:flutter/foundation.dart';

enum EquivalenceType {
  dynamicExegetical, // التكافؤ التفسيري الديناميكي (Dynamic / Communicative Equivalence)
  formalStructural,   // التكافؤ الشكلي البنائي (Formal Equivalence / Wörtliche Entsprechung)
  conceptualVoid      // معالجة الفجوات الدلالية والثقافية (Cultural & Conceptual Voids / Sprachliche Lücken)
}

enum SynonymNuanceCategory {
  affectiveIntensity,  // التفاوت في شدة المعنى والحدة الشعورية (e.g. حزن / هم / غم / كمد)
  temporalAspect,      // الفروق الزمنية والحدثية (e.g. عام / سنة / حول)
  moralConnotation     // الفروق الأخلاقية والروحية (e.g. رأفة / رحمة / إحسان)
}

class HermeneuticUnit {
  final String id;
  final EquivalenceType equivalenceType;
  final SynonymNuanceCategory nuanceCategory;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String originalTermAr; // مشكول شكلاً تاماً
  final String originalTermEn;
  final String originalTermDe;
  final String exegeticalParaphraseAr; // إعادة صياغة تفسيرية دقيقة
  final String exegeticalParaphraseEn;
  final String exegeticalParaphraseDe;
  final String conceptualVoidExplanation;
  final List<String> fineGrainNuancesAr;
  final List<String> fineGrainNuancesEn;
  final List<String> fineGrainNuancesDe;
  final double semanticInvarianceScore; // 0.0 إلى 1.0 (معيار الحفاظ على جوهر المعنى)

  const HermeneuticUnit({
    required this.id,
    required this.equivalenceType,
    required this.nuanceCategory,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.originalTermAr,
    required this.originalTermEn,
    required this.originalTermDe,
    required this.exegeticalParaphraseAr,
    required this.exegeticalParaphraseEn,
    required this.exegeticalParaphraseDe,
    required this.conceptualVoidExplanation,
    required this.fineGrainNuancesAr,
    required this.fineGrainNuancesEn,
    required this.fineGrainNuancesDe,
    required this.semanticInvarianceScore,
  });
}

class SemanticParaphraseState {
  final EquivalenceType selectedEquivalence;
  final List<HermeneuticUnit> units;
  final String selectedUnitId;
  final bool showExegeticalNotes;
  final bool showNuanceBreakdown;
  final double targetInvarianceThreshold;

  const SemanticParaphraseState({
    this.selectedEquivalence = EquivalenceType.dynamicExegetical,
    this.units = const [],
    this.selectedUnitId = 'herm_01',
    this.showExegeticalNotes = true,
    this.showNuanceBreakdown = true,
    this.targetInvarianceThreshold = 0.90,
  });

  HermeneuticUnit? get currentUnit {
    if (units.isEmpty) return null;
    return units.firstWhere(
      (u) => u.id == selectedUnitId,
      orElse: () => units.first,
    );
  }

  SemanticParaphraseState copyWith({
    EquivalenceType? selectedEquivalence,
    List<HermeneuticUnit>? units,
    String? selectedUnitId,
    bool? showExegeticalNotes,
    bool? showNuanceBreakdown,
    double? targetInvarianceThreshold,
  }) {
    return SemanticParaphraseState(
      selectedEquivalence: selectedEquivalence ?? this.selectedEquivalence,
      units: units ?? this.units,
      selectedUnitId: selectedUnitId ?? this.selectedUnitId,
      showExegeticalNotes: showExegeticalNotes ?? this.showExegeticalNotes,
      showNuanceBreakdown: showNuanceBreakdown ?? this.showNuanceBreakdown,
      targetInvarianceThreshold: targetInvarianceThreshold ?? this.targetInvarianceThreshold,
    );
  }
}

class SemanticParaphraseController extends ChangeNotifier {
  SemanticParaphraseState _state = const SemanticParaphraseState();
  SemanticParaphraseState get state => _state;

  SemanticParaphraseController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultUnits = [
      // 1. التكافؤ التفسيري الأخلاقي: الرأفة والرحمة
      const HermeneuticUnit(
        id: 'herm_01',
        equivalenceType: EquivalenceType.dynamicExegetical,
        nuanceCategory: SynonymNuanceCategory.moralConnotation,
        titleAr: 'الفَرْقُ البَيَانِيُّ الدَّقِيقُ بَيْنَ الرَّأْفَةِ وَالرَّحْمَةِ',
        titleEn: 'Exegetical Dissection: Compassion vs. Tender Clemency',
        titleDe: 'Hermeneutische Differenzierung: Gnade, Milde & Barmherzigkeit',
        originalTermAr: 'الرَّأْفَةُ وَالرَّحْمَةُ',
        originalTermEn: 'Tender Clemency (Ra\'fah) vs. Comprehensive Mercy (Rahmah)',
        originalTermDe: 'Zärtliche Milde (Ra\'fah) vs. Allumfassende Barmherzigkeit (Rahmah)',
        exegeticalParaphraseAr: 'الرَّأْفَةُ أَبْلَغُ مِنْ حَيْثُ دَفْعُ المَكْرُوهِ وَرَفْعُ المَشَقَّةِ العَاجِلَةِ، بَيْنَمَا الرَّحْمَةُ أَعَمُّ لِشُمُولِهَا جَلْبَ الخَيْرَاتِ وَتَدَارُكَ الهَفَوَاتِ.',
        exegeticalParaphraseEn: 'Ra\'fah is acute, preventive tenderness specifically warding off affliction; Rahmah is expansive, engendering benevolence and spiritual restoration.',
        exegeticalParaphraseDe: 'Ra\'fah bezeichnet das gezielte Abwenden von Leid und Schmerz; Rahmah ist die universelle, segenspendende Gnade und Güte.',
        conceptualVoidExplanation: 'English "mercy" merges both; dynamic exegesis requires discerning preventive tenderness from active benevolence.',
        fineGrainNuancesAr: [
          'الرَّأْفَةُ: دَفْعُ الأَلَمِ وَالمَكْرُوهِ قَبْلَ وُقُوعِهِ أَوْ عِنْدَ لَحْظَتِهِ.',
          'الرَّحْمَةُ: إِحْسَانٌ شَامِلٌ يَجْلِبُ النَّفْعَ وَيُغَفِّرُ الزَّلَلَ.'
        ],
        fineGrainNuancesEn: [
          'Clemency / Acute Relief: focused on averting pain.',
          'Mercy / Grace: active bestowal of enduring blessing.'
        ],
        fineGrainNuancesDe: [
          'Zärtliche Schonung: Vorbeugung vor Härte und Not.',
          'Umfassende Barmherzigkeit: Weitreichende Förderung des Wohlergehens.'
        ],
        semanticInvarianceScore: 0.96,
      ),

      // 2. الفروق الزمنية والحدثية: السنة والعام
      const HermeneuticUnit(
        id: 'herm_02',
        equivalenceType: EquivalenceType.formalStructural,
        nuanceCategory: SynonymNuanceCategory.temporalAspect,
        titleAr: 'الفَرْقُ التَّأْوِيلِيُّ بَيْنَ السَّنَةِ وَالعَامِ فِي اللِّسَانِ العَرَبِيِّ',
        titleEn: 'Aspectual Temporal Nuance: Year of Austerity vs. Year of Abundance',
        titleDe: 'Aspektuelle Zeitdifferenzierung: Entbehrungsjahr vs. Blüte- und Segensjahr',
        originalTermAr: 'السَّنَةُ وَالعَامُ',
        originalTermEn: 'Sanah (Year of tribulation/severity) vs. \'Am (Year of ease/prosperity)',
        originalTermDe: 'Sanah (Schwerezeit/Dürrejahr) vs. \'Am (Segensreiches Erntejahr)',
        exegeticalParaphraseAr: 'تُطْلَقُ (السَّنَةُ) غَالِباً فِي السِّيَاقَاتِ الَّتِي تَغْلِبُ عَلَيْهَا المَشَقَّةُ وَالجَدْبُ، فِي حِينِ يُطْلَقُ (العَامُ) عَلَى الفَتْرَةِ المُقْتَرِنَةِ بِالرَّخَاءِ وَالخِصْبِ وَالبَرَكَةِ.',
        exegeticalParaphraseEn: 'In Arabic Quranic and classical hermeneutics, "Sanah" predominantly evokes harshness and toil, whereas "\'Am" connotes relief, rejuvenation, and abundance.',
        exegeticalParaphraseDe: 'Klassische Hermeneutik unterscheidet die Beschwerlichkeit von "Sanah" vom gelösten Überfluss eines "\'Am".',
        conceptualVoidExplanation: 'Neither English ("year") nor German ("Jahr") marks subjective experience morpho-lexically without qualifying adjectives.',
        fineGrainNuancesAr: [
          'السَّنَةُ: ثِقَلُ الأَيَّامِ وَشِدَّتُهَا (مِنْهُ سَنَةُ المَجَاعَةِ).',
          'العَامُ: نَمَاءٌ وَرَغَدُ عَيْشٍ (فِيهِ يُغَاثُ النَّاسُ).'
        ],
        fineGrainNuancesEn: [
          'Sanah: connotation of testing, drought, or rigorous labor.',
          '\'Am: connotation of rainfall, harvest, and communal solace.'
        ],
        fineGrainNuancesDe: [
          'Sanah: Bedrückung, Dürre und Erprobung der Geduld.',
          '\'Am: Befreiung, Regen und gedeihliches Aufatmen.'
        ],
        semanticInvarianceScore: 0.94,
      ),

      // 3. الفجوات الدلالية المفهومية: التقوى و Weltschmerz و Schadenfreude
      const HermeneuticUnit(
        id: 'herm_03',
        equivalenceType: EquivalenceType.conceptualVoid,
        nuanceCategory: SynonymNuanceCategory.affectiveIntensity,
        titleAr: 'مُعَالَجَةُ الفَجَوَاتِ الدَّلالِيَّةِ الثَّقَافِيَّةِ العَمِيقَةِ (Untranslatability)',
        titleEn: 'Navigating Lexical Voids: Taqwa, Weltschmerz, and Schadenfreude',
        titleDe: 'Bewältigung sprachlicher Lücken: Taqwa, Weltschmerz & Schadenfreude',
        originalTermAr: 'التَّقْوَى (Taqwa)',
        originalTermEn: 'Conscious God-Wary Mindfulness & Protective Shield (Taqwa)',
        originalTermDe: 'Ehrfürchtige Achtsamkeit & Gottesbewusstes Schutzhandeln (Taqwa)',
        exegeticalParaphraseAr: 'التَّقْوَى حَالَةٌ قَلْبِيَّةٌ وَعَمَلِيَّةٌ يَتَّخِذُ فِيهَا العَبْدُ وِقَايَةً مِنْ سَخَطِ اللهِ بِامْتِثَالِ الأَوَامِرِ وَاجْتِنَابِ النَّوَاهِي، وَلَا تُؤَدِّيهَا كَلِمَةُ (Fear/Furcht) بِمُفْرَدِهَا.',
        exegeticalParaphraseEn: 'Taqwa transcends mere "fear" or "piety"; it is an active spiritual vigilance constructing an invulnerable safeguard between the self and divine displeasure.',
        exegeticalParaphraseDe: 'Taqwa ist kein bloßes Fürchten, sondern ein wachsamer, innerer Schutzschild durch tugendhafte Lebenspraxis.',
        conceptualVoidExplanation: 'Translating Taqwa as simple "fear" distorts the Islamic virtue of reverential mindfulness into paralyzing dread.',
        fineGrainNuancesAr: [
          'الوِقَايَةُ الذَّاتِيَّةُ: جَعْلُ حَاجِزٍ مَنِيعٍ بَيْنَكَ وَبَيْنَ كُلِّ مَا يُغْضِبُ الخَالِقَ.',
          'المُرَاقَبَةُ الشَّامِلَةُ: حُضُورُ الضَّمِيرِ فِي السِّرِّ وَالعَلَنِ.'
        ],
        fineGrainNuancesEn: [
          'Vigilant Safeguard: proactive avoidance of spiritual harm.',
          'Reverential Awe: harmonious devotion over slavish terror.'
        ],
        fineGrainNuancesDe: [
          'Achtsamer Schutzschild: Aktive Meidung sittlichen Fehlverhaltens.',
          'Ehrfurcht: Liebevoller Respekt statt blinder Angst.'
        ],
        semanticInvarianceScore: 0.98,
      ),
    ];

    _state = _state.copyWith(
      units: defaultUnits,
      selectedUnitId: defaultUnits.first.id,
    );
  }

  void selectEquivalence(EquivalenceType type) {
    final filtered = _state.units.where((u) => u.equivalenceType == type).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedUnitId;
    _state = _state.copyWith(
      selectedEquivalence: type,
      selectedUnitId: nextId,
    );
    notifyListeners();
  }

  void selectUnit(String id) {
    _state = _state.copyWith(selectedUnitId: id);
    notifyListeners();
  }

  void toggleExegeticalNotes() {
    _state = _state.copyWith(showExegeticalNotes: !_state.showExegeticalNotes);
    notifyListeners();
  }

  void toggleNuanceBreakdown() {
    _state = _state.copyWith(showNuanceBreakdown: !_state.showNuanceBreakdown);
    notifyListeners();
  }

  void setInvarianceThreshold(double threshold) {
    _state = _state.copyWith(targetInvarianceThreshold: threshold.clamp(0.0, 1.0));
    notifyListeners();
  }
}
