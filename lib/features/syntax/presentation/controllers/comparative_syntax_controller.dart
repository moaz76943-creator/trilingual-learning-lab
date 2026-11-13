import 'package:flutter/foundation.dart';

/// Syntactic Constituent Role in Comparative Grammar
enum ConstituentRole {
  subject(
    nameAr: 'الفَاعِلُ / المُبْتَدَأُ (المَرْفُوعُ)',
    nameDe: 'Subjekt (Nominativ)',
    nameEn: 'Subject (Nominative)',
    colorHex: 0xFF22C55E, // Green
  ),
  verbFinite(
    nameAr: 'الفِعْلُ الرَّئِيسِيُّ / المُسْنَدُ',
    nameDe: 'Finites Verb (Prädikat)',
    nameEn: 'Finite Verb (Predicate)',
    colorHex: 0xFF3B82F6, // Blue
  ),
  verbInfinite(
    nameAr: 'الفِعْلُ المَزِيدُ / مَصْدَرٌ مُؤَوَّلٌ',
    nameDe: 'Infinites Verb / Partizip (Verbklammer)',
    nameEn: 'Infinite Verb / Participle',
    colorHex: 0xFF6366F1, // Indigo
  ),
  objectDirect(
    nameAr: 'المَفْعُولُ بِهِ المَنْصُوبُ',
    nameDe: 'Akkusativobjekt (Direkt)',
    nameEn: 'Direct Object (Accusative)',
    colorHex: 0xFFF59E0B, // Amber
  ),
  objectIndirect(
    nameAr: 'المَفْعُولُ غَيْرُ المَبَاشِرِ / الجَارُّ وَالمَجْرُورُ',
    nameDe: 'Dativobjekt (Indirekt)',
    nameEn: 'Indirect Object (Dative)',
    colorHex: 0xFFEC4899, // Pink
  ),
  adverbialAdjunct(
    nameAr: 'الظَّرْفُ / الحَالُ / قَيْدُ الزَّمَانِ وَالمَكَانِ',
    nameDe: 'Adverbiale Bestimmung (TeKaMoLo)',
    nameEn: 'Adverbial Adjunct (Time/Manner/Place)',
    colorHex: 0xFF14B8A6, // Teal
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final int colorHex;

  const ConstituentRole({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.colorHex,
  });
}

/// Token constituent in a sentence
class SyntaxToken {
  final String text;
  final ConstituentRole role;
  final String grammaticalCase; // e.g. "Nominativ", "مرفوع بالضمة", "Accusative"
  final String topologicalField; // e.g. "Vorfeld", "Verb-Second", "VSO Head"

  const SyntaxToken({
    required this.text,
    required this.role,
    required this.grammaticalCase,
    required this.topologicalField,
  });
}

/// Trilingual Parallel Sentence with Aligned Syntactic Constituents
class ParallelSentence {
  final String id;
  final String titleAr;
  final List<SyntaxToken> tokensAr; // Arabic (VSO or SVO)
  final List<SyntaxToken> tokensDe; // German (V2 or Nebensatz Verbletzstellung)
  final List<SyntaxToken> tokensEn; // English (SVO)
  final String comparativeInsightAr;

  const ParallelSentence({
    required this.id,
    required this.titleAr,
    required this.tokensAr,
    required this.tokensDe,
    required this.tokensEn,
    required this.comparativeInsightAr,
  });

