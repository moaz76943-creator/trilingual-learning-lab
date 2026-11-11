import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/presentation/controllers/grammar_studio_controller.dart';

void main() {
  group('GrammarStudioController Interactive Syntax State', () {
    late GrammarComparativeRule sampleRule;
    late GrammarStudioController controller;

    setUp(() {
      sampleRule = GrammarComparativeRule.quadrantRule();
      controller = GrammarStudioController(rule: sampleRule);
    });

    test('Initializes with validated syntactic alignment', () {
      expect(controller.alignmentResult.isValid, isTrue);
      expect(controller.isBookmarked, isFalse);
      expect(controller.userArrangedClauses, isEmpty);
      expect(controller.availableClauses.length, equals(3));
      expect(controller.isPuzzleCorrect, isNull);
    });

    test('Adds and removes clauses updating available pool', () {
      final firstClause = sampleRule.scrambledClauses.first;
      controller.addClause(firstClause);

      expect(controller.userArrangedClauses.length, equals(1));
      expect(controller.userArrangedClauses.first, equals(firstClause));
      expect(controller.availableClauses.contains(firstClause), isFalse);

      controller.removeClause(firstClause);
      expect(controller.userArrangedClauses, isEmpty);
      expect(controller.availableClauses.contains(firstClause), isTrue);
    });

    test('Evaluates correct clause arrangement successfully', () {
      // Add clauses in exact correct order
      for (final clause in sampleRule.correctClauseOrder) {
        controller.addClause(clause);
      }

      controller.checkPuzzle();
      expect(controller.isPuzzleCorrect, isTrue);
    });

    test('Evaluates incorrect clause arrangement failing verification', () {
      // Add clauses in reversed order
      for (final clause in sampleRule.correctClauseOrder.reversed) {
        controller.addClause(clause);
      }

      controller.checkPuzzle();
      expect(controller.isPuzzleCorrect, isFalse);
    });

    test('Toggles bookmark status and resets puzzle state', () {
      controller.toggleBookmark();
      expect(controller.isBookmarked, isTrue);

      controller.addClause('test');
      controller.resetPuzzle();
      expect(controller.userArrangedClauses, isEmpty);
      expect(controller.isPuzzleCorrect, isNull);
    });
  });
}
