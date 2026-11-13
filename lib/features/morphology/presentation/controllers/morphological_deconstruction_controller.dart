import 'package:flutter/foundation.dart';

/// Target language for morphological study
enum MorphologicalLanguage {
  arabic(
    nameAr: 'العَرَبِيَّةُ (الجُذُورُ وَالمِيزَانُ الصَّرْفِيُّ)',
    nameDe: 'Arabische Wurzel- & Formlehre (Awzan)',
    nameEn: 'Arabic Roots & Morphological Patterns',
  ),
  german(
    nameAr: 'الأَلْمَانِيَّةُ (تَفْكِيكُ الكَلِمَاتِ المُرَكَّبَةِ Komposita)',
    nameDe: 'Deutsche Komposita-Zerlegung & Wortbildung',
    nameEn: 'German Compound Deconstruction (Komposita)',
  ),
  english(
    nameAr: 'الإِنْجِلِيزِيَّةُ (السَّوَابِقُ وَاللَّوَاحِقُ Affixation)',
    nameDe: 'Englische Präfix- & Suffixanalyse',
    nameEn: 'English Morphological Affixation',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;

  const MorphologicalLanguage({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
  });
}

/// A Morphological Segment / Building Block
class MorphologicalSegment {
  final String segmentText;
  final String grammaticalLabelAr;
  final String grammaticalLabelDe;
  final String grammaticalLabelEn;
  final bool isCoreRoot;
  final int colorHex;

  const MorphologicalSegment({
    required this.segmentText,
    required this.grammaticalLabelAr,
    required this.grammaticalLabelDe,
    required this.grammaticalLabelEn,
    required this.isCoreRoot,
    required this.colorHex,
  });
}

/// Trilingual Morphological Word Entity
class MorphologicalWord {
  final String id;
  final MorphologicalLanguage language;
  final String fullWord;
  final String meaningAr;
  final String meaningDe;
  final String meaningEn;
  final String? rootString; // e.g. "ن-ظ-ر" or "schreiben"
  final String? patternName; // e.g. "افْتِعَال" or "Nomen + Fugenelement + Nomen"
  final List<MorphologicalSegment> segments;
  final String morphologicalRuleExplanationAr;

  const MorphologicalWord({
    required this.id,
    required this.language,
    required this.fullWord,
    required this.meaningAr,
    required this.meaningDe,
    required this.meaningEn,
    required this.rootString,
    required this.patternName,
    required this.segments,
    required this.morphologicalRuleExplanationAr,
  });

