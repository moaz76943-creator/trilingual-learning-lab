import 'package:flutter/foundation.dart';

enum TransitivityPattern {
  causativeDerivation,  // تصيير اللازم متعدياً بالهمزة والتضعيف (Causativization / Kausativierung)
  inchoativeAnticausative, // أفعال المطاوعة والصيرورة الذاتية (Inchoative-Anticausative / Medialreflexiv)
  ergativeLabileShift,  // التناوب الإرغاتي المشترك للفاعل والمفعول (Ergative Labile Alternation)
  passiveVoiceNuance    // المبني لما لم يسم فاعله وأغراضه البلاغية (Passive Voice / Vorgangspassiv)
}

class TransitivityPair {
  final String id;
  final TransitivityPattern pattern;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String intransitiveOrBaseAr; // الصيغة الأساسية أو اللازمة مشكولة
  final String intransitiveOrBaseEn;
  final String intransitiveOrBaseDe;
  final String causativeOrDerivedAr; // الصيغة المشتقة المتعدية أو المطاوعة مشكولة
  final String causativeOrDerivedEn;
  final String causativeOrDerivedDe;
  final String morphologicalMechanismAr;
  final String morphologicalMechanismEn;
  final String morphologicalMechanismDe;
  final String semanticRoleDistributionAr;
  final double transitivityValencyScore; // 1.0 (لازم / مونو) إلى 2.0 (متعد لمفعول) إلى 3.0 (متعد لاثنين)

  const TransitivityPair({
    required this.id,
    required this.pattern,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.intransitiveOrBaseAr,
    required this.intransitiveOrBaseEn,
    required this.intransitiveOrBaseDe,
    required this.causativeOrDerivedAr,
    required this.causativeOrDerivedEn,
    required this.causativeOrDerivedDe,
    required this.morphologicalMechanismAr,
    required this.morphologicalMechanismEn,
    required this.morphologicalMechanismDe,
    required this.semanticRoleDistributionAr,
    required this.transitivityValencyScore,
  });
}

class CausativeVoiceState {
  final TransitivityPattern selectedPattern;
  final List<TransitivityPair> pairs;
  final String selectedPairId;
  final bool showValencyAnalysis;
  final bool showMorphologicalDerivation;

  const CausativeVoiceState({
    this.selectedPattern = TransitivityPattern.causativeDerivation,
    this.pairs = const [],
    this.selectedPairId = 'trans_caus_01',
    this.showValencyAnalysis = true,
    this.showMorphologicalDerivation = true,
  });

  TransitivityPair? get currentPair {
    if (pairs.isEmpty) return null;
    return pairs.firstWhere(
      (p) => p.id == selectedPairId,
      orElse: () => pairs.first,
    );
  }

  CausativeVoiceState copyWith({
    TransitivityPattern? selectedPattern,
    List<TransitivityPair>? pairs,
    String? selectedPairId,
    bool? showValencyAnalysis,
    bool? showMorphologicalDerivation,
  }) {
    return CausativeVoiceState(
      selectedPattern: selectedPattern ?? this.selectedPattern,
      pairs: pairs ?? this.pairs,
      selectedPairId: selectedPairId ?? this.selectedPairId,
      showValencyAnalysis: showValencyAnalysis ?? this.showValencyAnalysis,
      showMorphologicalDerivation: showMorphologicalDerivation ?? this.showMorphologicalDerivation,
    );
  }
}

class CausativeVoiceController extends ChangeNotifier {
  CausativeVoiceState _state = const CausativeVoiceState();
  CausativeVoiceState get state => _state;

