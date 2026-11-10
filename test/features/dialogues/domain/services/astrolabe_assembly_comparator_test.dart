import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/dialogues/domain/services/astrolabe_assembly_comparator.dart';

void main() {
  group('AstrolabeAssemblyComparator Syntactic Parity', () {
    test('Validates complete assembly clauses across Arabic, German, and English', () {
      final comparator = AstrolabeAssemblyComparator.standard();

      expect(comparator.validateAlignment(), isTrue);
      expect(comparator.dialogueId, equals('dialogue_170_astrolabe_final_assembly'));
      expect(comparator.assemblyClauses['ar'], contains('فَرَسَ'));
      expect(comparator.assemblyClauses['de'], contains('Keil'));
      expect(comparator.assemblyClauses['en'], contains('wedge'));
      expect(comparator.syntacticMarkers.length, equals(3));
    });
  });
}