  static const List<ParallelSentence> corpus = [
    ParallelSentence(
      id: 'optics_experiment',
      titleAr: 'تَجْرِبَةُ انْكِسَارِ الضَّوْءِ (Ibn al-Haytham Experiment)',
      tokensAr: [
        SyntaxToken(text: 'بَرْهَنَ', role: ConstituentRole.verbFinite, grammaticalCase: 'فعل ماضٍ مبني على الفتح', topologicalField: 'رَأْسُ الجُمْلَةِ الفِعْلِيَّةِ (V1)'),
        SyntaxToken(text: 'ابْنُ الْهَيْثَمِ', role: ConstituentRole.subject, grammaticalCase: 'فاعل مرفوع بالضمة', topologicalField: 'الفَاعِلُ الظَّاهِرُ'),
        SyntaxToken(text: 'انْكِسَارَ الضَّوْءِ', role: ConstituentRole.objectDirect, grammaticalCase: 'مفعول به منصوب بالفتحة', topologicalField: 'المَفْعُولُ الصَّرِيحُ'),
        SyntaxToken(text: 'فِي الْبَيْتِ الْمُظْلِمِ', role: ConstituentRole.adverbialAdjunct, grammaticalCase: 'شبه جملة في محل نصب حال', topologicalField: 'قَيْدُ المَكَانِ'),
      ],
      tokensDe: [
        SyntaxToken(text: 'Alhazen', role: ConstituentRole.subject, grammaticalCase: 'Nominativ', topologicalField: 'Vorfeld'),
        SyntaxToken(text: 'bewies', role: ConstituentRole.verbFinite, grammaticalCase: 'Präteritum', topologicalField: 'Linke Satzklammer (V2)'),
        SyntaxToken(text: 'in der Camera Obscura', role: ConstituentRole.adverbialAdjunct, grammaticalCase: 'Lokaladverbiale (Dativ)', topologicalField: 'Mittelfeld (TeKaMoLo)'),
        SyntaxToken(text: 'die Lichtbrechung.', role: ConstituentRole.objectDirect, grammaticalCase: 'Akkusativ', topologicalField: 'Mittelfeld-Ende'),
      ],
      tokensEn: [
        SyntaxToken(text: 'Alhazen', role: ConstituentRole.subject, grammaticalCase: 'Nominative', topologicalField: 'Subject (S)'),
        SyntaxToken(text: 'demonstrated', role: ConstituentRole.verbFinite, grammaticalCase: 'Past Simple', topologicalField: 'Verb (V)'),
        SyntaxToken(text: 'light refraction', role: ConstituentRole.objectDirect, grammaticalCase: 'Accusative', topologicalField: 'Direct Object (O)'),
        SyntaxToken(text: 'in the dark chamber.', role: ConstituentRole.adverbialAdjunct, grammaticalCase: 'Prepositional Phrase', topologicalField: 'Locative Adjunct'),
      ],
      comparativeInsightAr: 'فِي العَرَبِيَّةِ يَتَقَدَّمُ الفِعْلُ (VSO: بَرْهَنَ ابْنُ الهَيْثَمِ)، بَيْنَمَا فِي الأَلْمَانِيَّةِ يَحْتَلُّ الفِعْلُ المَوْقِعَ الثَّانِي دَوْماً (V2: Alhazen bewies)، وَفِي الإِنْجِلِيزِيَّةِ يَلْتَزِمُ التَّرْتِيبُ الصَّارِمُ SVO.',
    ),
    ParallelSentence(
      id: 'subordinate_clause',
      titleAr: 'جُمْلَةُ التَّعْلِيلِ الشَّرْطِيَّةِ (Subordinate Nebensatz)',
      tokensAr: [
        SyntaxToken(text: 'لأَنَّ', role: ConstituentRole.adverbialAdjunct, grammaticalCase: 'أداة تعليل ونصب', topologicalField: 'حَرْفُ التَّعْلِيلِ'),
        SyntaxToken(text: 'الأَرْضَ', role: ConstituentRole.subject, grammaticalCase: 'اسم كأن منصوب بالفتحة', topologicalField: 'مُبْتَدَأُ الصِّلَةِ'),
        SyntaxToken(text: 'كُرَوِيَّةُ الشَّكْلِ', role: ConstituentRole.objectDirect, grammaticalCase: 'خبر لأن مرفوع بالضمة', topologicalField: 'المُسْنَدُ إِلَيْهِ'),
        SyntaxToken(text: 'يَنْحَطُّ الأُفُقُ.', role: ConstituentRole.verbFinite, grammaticalCase: 'جملة فعلية مستأنفة', topologicalField: 'جَوَابُ التَّعْلِيلِ'),
      ],
      tokensDe: [
        SyntaxToken(text: 'Weil', role: ConstituentRole.adverbialAdjunct, grammaticalCase: 'Kausalsubjunktion', topologicalField: 'Einleitung'),
        SyntaxToken(text: 'die Erde', role: ConstituentRole.subject, grammaticalCase: 'Nominativ', topologicalField: 'Mittelfeld-Subjekt'),
        SyntaxToken(text: 'kugelförmig', role: ConstituentRole.objectDirect, grammaticalCase: 'Prädikativum', topologicalField: 'Mittelfeld'),
        SyntaxToken(text: 'ist,', role: ConstituentRole.verbFinite, grammaticalCase: 'Kopulaverb (Verbletzt)', topologicalField: 'Rechte Satzklammer (Verb-End)'),
      ],
      tokensEn: [
        SyntaxToken(text: 'Because', role: ConstituentRole.adverbialAdjunct, grammaticalCase: 'Subordinating Conjunction', topologicalField: 'Clause Marker'),
        SyntaxToken(text: 'the Earth', role: ConstituentRole.subject, grammaticalCase: 'Nominative', topologicalField: 'Subject (S)'),
        SyntaxToken(text: 'is', role: ConstituentRole.verbFinite, grammaticalCase: 'Copula Verb', topologicalField: 'Verb (V)'),
        SyntaxToken(text: 'spherical,', role: ConstituentRole.objectDirect, grammaticalCase: 'Subject Complement', topologicalField: 'Complement (C)'),
      ],
      comparativeInsightAr: 'تَحَوُّلُ مَوْقِعِ الفِعْلِ الأَلْمَانِيِّ: فِي الجُمَلِ الفَرْعِيَّةِ (Nebensatz mit weil) يَنْتَقِلُ الفِعْلُ إِلَى نِهَايَةِ الجُمْلَةِ تَمَاماً (ist) بِخِلافِ العَرَبِيَّةِ وَالإِنْجِلِيزِيَّةِ.',
    ),
  ];
}

/// State representation for Comparative Syntax Studio
class ComparativeSyntaxState {
  final ParallelSentence selectedSentence;
  final ConstituentRole? highlightedRole;
  final bool showSyntaxTree;
  final bool isWordOrderChallengeActive;
  final List<String> shuffledGermanTokens; // For interactive unscrambling challenge
  final bool challengeSolved;

