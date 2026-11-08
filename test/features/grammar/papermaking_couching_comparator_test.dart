import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/papermaking_couching_comparator.dart';

void main() {
  group('PapermakingCouchingComparator Tests', () {
    test('Validates trilingual papermaking couching alignment', () {
      final model = PapermakingCouchingComparator.couchingModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.couchingStructures['ar'], contains('قَالَبَ السِّلْكِ'));
      expect(model.couchingStructures['de'], contains('Drahtsieb'));
      expect(model.couchingStructures['en'], contains('wire mould'));
    });
  });
}
