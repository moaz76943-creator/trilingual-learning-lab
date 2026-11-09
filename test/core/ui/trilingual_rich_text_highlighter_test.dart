import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/ui/trilingual_rich_text_highlighter.dart';

void main() {
  group('TrilingualRichTextHighlighter Diacritic Preservation', () {
    test('Highlights Arabic terms matching unvocalized query while preserving vocalized Tashkeel', () {
      const vocalized = 'صِنَاعَةُ الأَسْطُرْلاَبِ النُّحَاسِيِّ الدَّقِيقِ';
      final tokens = TrilingualRichTextHighlighter.highlightTerms(
        sentence: vocalized,
        targetTerms: ['الاسطرلاب'], // Target without Tashkeel
      );

      expect(tokens.any((t) => t.isTarget), isTrue);
      final targetToken = tokens.firstWhere((t) => t.isTarget);
      // Must preserve the full original Tashkeel!
      expect(targetToken.text, equals('الأَسْطُرْلاَبِ'));
    });

    test('Highlights German terms case-insensitively', () {
      const sentence = 'Das Messingastrolabium besitzt sechzig Höhenkreise.';
      final tokens = TrilingualRichTextHighlighter.highlightTerms(
        sentence: sentence,
        targetTerms: ['messingastrolabium'],
      );

      expect(tokens.first.isTarget, isTrue);
      expect(tokens.first.text, equals('Messingastrolabium'));
      expect(tokens[1].isTarget, isFalse);
    });

    test('Returns unhighlighted single token when no matches exist', () {
      const text = 'Ordinary plain sentence.';
      final tokens = TrilingualRichTextHighlighter.highlightTerms(
        sentence: text,
        targetTerms: ['Astrolabe'],
      );

      expect(tokens.length, equals(1));
      expect(tokens.first.isTarget, isFalse);
      expect(tokens.first.text, equals(text));
    });
  });
}