  const ComparativeSyntaxState({
    required this.selectedSentence,
    required this.highlightedRole,
    required this.showSyntaxTree,
    required this.isWordOrderChallengeActive,
    required this.shuffledGermanTokens,
    required this.challengeSolved,
  });

  factory ComparativeSyntaxState.initial() {
    final sentence = ParallelSentence.corpus.first;
    return ComparativeSyntaxState(
      selectedSentence: sentence,
      highlightedRole: ConstituentRole.verbFinite,
      showSyntaxTree: true,
      isWordOrderChallengeActive: false,
      shuffledGermanTokens: const ['bewies', 'Alhazen', 'die Lichtbrechung.', 'in der Camera Obscura'],
      challengeSolved: false,
    );
  }

  ComparativeSyntaxState copyWith({
    ParallelSentence? selectedSentence,
    ConstituentRole? highlightedRole,
    bool? showSyntaxTree,
    bool? isWordOrderChallengeActive,
    List<String>? shuffledGermanTokens,
    bool? challengeSolved,
  }) {
    return ComparativeSyntaxState(
      selectedSentence: selectedSentence ?? this.selectedSentence,
      highlightedRole: highlightedRole ?? this.highlightedRole,
      showSyntaxTree: showSyntaxTree ?? this.showSyntaxTree,
      isWordOrderChallengeActive:
          isWordOrderChallengeActive ?? this.isWordOrderChallengeActive,
      shuffledGermanTokens:
          shuffledGermanTokens ?? this.shuffledGermanTokens,
      challengeSolved: challengeSolved ?? this.challengeSolved,
    );
  }
}

/// Controller managing Comparative Trilingual Syntax Analysis
class ComparativeSyntaxController extends ChangeNotifier {
  ComparativeSyntaxState _state = ComparativeSyntaxState.initial();

  ComparativeSyntaxState get state => _state;

  void selectSentence(ParallelSentence sentence) {
    _state = _state.copyWith(
      selectedSentence: sentence,
      highlightedRole: ConstituentRole.verbFinite,
      challengeSolved: false,
    );
    notifyListeners();
  }

  void highlightConstituent(ConstituentRole? role) {
    _state = _state.copyWith(highlightedRole: role);
    notifyListeners();
  }

  void toggleSyntaxTree() {
    _state = _state.copyWith(showSyntaxTree: !_state.showSyntaxTree);
    notifyListeners();
  }

  void toggleChallenge() {
    _state = _state.copyWith(
      isWordOrderChallengeActive: !_state.isWordOrderChallengeActive,
      challengeSolved: false,
    );
    notifyListeners();
  }

  /// Reorder tokens in German V2 challenge
  void reorderGermanTokens(int oldIndex, int newIndex) {
    final list = List<String>.from(_state.shuffledGermanTokens);
    if (newIndex > oldIndex) newIndex--;
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);

    // Check if correctly matches target V2 order (Alhazen bewies in der Camera Obscura die Lichtbrechung.)
    final targetOrder = _state.selectedSentence.tokensDe.map((t) => t.text).toList();
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
      shuffledGermanTokens: list,
      challengeSolved: solved,
    );
    notifyListeners();
  }

  void reset() {
    _state = ComparativeSyntaxState.initial();
    notifyListeners();
  }
}