  CausativeVoiceController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultPairs = [
      // 1. تصيير اللازم متعدياً: نزل / أنزل (sinken / senken - fall / fell)
      const TransitivityPair(
        id: 'trans_caus_01',
        pattern: TransitivityPattern.causativeDerivation,
        titleAr: 'تَعْدِيَةُ اللَّازِمِ بِهَمْزَةِ التَّعْدِيَةِ (أَفْعَلَ)',
        titleEn: 'Morphological Causativization: Intransitive ➔ Transitive',
        titleDe: 'Kausative Derivation: sinken (intransitiv) vs. senken (transitiv)',
        intransitiveOrBaseAr: 'نَزَلَ المَطَرُ مِنَ السَّمَاءِ فَأَحْيَا الأَرْضَ.',
        intransitiveOrBaseEn: 'The rain descended from the heavens, reviving the soil.',
        intransitiveOrBaseDe: 'Der Regen sank auf die Erde nieder (intransitiv).',
        causativeOrDerivedAr: 'أَنْزَلَ اللَّهُ المَطَرَ مِنَ السَّمَاءِ رَحْمَةً لِلْعِبَادِ.',
        causativeOrDerivedEn: 'God sent down (caused to descend) rain as a mercy for creation.',
        causativeOrDerivedDe: 'Gott senkte die Barmherzigkeit herab / ließ den Regen fallen (kausativ).',
        morphologicalMechanismAr: 'زِيَادَةُ هَمْزَةِ التَّعْدِيَةِ (أَفْعَلَ) تُصَيِّرُ الفَاعِلَ فِي الأَصْلِ مَفْعُولاً بِهِ.',
        morphologicalMechanismEn: 'Prefixal causativization mapping theme into direct object via agentive subject introduction.',
        morphologicalMechanismDe: 'Ablautbasierter Kausativwechsel im Deutschen (sinken ➔ senken, fallen ➔ fällen).',
        semanticRoleDistributionAr: 'الفَاعِلُ الأَصِيلُ (المَطَرُ) صَارَ مَفْعُولاً بِهِ مُتَأَثِّراً بَعْدَ دُخُولِ العِلَّةِ الفَاعِلِيَّةِ.',
        transitivityValencyScore: 2.0,
      ),

      // 2. أفعال المطاوعة: كسر ➔ تكسر / انكسر (Inchoative Anticausative)
      const TransitivityPair(
        id: 'trans_inch_01',
        pattern: TransitivityPattern.inchoativeAnticausative,
        titleAr: 'أَفْعَالُ المُطَاوَعَةِ وَالصَّيْرُورَةِ الذَّاتِيَّةِ (انْفَعَلَ / تَفَعَّلَ)',
        titleEn: 'Anticausative Inchoativity: Action Effect Acceptance',
        titleDe: 'Inchoativ-Reflexive Antikausativierung (brechen ➔ zerbrechen)',
        intransitiveOrBaseAr: 'كَسَرَ الصَّانِعُ الإِنَاءَ الزُّجَاجِيَّ بِإِتْقَانٍ.',
        intransitiveOrBaseEn: 'The artisan broke the glass vessel with deliberate force.',
        intransitiveOrBaseDe: 'Der Handwerker zerbrach das Glasgefäß (transitiv-agentiv).',
        causativeOrDerivedAr: 'انْكَسَرَ الإِنَاءُ الزُّجَاجِيُّ دُونَ إِحْدَاثِ ضَرَرٍ.',
        causativeOrDerivedEn: 'The glass vessel broke without causing injury (inchoative).',
        causativeOrDerivedDe: 'Das Glasgefäß zerbrach / hat sich aufgelöst (antikausativ).',
        morphologicalMechanismAr: 'صِيغَةُ (انْفَعَلَ) تُفِيدُ قَبُولَ الأَثَرِ وَمُطَاوَعَةَ الفِعْلِ دُونَ ذِكْرِ الفَاعِلِ المُبَاشِرِ.',
        morphologicalMechanismEn: 'Anticausative morphology detransitivizing the event into an unaccusative state-change.',
        morphologicalMechanismDe: 'Antikausative Alternanz: Das direkte Objekt rückt zum Subjekt ohne Passivmarker auf.',
        semanticRoleDistributionAr: 'يَظْهَرُ الحَدَثُ كَأَنَّهُ وَقَعَ تِلْقَائِيّاً لِلتَّرْكِيزِ عَلَى التَّحَوُّلِ الوُجُودِيِّ لِلشَّيْءِ.',
        transitivityValencyScore: 1.0,
      ),

      // 3. التناوب الإرغاتي: فتح الباب / انفتح الباب / The door opened
      const TransitivityPair(
        id: 'trans_erg_01',
        pattern: TransitivityPattern.ergativeLabileShift,
        titleAr: 'التَّنَاوُبُ الإِرْغَاتِيُّ (Ergative Labile Alternation)',
        titleEn: 'Labile Transitivity Alternation: Agentive vs. Spontaneous',
        titleDe: 'Labil-Ergative Verb-Alternanz (öffnen: transitiv vs. intransitiv)',
        intransitiveOrBaseAr: 'فَتَحَ الحَارِسُ أَبْوَابَ المَدِينَةِ لِلزَّائِرِينَ.',
        intransitiveOrBaseEn: 'The gatekeeper opened the city gates for the visitors.',
        intransitiveOrBaseDe: 'Der Wächter öffnete die Stadttore für die Besucher.',
        causativeOrDerivedAr: 'انْفَتَحَتْ أَبْوَابُ الرَّحْمَةِ أَمَامَ التَّائِبِ.',
        causativeOrDerivedEn: 'The gates of mercy opened before the penitent seeker.',
        causativeOrDerivedDe: 'Die Tore der Barmherzigkeit öffneten sich dem Reuigen.',
        morphologicalMechanismAr: 'التَّحَوُّلُ مِنَ التَّرْكِيبِ المُتَعَدِّي إِلَى اللَّازِمِ الإِرْغَاتِيِّ لِإِبْرَازِ العَظَمَةِ وَالتِّلْقَائِيَّةِ.',
        morphologicalMechanismEn: 'Ergative verb allows identical surface lemma ("opened") in English, requiring "sich" in German.',
        morphologicalMechanismDe: 'Im Deutschen reflexiviert ("öffnen sich"), während Englisch dieselbe Verbform nutzt.',
        semanticRoleDistributionAr: 'المَفْعُولُ بِهِ (الأَبْوَابُ) يَتَصَدَّرُ مَوْقِعَ الفَاعِلِ الدَّلَالِيِّ كَمَرْكَزٍ لِلصَّيْرُورَةِ.',
        transitivityValencyScore: 1.5,
      ),

      // 4. المبني للمجهول وأغراضه البلاغية
      const TransitivityPair(
        id: 'trans_pass_01',
        pattern: TransitivityPattern.passiveVoiceNuance,
        titleAr: 'المَبْنِيُّ لِمَا لَمْ يُسَمَّ فَاعِلُهُ وَأَغْرَاضُهُ البَيَانِيَّةُ',
        titleEn: 'Passive Voice Functional Nuance: Agent Demotion & Reverence',
        titleDe: 'Vorgangspassiv & Zustandspassiv: Agens-Tilgung aus Ehrfurcht',
        intransitiveOrBaseAr: 'خَلَقَ اللَّهُ الإِنْسَانَ فِي أَحْسَنِ تَقْوِيمٍ.',
        intransitiveOrBaseEn: 'God created mankind in the finest of proportions.',
        intransitiveOrBaseDe: 'Gott erschuf den Menschen in vollkommener Gestalt.',
        causativeOrDerivedAr: 'خُلِقَ الإِنْسَانُ ضَعِيفاً لِيَفْتَقِرَ إِلَى رَبِّهِ.',
        causativeOrDerivedEn: 'Man was created weak so as to remain reliant upon his Lord.',
        causativeOrDerivedDe: 'Der Mensch wurde schwach erschaffen (Vorgangspassiv).',
        morphologicalMechanismAr: 'تَغْيِيرُ بِنْيَةِ الفِعْلِ (ضَمُّ أَوَّلِهِ وَكَسْرُ مَا قَبْلَ آخِرِهِ) لِحَذْفِ الفَاعِلِ لِلْعِلْمِ بِهِ عِلْماً يَقِينِيّاً.',
        morphologicalMechanismEn: 'Agent omission through passive morphology highlighting inherent human vulnerability.',
        morphologicalMechanismDe: 'Klassisches Vorgangspassiv mit "werden" zur Fokussierung auf die geschaffene Natur.',
        semanticRoleDistributionAr: 'حَذْفُ الفَاعِلِ تَعْظِيماً وَلِأَنَّ الخَالِقَ مَعْلُومٌ لَا يَخْفَى عَلَى ذِي بَصِيرَةٍ.',
        transitivityValencyScore: 1.0,
      ),
    ];

    _state = _state.copyWith(
      pairs: defaultPairs,
      selectedPairId: defaultPairs.first.id,
    );
  }

  void selectPattern(TransitivityPattern pattern) {
    final filtered = _state.pairs.where((p) => p.pattern == pattern).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedPairId;
    _state = _state.copyWith(
      selectedPattern: pattern,
      selectedPairId: nextId,
    );
    notifyListeners();
  }

  void selectPair(String id) {
    _state = _state.copyWith(selectedPairId: id);
    notifyListeners();
  }

  void toggleValencyAnalysis() {
    _state = _state.copyWith(showValencyAnalysis: !_state.showValencyAnalysis);
    notifyListeners();
  }

  void toggleMorphologicalDerivation() {
    _state = _state.copyWith(showMorphologicalDerivation: !_state.showMorphologicalDerivation);
    notifyListeners();
  }
}
