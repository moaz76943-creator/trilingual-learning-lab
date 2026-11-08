import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/scaphe_projection_comparator.dart';

void main() {
  group('ScapheProjectionComparator Tests', () {
    test('Validates trilingual hemispherical scaphe projection alignment', () {
      final model = ScapheProjectionComparator.scapheModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.scapheStructures['ar'], contains('حَبَّةِ الشَّاخِصِ المَرْكَزِيَّةِ'));
      expect(model.scapheStructures['de'], contains('Gnomonkugel'));
      expect(model.scapheStructures['en'], contains('gnomon nodus'));
    });
  });
}
