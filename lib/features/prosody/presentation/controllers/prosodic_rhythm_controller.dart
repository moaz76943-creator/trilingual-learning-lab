import 'package:flutter/foundation.dart';

/// Target language for prosodic rhythm analysis
enum ProsodicLanguage {
  arabic(
    nameAr: 'العَرَبِيَّةُ (عِلْمُ العَرُوضِ وَالنَّبْرِ - الفَرَاهِيدِيُّ)',
    nameDe: 'Arabische Metrik & Silbenbetonung (Arud)',
    nameEn: 'Arabic Meter & Syllable Stress (Al-Farahidi)',
  ),
  german(
    nameAr: 'الأَلْمَانِيَّةُ (نَبْرُ الكَلِمَاتِ وَطُولُ الحَرَكَاتِ Wortakzent)',
    nameDe: 'Deutscher Wortakzent & Vokallänge',
    nameEn: 'German Lexical Stress & Vowel Quantity',
  ),
  english(
    nameAr: 'الإِنْجِلِيزِيَّةُ (التَّنْغِيمُ وَالنَّبْرُ النَّوَوِيُّ Intonation)',
    nameDe: 'Englische Intonationskonturen & Satzakzent',
    nameEn: 'English Intonation & Nuclear Pitch Accents',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;

  const ProsodicLanguage({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
  });
}

/// Syllable Weight Classification
enum SyllableWeight {
  light(
    nameAr: 'خَفِيفٌ (CV: حَرَكَةٌ قَصِيرَةٌ)',
    nameDe: 'Leichte Silbe (CV)',
    nameEn: 'Light Syllable (CV)',
    symbol: '∪',
    durationMs: 140,
  ),
  heavy(
    nameAr: 'ثَقِيلٌ (CVC / CVV: مَدٌّ أَوْ سُكُونٌ)',
    nameDe: 'Schwere Silbe (CVC / CVV)',
    nameEn: 'Heavy Syllable (CVC / CVV)',
    symbol: '—',
    durationMs: 260,
  ),
  superHeavy(
    nameAr: 'شَدِيدُ الثِّقَلِ (CVVC: مَدٌّ ثُمَّ سُكُونٌ)',
    nameDe: 'Überschwere Silbe (CVVC)',
    nameEn: 'Super-Heavy Syllable (CVVC)',
    symbol: '‗',
    durationMs: 340,
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final String symbol;
  final int durationMs;

  const SyllableWeight({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.symbol,
    required this.durationMs,
  });
}

/// An individual syllable token within a rhythmic word or phrase
class ProsodicSyllable {
  final String text;
  final SyllableWeight weight;
  final bool isStressed; // Has primary stress (النبر الأساسي)
  final double pitchTargetHz; // Approximate target fundamental frequency (F0)
  final String phoneticStructure; // e.g. "CVC", "CV", "CVV"

  const ProsodicSyllable({
    required this.text,
    required this.weight,
    required this.isStressed,
    required this.pitchTargetHz,
    required this.phoneticStructure,
  });
}

/// Prosodic Word or Metric Verse Item
class ProsodicItem {
  final String id;
  final ProsodicLanguage language;
  final String titleAr;
  final String fullText;
  final String meaningAr;
  final String? meterNameAr; // e.g. "بَحْرُ الكَامِلِ" or "Trochäus"
  final String? metricalFeetAr; // e.g. "مُتَفَاعِلُنْ مُتَفَاعِلُنْ"
  final List<ProsodicSyllable> syllables;
  final String prosodicRuleExplanationAr;

  const ProsodicItem({
    required this.id,
    required this.language,
    required this.titleAr,
    required this.fullText,
    required this.meaningAr,
    required this.meterNameAr,
    required this.metricalFeetAr,
    required this.syllables,
    required this.prosodicRuleExplanationAr,
  });