  static const List<MorphologicalWord> catalog = [
    // Arabic Root & Pattern Examples
    MorphologicalWord(
      id: 'ar_intithar',
      language: MorphologicalLanguage.arabic,
      fullWord: 'انْتِظَارٌ',
      meaningAr: 'تَرَقُّبٌ وَتَمَهُّلٌ',
      meaningDe: 'Das Warten / Erwartung',
      meaningEn: 'Waiting / Expectation',
      rootString: 'ن - ظ - ر',
      patternName: 'افْتِعَالٌ (Ifte\'al)',
      segments: [
        MorphologicalSegment(segmentText: 'اِ', grammaticalLabelAr: 'هَمْزَةُ وَصْلٍ زَائِدَةٌ', grammaticalLabelDe: 'Präfix (Alif)', grammaticalLabelEn: 'Prefix Alif', isCoreRoot: false, colorHex: 0xFF64748B),
        MorphologicalSegment(segmentText: 'نْ', grammaticalLabelAr: 'فَاءُ الفِعْلِ (الجَذْرُ: ن)', grammaticalLabelDe: '1. Radikal (N)', grammaticalLabelEn: '1st Radical (N)', isCoreRoot: true, colorHex: 0xFF059669),
        MorphologicalSegment(segmentText: 'تِ', grammaticalLabelAr: 'تَاءُ الافْتِعَالِ الزَّائِدَةُ', grammaticalLabelDe: 'Infix (T)', grammaticalLabelEn: 'Infix T', isCoreRoot: false, colorHex: 0xFF3B82F6),
        MorphologicalSegment(segmentText: 'ظَ', grammaticalLabelAr: 'عَيْنُ الفِعْلِ (الجَذْرُ: ظ)', grammaticalLabelDe: '2. Radikal (Z)', grammaticalLabelEn: '2nd Radical (Z)', isCoreRoot: true, colorHex: 0xFF059669),
        MorphologicalSegment(segmentText: 'ا', grammaticalLabelAr: 'أَلِفُ المَدِّ الزَّائِدَةُ', grammaticalLabelDe: 'Langer Vokal (a)', grammaticalLabelEn: 'Long Vowel a', isCoreRoot: false, colorHex: 0xFFF59E0B),
        MorphologicalSegment(segmentText: 'رٌ', grammaticalLabelAr: 'لامُ الفِعْلِ (الجَذْرُ: ر)', grammaticalLabelDe: '3. Radikal (R)', grammaticalLabelEn: '3rd Radical (R)', isCoreRoot: true, colorHex: 0xFF059669),
      ],
      morphologicalRuleExplanationAr: 'مَصْدَرٌ عَلَى وَزْنِ (افْتِعَال) مِنْ جَذْرِ (ن-ظ-ر)؛ دَخَلَتْ عَلَيْهِ هَمْزَةُ الوَصْلِ وَتَاءُ الافْتِعَالِ وَأَلِفُ المَدِّ، مَعَ ثَبَاتِ حُرُوفِ الجَذْرِ الثَّلاثَةِ.',
    ),
    MorphologicalWord(
      id: 'ar_istikshaf',
      language: MorphologicalLanguage.arabic,
      fullWord: 'اسْتِكْشَافٌ',
      meaningAr: 'طَلَبُ كَشْفِ المَجْهُولِ وَالمَعْرِفَةِ',
      meaningDe: 'Erkundung / Erforschung',
      meaningEn: 'Exploration / Discovery',
      rootString: 'ك - ش - ف',
      patternName: 'اسْتِفْعَالٌ (Istif\'al)',
      segments: [
        MorphologicalSegment(segmentText: 'اسْتِ', grammaticalLabelAr: 'زِيَادَةُ الاسْتِفْعَالِ (لِلطَّلَبِ)', grammaticalLabelDe: 'Präfix (Isti-)', grammaticalLabelEn: 'Prefix Isti- (Request)', isCoreRoot: false, colorHex: 0xFF6366F1),
        MorphologicalSegment(segmentText: 'كْ', grammaticalLabelAr: 'فَاءُ الفِعْلِ (الجَذْرُ: ك)', grammaticalLabelDe: '1. Radikal (K)', grammaticalLabelEn: '1st Radical (K)', isCoreRoot: true, colorHex: 0xFF059669),
        MorphologicalSegment(segmentText: 'شَ', grammaticalLabelAr: 'عَيْنُ الفِعْلِ (الجَذْرُ: ش)', grammaticalLabelDe: '2. Radikal (Sh)', grammaticalLabelEn: '2nd Radical (Sh)', isCoreRoot: true, colorHex: 0xFF059669),
        MorphologicalSegment(segmentText: 'ا', grammaticalLabelAr: 'أَلِفُ المَصْدَرِ', grammaticalLabelDe: 'Vokaldehnung', grammaticalLabelEn: 'Vowel Lengthening', isCoreRoot: false, colorHex: 0xFFF59E0B),
        MorphologicalSegment(segmentText: 'فٌ', grammaticalLabelAr: 'لامُ الفِعْلِ (الجَذْرُ: ف)', grammaticalLabelDe: '3. Radikal (F)', grammaticalLabelEn: '3rd Radical (F)', isCoreRoot: true, colorHex: 0xFF059669),
      ],
      morphologicalRuleExplanationAr: 'وَزْنُ (اسْتِفْعَال) يُفِيدُ طَلَبَ الفِعْلِ أَوْ الصَّيْرُورَةَ، وَأَصْلُهُ مِنَ الجَذْرِ (ك-ش-ف) بِمَعْنَى رَفْعِ الحِجَابِ.',
    ),

    // German Compound Deconstruction Examples
    MorphologicalWord(
      id: 'de_wissenschaftsgeschichte',
      language: MorphologicalLanguage.german,
      fullWord: 'Wissenschaftsgeschichte',
      meaningAr: 'تَارِيخُ العُلُومِ',
      meaningDe: 'Geschichte der Wissenschaften',
      meaningEn: 'History of Science',
      rootString: 'wissen + schaffen + geschehen',
      patternName: 'Kompositum (Nomen + Fugenelement + Nomen)',
      segments: [
        MorphologicalSegment(segmentText: 'Wissen', grammaticalLabelAr: 'كَلِمَةٌ أَسَاسِيَّةٌ: المَعْرِفَةُ (Knowledge)', grammaticalLabelDe: 'Grundstamm (Wissen)', grammaticalLabelEn: 'Base Stem (Knowledge)', isCoreRoot: true, colorHex: 0xFF0284C7),
        MorphologicalSegment(segmentText: 'schaft', grammaticalLabelAr: 'لاحِقَةُ صِيَاغَةِ الأَسْمَاءِ (-ship / -craft)', grammaticalLabelDe: 'Substantivierungs-Suffix', grammaticalLabelEn: 'Noun Suffix (-ship)', isCoreRoot: false, colorHex: 0xFF8B5CF6),
        MorphologicalSegment(segmentText: 's', grammaticalLabelAr: 'حَرْفُ رَبْطٍ صَوْتِيٌّ (Fugenelement)', grammaticalLabelDe: 'Fugen-s', grammaticalLabelEn: 'Linking Element (-s-)', isCoreRoot: false, colorHex: 0xFFE11D48),
        MorphologicalSegment(segmentText: 'Geschichte', grammaticalLabelAr: 'كَلِمَةُ الرَّأْسِ الرَّئِيسِيَّةُ: التَّارِيخُ (History)', grammaticalLabelDe: 'Grundwort (Hauptnomen)', grammaticalLabelEn: 'Head Noun (History)', isCoreRoot: true, colorHex: 0xFFD97706),
      ],
      morphologicalRuleExplanationAr: 'مُرَكَّبٌ اسْمِيٌّ أَلْمَانِيٌّ (Kompositum): تُحَدِّدُ كَلِمَةُ الرَّأْسِ فِي النِّهَايَةِ (Geschichte) نَوْعَ الكَلِمَةِ وَجِنْسَهَا (die Geschichte)، وَتَقُومُ (Wissenschaft) بِتَخْصِيصِهَا مَعَ إِضَافَةِ حَرْفِ الوَصْلِ (s).',
    ),
    MorphologicalWord(
      id: 'de_lichtbrechung',
      language: MorphologicalLanguage.german,
      fullWord: 'Lichtbrechung',
      meaningAr: 'انْكِسَارُ الضَّوْءِ (Alhazen)',
      meaningDe: 'Refraktion des Lichts',
      meaningEn: 'Light Refraction',
      rootString: 'Licht + brechen',
      patternName: 'Nomen + Verbableitung (-ung)',
      segments: [
        MorphologicalSegment(segmentText: 'Licht', grammaticalLabelAr: 'المُحَدِّدُ: الضَّوْءُ (Light)', grammaticalLabelDe: 'Bestimmungswort (Licht)', grammaticalLabelEn: 'Modifier (Light)', isCoreRoot: true, colorHex: 0xFF0284C7),
        MorphologicalSegment(segmentText: 'brech', grammaticalLabelAr: 'جَذْرُ الفِعْلِ: كَسَرَ (to break)', grammaticalLabelDe: 'Verbstamm (brechen)', grammaticalLabelEn: 'Verb Root (to break)', isCoreRoot: true, colorHex: 0xFF059669),
        MorphologicalSegment(segmentText: 'ung', grammaticalLabelAr: 'لاحِقَةُ المَصْدَرِ (-ing / -tion)', grammaticalLabelDe: 'Nominalisierungs-Suffix', grammaticalLabelEn: 'Nominal Suffix (-tion)', isCoreRoot: false, colorHex: 0xFF8B5CF6),
      ],
      morphologicalRuleExplanationAr: 'تَرْكِيبٌ يَبْدَأُ بِـ (Licht) لِتَخْصِيصِ كَلِمَةِ (Brechung) المَأْخُوذَةِ مِنَ الفِعْلِ (brechen) بِإِضَافَةِ لاحِقَةِ التَّأْنِيثِ وَالمَصْدَرِيَّةِ (-ung).',
    ),

    // English Morphological Affixation Examples
    MorphologicalWord(
      id: 'en_deconstruction',
      language: MorphologicalLanguage.english,
      fullWord: 'Deconstruction',
      meaningAr: 'التَّفْكِيكُ وَإِعَادَةُ التَّرْكِيبِ',
      meaningDe: 'Dekonstruktion',
      meaningEn: 'Deconstruction',
      rootString: 'struct (Latin: to build)',
      patternName: 'Prefix + Latin Root + Suffix',
      segments: [
        MorphologicalSegment(segmentText: 'De', grammaticalLabelAr: 'سَابِقَةٌ لِعَكْسِ المَعْنَى أَوْ النَّزْعِ', grammaticalLabelDe: 'Präfix (Umkehrung)', grammaticalLabelEn: 'Prefix (Reverse / Remove)', isCoreRoot: false, colorHex: 0xFF6366F1),
        MorphologicalSegment(segmentText: 'con', grammaticalLabelAr: 'سَابِقَةٌ بِمَعْنَى مَعاً أَوْ تَمَاماً', grammaticalLabelDe: 'Intensivierungs-Präfix', grammaticalLabelEn: 'Prefix (Together / Fully)', isCoreRoot: false, colorHex: 0xFF3B82F6),
        MorphologicalSegment(segmentText: 'struct', grammaticalLabelAr: 'الجَذْرُ اللاتِينِيُّ: بَنَى (to build)', grammaticalLabelDe: 'Lateinischer Wortstamm', grammaticalLabelEn: 'Latin Root (to build)', isCoreRoot: true, colorHex: 0xFF059669),
        MorphologicalSegment(segmentText: 'ion', grammaticalLabelAr: 'لاحِقَةُ صِيَاغَةِ المَصْدَرِ الاسْمِيِّ', grammaticalLabelDe: 'Substantiv-Suffix', grammaticalLabelEn: 'Noun Suffix (Action/Process)', isCoreRoot: false, colorHex: 0xFF8B5CF6),
      ],
      morphologicalRuleExplanationAr: 'كَلِمَةٌ أَكَادِيمِيَّةٌ تَتَكَوَّنُ مِنْ سَابِقَتَيْنِ (De + con) مَعَ الجَذْرِ اللاتِينِيِّ (struct) وَلاحِقَةِ المَصْدَرِ (ion).',
    ),
  ];
}

/// State representation for Morphological Deconstruction Studio
class MorphologicalDeconstructionState {
  final MorphologicalLanguage selectedLanguage;
  final MorphologicalWord selectedWord;
  final int? highlightedSegmentIndex;
  final bool showRootHighlightOnly;
  final bool isAssemblyChallengeActive;
  final List<String> shuffledSegments;
  final bool challengeSolved;

