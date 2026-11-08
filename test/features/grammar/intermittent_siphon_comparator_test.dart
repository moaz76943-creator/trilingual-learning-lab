import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/intermittent_siphon_comparator.dart';

void main() {
  group('IntermittentSiphonComparator Tests', () {
    test('Validates trilingual intermittent siphon alignment', () {
      final model = IntermittentSiphonComparator.siphonModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.siphonStructures['ar'], contains('خَطَّ الِاعْتِدَالِ'));
      expect(model.siphonStructures['de'], contains('Mäßigungslinie'));
      expect(model.siphonStructures['en'], contains('moderation'));
    });
  });
}
