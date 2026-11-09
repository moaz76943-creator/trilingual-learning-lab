import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/dialogues/domain/services/astrolabe_rete_comparator.dart';

void main() {
  group('AstrolabeReteComparator Syntactic & Linguistic Alignment', () {
    test('Validates complete technical comparative clauses across three languages', () {
      final comparator = AstrolabeReteComparator.standard();

      expect(comparator.validateAlignment(), isTrue);
      expect(comparator.dialogueId, equals('dialogue_167_astrolabe_rete_pointers'));
      expect(comparator.technicalClauses['ar'], contains('المَقَنْطَرَاتِ'));
      expect(comparator.technicalClauses['de'], contains('Almutantarenkreise'));
      expect(comparator.technicalClauses['en'], contains('altitude circles'));
      expect(comparator.syntacticMarkers.length, equals(2));
    });
  });
}
