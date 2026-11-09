import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/dialogues/domain/services/stereographic_projection_comparator.dart';

void main() {
  group('StereographicProjectionComparator Syntactic Parity', () {
    test('Validates complete projection clauses across Arabic, German, and English', () {
      final comparator = StereographicProjectionComparator.standard();

      expect(comparator.validateAlignment(), isTrue);
      expect(comparator.dialogueId, equals('dialogue_169_stereographic_tympan_projection'));
      expect(comparator.projectionClauses['ar'], contains('أَسْقَطَ'));
      expect(comparator.projectionClauses['de'], contains('projizierte'));
      expect(comparator.projectionClauses['en'], contains('projected'));
      expect(comparator.syntacticMarkers.length, equals(3));
    });
  });
}
