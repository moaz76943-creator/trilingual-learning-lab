import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/dialogues/domain/services/alidade_observation_comparator.dart';

void main() {
  group('AlidadeObservationComparator Syntactic Parity', () {
    test('Validates complete sighting clauses across Arabic, German, and English', () {
      final comparator = AlidadeObservationComparator.standard();

      expect(comparator.validateAlignment(), isTrue);
      expect(comparator.dialogueId, equals('dialogue_168_astrolabe_alidade_observation'));
      expect(comparator.sightingClauses['ar'], contains('العِضَادَةَ'));
      expect(comparator.sightingClauses['de'], contains('Alhidade'));
      expect(comparator.sightingClauses['en'], contains('alidade'));
      expect(comparator.syntacticMarkers.length, equals(3));
    });
  });
}