  static const List<ProsodicItem> catalog = [
    // 1. Classical Arabic: Farahidi Metric Rhythm (بحر الكامل)
    ProsodicItem(
      id: 'ar_mutafaailun',
      language: ProsodicLanguage.arabic,
      titleAr: 'تَفْعِيلَةُ بَحْرِ الكَامِلِ (مُتَفَاعِلُنْ)',
      fullText: 'مُـتَـفَـاعِـلُـنْ',
      meaningAr: 'الوَزْنُ العَرُوضِيُّ الشَّهِيرُ لِبَحْرِ الكَامِلِ',
      meterNameAr: 'بَحْرُ الكَامِلِ (الفَرَاهِيدِيُّ)',
      metricalFeetAr: 'مُـتَـفَـاعِـلُـنْ (∪ ∪ — ∪ —)',
      syllables: [
        ProsodicSyllable(text: 'مُ', weight: SyllableWeight.light, isStressed: false, pitchTargetHz: 130, phoneticStructure: 'CV'),
        ProsodicSyllable(text: 'تَ', weight: SyllableWeight.light, isStressed: false, pitchTargetHz: 135, phoneticStructure: 'CV'),
        ProsodicSyllable(text: 'فَا', weight: SyllableWeight.heavy, isStressed: true, pitchTargetHz: 165, phoneticStructure: 'CVV'),
        ProsodicSyllable(text: 'عِ', weight: SyllableWeight.light, isStressed: false, pitchTargetHz: 130, phoneticStructure: 'CV'),
        ProsodicSyllable(text: 'لُنْ', weight: SyllableWeight.heavy, isStressed: false, pitchTargetHz: 140, phoneticStructure: 'CVC'),
      ],
      prosodicRuleExplanationAr: 'تَتَأَلَّفُ (مُتَفَاعِلُنْ) مِنْ فَاصِلَةٍ صُغْرَى (حَرَكَتَانِ ثُمَّ سُكُون: ∪ ∪ —) وَوَتَدٍ مَجْمُوعٍ (حَرَكَةٌ فَسُكُون: ∪ —). النَّبْرُ العَرَبِيُّ يَقَعُ عَلَى المَقْطَعِ الثَّقِيلِ قَبْلَ الآخِرِ (فَا).',
    ),

    // 2. Classical Arabic: Word Stress Rule (انْكِسَارٌ)
    ProsodicItem(
      id: 'ar_inkisar',
      language: ProsodicLanguage.arabic,
      titleAr: 'قَاعِدَةُ النَّبْرِ العَرَبِيِّ (انْـكِـسَـارٌ)',
      fullText: 'انْـكِـسَـارٌ',
      meaningAr: 'تَحَوُّلُ مَسَارِ الضَّوْءِ (Refraction)',
      meterNameAr: 'المِيزَانُ الصَّرْفِيُّ (انْفِعَالٌ)',
      metricalFeetAr: 'انْ - كِ - سَا - رٌ (— ∪ — —)',
      syllables: [
        ProsodicSyllable(text: 'انْ', weight: SyllableWeight.heavy, isStressed: false, pitchTargetHz: 135, phoneticStructure: 'CVC'),
        ProsodicSyllable(text: 'كِ', weight: SyllableWeight.light, isStressed: false, pitchTargetHz: 130, phoneticStructure: 'CV'),
        ProsodicSyllable(text: 'سَا', weight: SyllableWeight.heavy, isStressed: true, pitchTargetHz: 170, phoneticStructure: 'CVV'),
        ProsodicSyllable(text: 'رٌ', weight: SyllableWeight.heavy, isStressed: false, pitchTargetHz: 135, phoneticStructure: 'CVC'),
      ],
      prosodicRuleExplanationAr: 'قَاعِدَةُ النَّبْرِ فِي الفُصْحَى: إِذَا كَانَ المَقْطَعُ قَبْلَ الأَخِيرِ ثَقِيلاً (سَا = CVV) اسْتَحْوَذَ عَلَى النَّبْرِ الرَّئِيسِيِّ حَتْماً.',
    ),

    // 3. German: Stress-Shift Semantic Contrast (übersetzen)
    ProsodicItem(
      id: 'de_uebersetzen',
      language: ProsodicLanguage.german,
      titleAr: 'انْتِقَالُ النَّبْرِ الدِّلالِيُّ فِي الأَلْمَانِيَّةِ (übersetzen)',
      fullText: 'über-sétz-en',
      meaningAr: 'يُتَرْجِمُ (To translate - untrennbar)',
      meterNameAr: 'Untrennbares Präfixverb',
      metricalFeetAr: 'ü - ber - sétz - en (∪ ∪ — ∪)',
      syllables: [
        ProsodicSyllable(text: 'ü', weight: SyllableWeight.light, isStressed: false, pitchTargetHz: 140, phoneticStructure: 'V'),
        ProsodicSyllable(text: 'ber', weight: SyllableWeight.light, isStressed: false, pitchTargetHz: 135, phoneticStructure: 'CVC'),
        ProsodicSyllable(text: 'sétz', weight: SyllableWeight.heavy, isStressed: true, pitchTargetHz: 175, phoneticStructure: 'CVCC'),
        ProsodicSyllable(text: 'en', weight: SyllableWeight.light, isStressed: false, pitchTargetHz: 130, phoneticStructure: 'VC'),
      ],
      prosodicRuleExplanationAr: 'انْتِقَالُ النَّبْرِ فِي الأَلْمَانِيَّةِ يُغَيِّرُ المَعْنَى جَذْرِيّاً: عِنْدَمَا يَقَعُ النَّبْرُ عَلَى جَذْرِ الفِعْلِ (über-SÉTZen) يَكُونُ الفِعْلُ غَيْرَ مُنْفَصِلٍ وَيَعْنِي التَّرْجَمَةَ، بَيْنَمَا عِنْدَمَا يَقَعُ عَلَى السَّابِقَةِ (ǗBER-setzen) يَعْنِي العُبُورَ بِالقَارِبِ!',
    ),

    // 4. English: Noun vs Verb Stress Shift (prótest vs protést)
    ProsodicItem(
      id: 'en_protest',
      language: ProsodicLanguage.english,
      titleAr: 'تَحَوُّلُ النَّبْرِ بَيْنَ الاسْمِ وَالفِعْلِ (prótest vs protést)',
      fullText: 'pró-test (Noun) vs pro-tést (Verb)',
      meaningAr: 'احْتِجَاجٌ (اسم) مُقَابِلَ يَحْتَجُّ (فعل)',
      meterNameAr: 'Trochaic vs Iambic Stress Shift',
      metricalFeetAr: 'PRÓ-test (— ∪) vs pro-TÉST (∪ —)',
      syllables: [
        ProsodicSyllable(text: 'pró', weight: SyllableWeight.heavy, isStressed: true, pitchTargetHz: 175, phoneticStructure: 'CCV'),
        ProsodicSyllable(text: 'test', weight: SyllableWeight.heavy, isStressed: false, pitchTargetHz: 135, phoneticStructure: 'CVCC'),
      ],
      prosodicRuleExplanationAr: 'فِي الإِنْجِلِيزِيَّةِ يَقَعُ النَّبْرُ عَلَى المَقْطَعِ الأَوَّلِ فِي الأَسْمَاءِ (PRÓ-test: Trochee)، بَيْنَمَا يَنْتَقِلُ إِلَى المَقْطَعِ الثَّانِي فِي الأَفْعَالِ (pro-TÉST: Iamb).',
    ),
  ];
}

/// State representation for Prosodic Rhythm Studio
class ProsodicRhythmState {
  final ProsodicLanguage selectedLanguage;
  final ProsodicItem selectedItem;
  final int activeSyllableIndex;
  final bool isMetronomePlaying;
  final double metronomeBpm; // 40 to 140 BPM
  final bool showPitchContour;

