import 'package:flutter/foundation.dart';

/// Target language for anaphora resolution
enum AnaphoraLanguage {
  arabic(
    nameAr: 'العَرَبِيَّةُ (عَوْدُ الضَّمِيرِ وَصِلَةُ المَوْصُولِ)',
    nameDe: 'Arabische Pronominalbezüge & Relativsätze',
    nameEn: 'Arabic Clitic Anaphora & Relative Coreference',
  ),
  german(
    nameAr: 'الأَلْمَانِيَّةُ (النُّعُوتُ الفِعْلِيَّةُ المَمْدُودَةُ Partizip I/II)',
    nameDe: 'Erweiterte Partizipialattribute & Relativpronomen',
    nameEn: 'German Extended Participles & Relative Pronouns',
  ),
  english(
    nameAr: 'الإِنْجِلِيزِيَّةُ (Complex Relative Coreference)',
    nameDe: 'Englische Relativsatz- & Partizipialauflösung',
    nameEn: 'English Relative & Participial Coreference',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;

  const AnaphoraLanguage({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
  });
}

/// A token entity in a complex sentence with anaphoric pointer metadata
class AnaphoraToken {
  final int index;
  final String wordText;
  final bool isPronounOrParticiple;
  final int? antecedentTokenIndex; // Index of the antecedent noun it refers to
  final String? agreementExplanationAr; // e.g. "يعود على ابن الهيثم (مفرد مذكر غائب)"
  final String? grammaticalRoleAr; // e.g. "ضمير متصل في محل جر مضاف إليه"
  final int highlightColorHex;

  const AnaphoraToken({
    required this.index,
    required this.wordText,
    required this.isPronounOrParticiple,
    required this.antecedentTokenIndex,
    required this.agreementExplanationAr,
    required this.grammaticalRoleAr,
    required this.highlightColorHex,
  });
}

/// An authentic complex passage entity with anaphoric and participial resolution
class ComplexPassage {
  final String id;
  final AnaphoraLanguage language;
  final String titleAr;
  final String fullTextAr;
  final String fullTextDe;
  final String fullTextEn;
  final List<AnaphoraToken> tokens;
  final String? unfoldedAlternativeText; // For German: Unfolding extended participle into relative clause
  final String syntacticPedagogyExplanationAr;

  const ComplexPassage({
    required this.id,
    required this.language,
    required this.titleAr,
    required this.fullTextAr,
    required this.fullTextDe,
    required this.fullTextEn,
    required this.tokens,
    required this.unfoldedAlternativeText,
    required this.syntacticPedagogyExplanationAr,
  });

