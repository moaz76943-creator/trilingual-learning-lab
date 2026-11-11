import 'package:flutter/foundation.dart';
import '../../domain/services/syntactic_marker_validator.dart';

/// Representation of a trilingual comparative grammar rule model.
class GrammarComparativeRule {
  final String id;
  final String titleAr;
  final String titleDe;
  final String titleEn;
  final Map<String, String> exampleSentences;
  final List<String> requiredMarkers;
  final List<String> scrambledClauses;
  final List<String> correctClauseOrder;

  const GrammarComparativeRule({
    required this.id,
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
    required this.exampleSentences,
    required this.requiredMarkers,
    required this.scrambledClauses,
    required this.correctClauseOrder,
  });

  /// Factory creating canonical model for trigonometric quadrant conditional clauses.
  factory GrammarComparativeRule.quadrantRule() {
    return const GrammarComparativeRule(
      id: 'grammar_quadrant_conditional_001',
      titleAr: 'أُسْلُوبُ الشَّرْطِ وَالمُقَابَلَةِ الهَنْدَسِيَّةِ',
      titleDe: 'Konditionalsatz und geometrische Gegenüberstellung',
      titleEn: 'Conditional Clause and Geometric Correlative Construction',
      exampleSentences: {
        'ar': 'إِذَا صَوَّبَ المَسَّاحُ خَيْطَ الشَّاقُولِ عَلَى مُرَبَّعِ الظِّلِّ، حَدَّدَ الِارتِفَاعَ دُونَ مَشَقَّةٍ.',
        'de': 'Wenn der Landvermesser das Lot über das Schattenquadrat visiert, ermittelt er die Höhe ohne Mühe.',
        'en': 'When the surveyor aligns the plumb line across the shadow square, he determines the height without trouble.',
      },
      requiredMarkers: [
        'conditional_idha_wenn_when',
        'exemption_duna_ohne_without',
      ],
      scrambledClauses: [
        'حَدَّدَ الِارتِفَاعَ',
        'إِذَا صَوَّبَ المَسَّاحُ خَيْطَ الشَّاقُولِ',
        'دُونَ مَشَقَّةٍ',
      ],
      correctClauseOrder: [
        'إِذَا صَوَّبَ المَسَّاحُ خَيْطَ الشَّاقُولِ',
        'حَدَّدَ الِارتِفَاعَ',
        'دُونَ مَشَقَّةٍ',
      ],
    );
  }
}

/// Controller governing the interactive grammar rule studio and clause ordering exercise.
class GrammarStudioController extends ChangeNotifier {
  final GrammarComparativeRule rule;
  late final SyntacticAlignmentResult alignmentResult;
  final List<String> _userArrangedClauses = [];
  bool? _isPuzzleCorrect;
  bool _isBookmarked = false;

  GrammarStudioController({
    required this.rule,
    bool initialBookmarked = false,
  }) : _isBookmarked = initialBookmarked {
    alignmentResult = SyntacticMarkerValidator.validate(
      sentences: rule.exampleSentences,
      requiredMarkers: rule.requiredMarkers,
    );
    resetPuzzle();
  }

  bool get isBookmarked => _isBookmarked;
  bool? get isPuzzleCorrect => _isPuzzleCorrect;
  List<String> get userArrangedClauses => List.unmodifiable(_userArrangedClauses);
  List<String> get availableClauses =>
      rule.scrambledClauses.where((c) => !_userArrangedClauses.contains(c)).toList();

  /// Toggles bookmark state for this grammar rule.
  void toggleBookmark() {
    _isBookmarked = !_isBookmarked;
    notifyListeners();
  }

  /// Appends [clause] to user's arrangement.
  void addClause(String clause) {
    if (!_userArrangedClauses.contains(clause)) {
      _userArrangedClauses.add(clause);
      _isPuzzleCorrect = null;
      notifyListeners();
    }
  }

  /// Removes [clause] from user's arrangement.
  void removeClause(String clause) {
    _userArrangedClauses.remove(clause);
    _isPuzzleCorrect = null;
    notifyListeners();
  }

  /// Evaluates user's arrangement against the correct clause order.
  void checkPuzzle() {
    if (_userArrangedClauses.length != rule.correctClauseOrder.length) {
      _isPuzzleCorrect = false;
      notifyListeners();
      return;
    }

    bool isAllMatch = true;
    for (var i = 0; i < rule.correctClauseOrder.length; i++) {
      if (_userArrangedClauses[i] != rule.correctClauseOrder[i]) {
        isAllMatch = false;
        break;
      }
    }

    _isPuzzleCorrect = isAllMatch;
    notifyListeners();
  }

  /// Resets the clause ordering puzzle.
  void resetPuzzle() {
    _userArrangedClauses.clear();
    _isPuzzleCorrect = null;
    notifyListeners();
  }
}
