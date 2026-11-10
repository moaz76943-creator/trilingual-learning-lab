import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/dialogues/domain/services/zarqallu_saphaea_comparator.dart';

void main() {
  group('ZarqalluSaphaeaComparator Syntactic Parity', () {
    test('Validates universal astrolabe comparative clauses across Arabic, German, and English', () {
      final comparator = ZarqalluSaphaeaComparator.standard();

      expect(comparator.validateAlignment(), isTrue);
      expect(comparator.dialogueId, equals('dialogue_171_zarqallu_saphaea_dialogue'));
      expect(comparator.universalClauses['ar'], contains('عَمَّمَ'));
      expect(comparator.universalClauses['de'], contains('verallgemeinerte'));
      expect(comparator.universalClauses['en'], contains('generalized'));
      expect(comparator.syntacticMarkers.length, equals(3));
    });
  });
}