  static const List<ComplexPassage> passages = [
    // 1. Classical Arabic: Ibn al-Haytham manuscript excerpt with chained clitics
    ComplexPassage(
      id: 'ar_alhaytham_manazir',
      language: AnaphoraLanguage.arabic,
      titleAr: 'تَجْرِبَةُ ابْنِ الهَيْثَمِ فِي مَخْطُوطِ المَنَاظِرِ',
      fullTextAr: 'وَضَعَ ابْنُ الْهَيْثَمِ أُسْطُوَانَتَهُ الزُّجَاجِيَّةَ وَمَلَأَهَا بِمَاءٍ صَافٍ لِيَرْصُدَ بِهَا انْعِكَاسَ الشُّعَاعِ بَعْدَ نَفَاذِهِ مِنْهَا.',
      fullTextDe: 'Alhazen platzierte seinen Glaszylinder und füllte ihn mit reinem Wasser, um daran die Reflexion des Strahls nach seinem Durchtritt zu beobachten.',
      fullTextEn: 'Ibn al-Haytham positioned his glass cylinder and filled it with clear water to observe with it the ray’s reflection after its passage through it.',
      tokens: [
        AnaphoraToken(index: 0, wordText: 'وَضَعَ', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 1, wordText: 'ابْنُ الْهَيْثَمِ', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: 'المَرْجِعُ الأَصْلِيُّ (مُفْرَدٌ مُذَكَّرٌ)', grammaticalRoleAr: 'فاعل مرفوع', highlightColorHex: 0xFF22C55E),
        AnaphoraToken(index: 2, wordText: 'أُسْطُوَانَتَهُ', isPronounOrParticiple: true, antecedentTokenIndex: 1, agreementExplanationAr: 'الهاءُ تَعُودُ عَلَى (ابن الهيثم)', grammaticalRoleAr: 'ضمير متصل في محل جر مضاف إليه', highlightColorHex: 0xFF22C55E),
        AnaphoraToken(index: 3, wordText: 'الزُّجَاجِيَّةَ', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: 'مَرْجِعٌ مُؤَنَّثٌ (الأسطوانة)', grammaticalRoleAr: 'نعت منصوب', highlightColorHex: 0xFF3B82F6),
        AnaphoraToken(index: 4, wordText: 'وَمَلَأَهَا', isPronounOrParticiple: true, antecedentTokenIndex: 3, agreementExplanationAr: 'ها تَعُودُ عَلَى (الأسطوانة الزجاجية)', grammaticalRoleAr: 'ضمير متصل في محل نصب مفعول به', highlightColorHex: 0xFF3B82F6),
        AnaphoraToken(index: 5, wordText: 'بِمَاءٍ', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 6, wordText: 'صَافٍ', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 7, wordText: 'لِيَرْصُدَ', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 8, wordText: 'بِهَا', isPronounOrParticiple: true, antecedentTokenIndex: 3, agreementExplanationAr: 'ها تَعُودُ عَلَى (الأسطوانة الزجاجية)', grammaticalRoleAr: 'ضمير متصل في محل جر بحرف الجر', highlightColorHex: 0xFF3B82F6),
        AnaphoraToken(index: 9, wordText: 'انْعِكَاسَ', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 10, wordText: 'الشُّعَاعِ', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: 'مَرْجِعٌ مُفْرَدٌ مُذَكَّرٌ (الشعاع)', grammaticalRoleAr: 'مضاف إليه مجرور', highlightColorHex: 0xFFF59E0B),
        AnaphoraToken(index: 11, wordText: 'بَعْدَ', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 12, wordText: 'نَفَاذِهِ', isPronounOrParticiple: true, antecedentTokenIndex: 10, agreementExplanationAr: 'الهاءُ تَعُودُ عَلَى (الشعاع)', grammaticalRoleAr: 'ضمير متصل في محل جر مضاف إليه', highlightColorHex: 0xFFF59E0B),
        AnaphoraToken(index: 13, wordText: 'مِنْهَا.', isPronounOrParticiple: true, antecedentTokenIndex: 3, agreementExplanationAr: 'ها تَعُودُ عَلَى (الأسطوانة)', grammaticalRoleAr: 'ضمير متصل في محل جر', highlightColorHex: 0xFF3B82F6),
      ],
      unfoldedAlternativeText: null,
      syntacticPedagogyExplanationAr: 'تَتَشَابَكُ الضَّمَائِرُ المُتَّصِلَةُ فِي هَذِهِ الجُمْلَةِ بَيْنَ ثَلاثَةِ مَرَاجِعَ: (ابن الهيثم -> ـهُ)، (الأسطوانة -> ـهَا)، وَ(الشعاع -> ـهِ). يَحْسِمُ السِّيَاقُ وَالتَّذْكِيرُ وَالتَّأْنِيثُ عَوْدَ كُلِّ ضَمِيرٍ إِلَى مَرْجِعِهِ الأَصْلِيِّ دُونَ لَبْسٍ.',
    ),

    // 2. German Extended Participial Attribute (Erweitertes Partizip II)
    ComplexPassage(
      id: 'de_partizip_alhaytham',
      language: AnaphoraLanguage.german,
      titleAr: 'النَّعْتُ الفِعْلِيُّ المَمْدُودُ (Das erweiterte Partizipialattribut)',
      fullTextAr: 'الكِتَابُ المَكْتُوبُ مِن قِبَلِ ابْنِ الهَيْثَمِ فِي القَاهِرَةِ أَحْدَثَ ثَوْرَةً فِي عِلْمِ البَصَرِيَّاتِ.',
      fullTextDe: 'Das von Alhazen in Kairo verfasste Buch revolutionierte die Optik.',
      fullTextEn: 'The book authored by Alhazen in Cairo revolutionized optics.',
      tokens: [
        AnaphoraToken(index: 0, wordText: 'Das', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: 'أَدَاةُ تَعْرِيفٍ لِلاسْمِ الرَّئِيسِيِّ (Buch)', grammaticalRoleAr: 'Bestimmter Artikel', highlightColorHex: 0xFF0284C7),
        AnaphoraToken(index: 1, wordText: 'von', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 2, wordText: 'Alhazen', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 3, wordText: 'in', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 4, wordText: 'Kairo', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 5, wordText: 'verfasste', isPronounOrParticiple: true, antecedentTokenIndex: 6, agreementExplanationAr: 'اسم مفعول ممدود يصف (Buch) البعيد', grammaticalRoleAr: 'Erweitertes Partizip II als Adjektiv', highlightColorHex: 0xFFEC4899),
        AnaphoraToken(index: 6, wordText: 'Buch', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: 'المَوْصُوفُ الرَّئِيسِيُّ (Bezugsnomen)', grammaticalRoleAr: 'Subjektnomen (Neutrum)', highlightColorHex: 0xFF0284C7),
        AnaphoraToken(index: 7, wordText: 'revolutionierte', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 8, wordText: 'die', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
        AnaphoraToken(index: 9, wordText: 'Optik.', isPronounOrParticiple: false, antecedentTokenIndex: null, agreementExplanationAr: null, grammaticalRoleAr: null, highlightColorHex: 0xFF94A3B8),
      ],
      unfoldedAlternativeText: 'Das Buch, das von Alhazen in Kairo verfasst wurde, revolutionierte die Optik.',
      syntacticPedagogyExplanationAr: 'فِي الأَلْمَانِيَّةِ الأَكَادِيمِيَّةِ يُوضَعُ اسمُ المَفْعُولِ (verfasste) بَعْدَ جَمِيعِ شِبْهِ الجُمَلِ وَقَبْلَ المَوْصُوفِ مُبَاشَرَةً (Buch). عِنْدَ التَّفْكِيكِ، يَتَحَوَّلُ النَّعْتُ المَمْدُودُ إِلَى جُمْلَةِ صِلَةٍ مَوْصُولَةٍ سَهْلَةِ الفَهْمِ: (Das Buch, das verfasst wurde...).',
    ),
  ];
}

/// State of the Anaphora Resolution Studio
class AnaphoraResolutionState {
  final AnaphoraLanguage selectedLanguage;
  final ComplexPassage selectedPassage;
  final int? activeSelectedTokenIndex; // Token currently clicked by user
  final bool isUnfoldedViewActive; // For German: true = Relativsatz, false = Partizipial
  final int? quizTestedTokenIndex;
  final bool? lastQuizSuccess;

