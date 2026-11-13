import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/morphology/presentation/controllers/morphological_deconstruction_controller.dart';

void main() {
  group('MorphologicalDeconstructionController - Trilingual Morphology Tests', () {
    late MorphologicalDeconstructionController controller;

    setUp(() {
      controller = MorphologicalDeconstructionController();
    });

    test('Initial state configures Arabic root & pattern word (intithar)', () {
      final state = controller.state;
      expect(state.selectedLanguage, MorphologicalLanguage.arabic);
      expect(state.selectedWord.fullWord, 'انْتِظَارٌ');
      expect(state.selectedWord.rootString, 'ن - ظ - ر');
      expect(state.selectedWord.segments.length, 6);
    });

    test('Language switching updates selected word and generates shuffled segments', () {
      controller.setLanguage(MorphologicalLanguage.german);
      expect(controller.state.selectedLanguage, MorphologicalLanguage.german);
      expect(controller.state.selectedWord.fullWord, 'Wissenschaftsgeschichte');
      expect(controller.state.shuffledSegments.isNotEmpty, isTrue);

      controller.setLanguage(MorphologicalLanguage.english);
      expect(controller.state.selectedLanguage, MorphologicalLanguage.english);
      expect(controller.state.selectedWord.fullWord, 'Deconstruction');
    });

    test('Highlighting morphological segment updates state', () {
      controller.highlightSegment(2);
      expect(controller.state.highlightedSegmentIndex, 2);

      controller.highlightSegment(null);
      expect(controller.state.highlightedSegmentIndex, isNull);
    });

    test('Assembly challenge reordering detects correct solved sequence', () {
      controller.toggleChallenge();
      expect(controller.state.isAssemblyChallengeActive, isTrue);

      // Force-order segments to match target
      final target = controller.state.selectedWord.segments.map((s) => s.segmentText).toList();
      for (int i = 0; i < target.length; i++) {
        final currentIdx = controller.state.shuffledSegments.indexOf(target[i]);
        if (currentIdx != i) {
          controller.reorderSegments(currentIdx, i);
        }
      }

      expect(controller.state.challengeSolved, isTrue);
    });

    test('Word selection updates word entity and resets challenge solved flag', () {
      final second = MorphologicalWord.catalog[1];
      controller.selectWord(second);

      expect(controller.state.selectedWord.id, 'ar_istikshaf');
      expect(controller.state.challengeSolved, isFalse);
    });

    test('Reset restores pristine state', () {
      controller.setLanguage(MorphologicalLanguage.german);
      controller.reset();

      expect(controller.state.selectedLanguage, MorphologicalLanguage.arabic);
      expect(controller.state.selectedWord.fullWord, 'انْتِظَارٌ');
    });
  });
}