  const MorphologicalDeconstructionState({
    required this.selectedLanguage,
    required this.selectedWord,
    required this.highlightedSegmentIndex,
    required this.showRootHighlightOnly,
    required this.isAssemblyChallengeActive,
    required this.shuffledSegments,
    required this.challengeSolved,
  });

  factory MorphologicalDeconstructionState.initial() {
    final first = MorphologicalWord.catalog.first;
    return MorphologicalDeconstructionState(
      selectedLanguage: MorphologicalLanguage.arabic,
      selectedWord: first,
      highlightedSegmentIndex: 1, // point to 1st radical
      showRootHighlightOnly: false,
      isAssemblyChallengeActive: false,
      shuffledSegments: const ['تِ', 'نْ', 'اِ', 'ا', 'ظَ', 'رٌ'],
      challengeSolved: false,
    );
  }

  MorphologicalDeconstructionState copyWith({
    MorphologicalLanguage? selectedLanguage,
    MorphologicalWord? selectedWord,
    int? highlightedSegmentIndex,
    bool? showRootHighlightOnly,
    bool? isAssemblyChallengeActive,
    List<String>? shuffledSegments,
    bool? challengeSolved,
  }) {
    return MorphologicalDeconstructionState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedWord: selectedWord ?? this.selectedWord,
      highlightedSegmentIndex:
          highlightedSegmentIndex ?? this.highlightedSegmentIndex,
      showRootHighlightOnly:
          showRootHighlightOnly ?? this.showRootHighlightOnly,
      isAssemblyChallengeActive:
          isAssemblyChallengeActive ?? this.isAssemblyChallengeActive,
      shuffledSegments: shuffledSegments ?? this.shuffledSegments,
      challengeSolved: challengeSolved ?? this.challengeSolved,
    );
  }
}

