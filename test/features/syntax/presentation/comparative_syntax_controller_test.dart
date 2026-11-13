import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/syntax/presentation/controllers/comparative_syntax_controller.dart';

void main() {
  group('ComparativeSyntaxController - Trilingual Syntax Alignment Tests', () {
    late ComparativeSyntaxController controller;

    setUp(() {
      controller = ComparativeSyntaxController();
    });

    test('Initial state configures first parallel sentence with finite verb highlight', () {
      final state = controller.state;
      expect(state.selectedSentence.id, 'optics_experiment');
      expect(state.highlightedRole, ConstituentRole.verbFinite);
      expect(state.showSyntaxTree, isTrue);
      expect(state.isWordOrderChallengeActive, isFalse);
    });

    test('Parallel sentence corpus contains verified parallel tokens in Arabic, German, and English', () {
      for (final sentence in ParallelSentence.corpus) {
        expect(sentence.tokensAr.isNotEmpty, isTrue);
        expect(sentence.tokensDe.isNotEmpty, isTrue);
        expect(sentence.tokensEn.isNotEmpty, isTrue);

        // Arabic should feature finite verb
        expect(sentence.tokensAr.any((t) => t.role == ConstituentRole.verbFinite), isTrue);
        // German should feature finite verb
        expect(sentence.tokensDe.any((t) => t.role == ConstituentRole.verbFinite), isTrue);
        // English should feature finite verb
        expect(sentence.tokensEn.any((t) => t.role == ConstituentRole.verbFinite), isTrue);
      }
    });

    test('Highlighting constituent role updates state', () {
      controller.highlightConstituent(ConstituentRole.subject);
      expect(controller.state.highlightedRole, ConstituentRole.subject);

      controller.highlightConstituent(null);
      expect(controller.state.highlightedRole, isNull);
    });

    test('Reordering challenge validates correct German V2 word order', () {
      controller.toggleChallenge();
      expect(controller.state.isWordOrderChallengeActive, isTrue);
      expect(controller.state.challengeSolved, isFalse);

      // Reorder correctly to match target:
      // ['Alhazen', 'bewies', 'in der Camera Obscura', 'die Lichtbrechung.']
      // Let's force the order directly via reordering simulation
      final target = controller.state.selectedSentence.tokensDe.map((t) => t.text).toList();
      for (int i = 0; i < target.length; i++) {
        final currentIdx = controller.state.shuffledGermanTokens.indexOf(target[i]);
        if (currentIdx != i) {
          controller.reorderGermanTokens(currentIdx, i);
        }
      }

      expect(controller.state.challengeSolved, isTrue);
    });

    test('Sentence selection updates corpus and resets challenge state', () {
      final second = ParallelSentence.corpus[1];
      controller.selectSentence(second);

      expect(controller.state.selectedSentence.id, 'subordinate_clause');
      expect(controller.state.challengeSolved, isFalse);
    });

    test('Reset restores pristine state', () {
      controller.highlightConstituent(ConstituentRole.objectDirect);
      controller.reset();

      expect(controller.state.selectedSentence.id, 'optics_experiment');
      expect(controller.state.highlightedRole, ConstituentRole.verbFinite);
    });
  });
}
