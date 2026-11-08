import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/pen_beveling_comparator.dart';

void main() {
  group('PenBevelingComparator Tests', () {
    test('Validates trilingual pen beveling alignment', () {
      final model = PenBevelingComparator.bevelingModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.bevelingStructures['ar'], contains('المِقَطَّةِ العَظْمِيَّةِ'));
      expect(model.bevelingStructures['de'], contains('Schneideplättchen'));
      expect(model.bevelingStructures['en'], contains('cutting block'));
    });
  });
}