/// Controller managing Morphological Root Extraction and Compound Deconstruction
class MorphologicalDeconstructionController extends ChangeNotifier {
  MorphologicalDeconstructionState _state =
      MorphologicalDeconstructionState.initial();

  MorphologicalDeconstructionState get state => _state;

  void setLanguage(MorphologicalLanguage lang) {
    final available = MorphologicalWord.catalog
        .where((w) => w.language == lang)
        .toList();
    final first = available.isNotEmpty ? available.first : MorphologicalWord.catalog.first;
    final segments = first.segments.map((s) => s.segmentText).toList()..shuffle();

    _state = _state.copyWith(
      selectedLanguage: lang,
      selectedWord: first,
      highlightedSegmentIndex: null,
      isAssemblyChallengeActive: false,
      shuffledSegments: segments,
      challengeSolved: false,
    );
    notifyListeners();
  }

  void selectWord(MorphologicalWord word) {
    final segments = word.segments.map((s) => s.segmentText).toList()..shuffle();
    _state = _state.copyWith(
      selectedWord: word,
      selectedLanguage: word.language,
      highlightedSegmentIndex: null,
      challengeSolved: false,
      shuffledSegments: segments,
    );
    notifyListeners();
  }

  void highlightSegment(int? index) {
    _state = _state.copyWith(highlightedSegmentIndex: index);
    notifyListeners();
  }

  void toggleRootHighlightOnly() {
    _state = _state.copyWith(
      showRootHighlightOnly: !_state.showRootHighlightOnly,
    );
    notifyListeners();
  }

  void toggleChallenge() {
    _state = _state.copyWith(
      isAssemblyChallengeActive: !_state.isAssemblyChallengeActive,
      challengeSolved: false,
    );
    notifyListeners();
  }

  /// Reorder segments during morphological assembly challenge
  void reorderSegments(int oldIndex, int newIndex) {
    final list = List<String>.from(_state.shuffledSegments);
    if (newIndex > oldIndex) newIndex--;
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);

    // Check if matches original target order
    final targetOrder = _state.selectedWord.segments.map((s) => s.segmentText).toList();
    bool solved = list.length == targetOrder.length;
    if (solved) {
      for (int i = 0; i < list.length; i++) {
        if (list[i] != targetOrder[i]) {
          solved = false;
          break;
        }
      }
    }

    _state = _state.copyWith(
      shuffledSegments: list,
      challengeSolved: solved,
    );
    notifyListeners();
  }

  void reset() {
    _state = MorphologicalDeconstructionState.initial();
    notifyListeners();
  }
}