  const AnaphoraResolutionState({
    required this.selectedLanguage,
    required this.selectedPassage,
    required this.activeSelectedTokenIndex,
    required this.isUnfoldedViewActive,
    required this.quizTestedTokenIndex,
    required this.lastQuizSuccess,
  });

  factory AnaphoraResolutionState.initial() {
    final first = ComplexPassage.passages.first;
    return AnaphoraResolutionState(
      selectedLanguage: AnaphoraLanguage.arabic,
      selectedPassage: first,
      activeSelectedTokenIndex: 4, // 'وملأها' highlighting
      isUnfoldedViewActive: false,
      quizTestedTokenIndex: null,
      lastQuizSuccess: null,
    );
  }

  AnaphoraToken? get activeToken {
    if (activeSelectedTokenIndex == null) return null;
    if (activeSelectedTokenIndex! >= 0 &&
        activeSelectedTokenIndex! < selectedPassage.tokens.length) {
      return selectedPassage.tokens[activeSelectedTokenIndex!];
    }
    return null;
  }

  AnaphoraToken? get activeAntecedent {
    final token = activeToken;
    if (token == null || token.antecedentTokenIndex == null) return null;
    return selectedPassage.tokens[token.antecedentTokenIndex!];
  }

  AnaphoraResolutionState copyWith({
    AnaphoraLanguage? selectedLanguage,
    ComplexPassage? selectedPassage,
    int? activeSelectedTokenIndex,
    bool? isUnfoldedViewActive,
    int? quizTestedTokenIndex,
    bool? lastQuizSuccess,
  }) {
    return AnaphoraResolutionState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedPassage: selectedPassage ?? this.selectedPassage,
      activeSelectedTokenIndex:
          activeSelectedTokenIndex ?? this.activeSelectedTokenIndex,
      isUnfoldedViewActive:
          isUnfoldedViewActive ?? this.isUnfoldedViewActive,
      quizTestedTokenIndex:
          quizTestedTokenIndex ?? this.quizTestedTokenIndex,
      lastQuizSuccess: lastQuizSuccess ?? this.lastQuizSuccess,
    );
  }
}

/// Controller managing Anaphora Resolution & Clause Dissection
class AnaphoraResolutionController extends ChangeNotifier {
  AnaphoraResolutionState _state = AnaphoraResolutionState.initial();

  AnaphoraResolutionState get state => _state;

  void setLanguage(AnaphoraLanguage lang) {
    final available = ComplexPassage.passages
        .where((p) => p.language == lang)
        .toList();
    final first = available.isNotEmpty ? available.first : ComplexPassage.passages.first;

    _state = _state.copyWith(
      selectedLanguage: lang,
      selectedPassage: first,
      activeSelectedTokenIndex: null,
      isUnfoldedViewActive: false,
      lastQuizSuccess: null,
    );
    notifyListeners();
  }

  void selectPassage(ComplexPassage passage) {
    _state = _state.copyWith(
      selectedPassage: passage,
      selectedLanguage: passage.language,
      activeSelectedTokenIndex: null,
      isUnfoldedViewActive: false,
      lastQuizSuccess: null,
    );
    notifyListeners();
  }

  void selectToken(int index) {
    _state = _state.copyWith(activeSelectedTokenIndex: index);
    notifyListeners();
  }

  void toggleUnfoldedView() {
    _state = _state.copyWith(
      isUnfoldedViewActive: !_state.isUnfoldedViewActive,
    );
    notifyListeners();
  }

  void reset() {
    _state = AnaphoraResolutionState.initial();
    notifyListeners();
  }
}
