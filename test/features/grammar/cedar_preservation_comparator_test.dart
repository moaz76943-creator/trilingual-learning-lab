import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/cedar_preservation_comparator.dart';

void main() {
  group('CedarPreservationComparator Tests', () {
    test('Validates trilingual cedarwood manuscript preservation alignment', () {
      final model = CedarPreservationComparator.cedarModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.preservationStructures['ar'], contains('خَزَائِنِ الأَرْزِ'));
      expect(model.preservationStructures['de'], contains('Zedernholz'));
      expect(model.preservationStructures['en'], contains('cedarwood'));
    });
  });
}