  const ProsodicRhythmState({
    required this.selectedLanguage,
    required this.selectedItem,
    required this.activeSyllableIndex,
    required this.isMetronomePlaying,
    required this.metronomeBpm,
    required this.showPitchContour,
  });

  factory ProsodicRhythmState.initial() {
    final first = ProsodicItem.catalog.first;
    return ProsodicRhythmState(
      selectedLanguage: ProsodicLanguage.arabic,
      selectedItem: first,
      activeSyllableIndex: 2, // 'فَا' stressed syllable
      isMetronomePlaying: true,
      metronomeBpm: 75.0,
      showPitchContour: true,
    );
  }

  ProsodicSyllable get activeSyllable =>
      selectedItem.syllables[activeSyllableIndex];

  /// Total duration of full item sequence in milliseconds
  int get totalDurationMs {
    return selectedItem.syllables.fold(0, (sum, s) => sum + s.weight.durationMs);
  }

  ProsodicRhythmState copyWith({
    ProsodicLanguage? selectedLanguage,
    ProsodicItem? selectedItem,
    int? activeSyllableIndex,
    bool? isMetronomePlaying,
    double? metronomeBpm,
    bool? showPitchContour,
  }) {
    return ProsodicRhythmState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedItem: selectedItem ?? this.selectedItem,
      activeSyllableIndex:
          activeSyllableIndex ?? this.activeSyllableIndex,
      isMetronomePlaying: isMetronomePlaying ?? this.isMetronomePlaying,
      metronomeBpm: metronomeBpm ?? this.metronomeBpm,
      showPitchContour: showPitchContour ?? this.showPitchContour,
    );
  }
}

/// Controller managing Trilingual Prosody, Meter & Rhythm
class ProsodicRhythmController extends ChangeNotifier {
  ProsodicRhythmState _state = ProsodicRhythmState.initial();

  ProsodicRhythmState get state => _state;

  void setLanguage(ProsodicLanguage lang) {
    final available = ProsodicItem.catalog
        .where((i) => i.language == lang)
        .toList();
    final first = available.isNotEmpty ? available.first : ProsodicItem.catalog.first;

    _state = _state.copyWith(
      selectedLanguage: lang,
      selectedItem: first,
      activeSyllableIndex: 0,
    );
    notifyListeners();
  }

  void selectItem(ProsodicItem item) {
    _state = _state.copyWith(
      selectedItem: item,
      selectedLanguage: item.language,
      activeSyllableIndex: 0,
    );
    notifyListeners();
  }

  void selectSyllable(int index) {
    if (index >= 0 && index < _state.selectedItem.syllables.length) {
      _state = _state.copyWith(activeSyllableIndex: index);
      notifyListeners();
    }
  }

  void toggleMetronome() {
    _state = _state.copyWith(isMetronomePlaying: !_state.isMetronomePlaying);
    notifyListeners();
  }

  void setMetronomeBpm(double bpm) {
    final clamped = bpm.clamp(40.0, 160.0);
    _state = _state.copyWith(metronomeBpm: clamped);
    notifyListeners();
  }

  void togglePitchContour() {
    _state = _state.copyWith(showPitchContour: !_state.showPitchContour);
    notifyListeners();
  }

  /// Advance to next syllable in rhythmic metronome sequence
  void advanceSyllableTick() {
    final next = (_state.activeSyllableIndex + 1) % _state.selectedItem.syllables.length;
    _state = _state.copyWith(activeSyllableIndex: next);
    notifyListeners();
  }

  void reset() {
    _state = ProsodicRhythmState.initial();
    notifyListeners();
  }
}
