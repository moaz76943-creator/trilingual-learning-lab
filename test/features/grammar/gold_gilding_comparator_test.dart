import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/gold_gilding_comparator.dart';

void main() {
  group('GoldGildingComparator Tests', () {
    test('Validates trilingual manuscript gold gilding alignment', () {
      final model = GoldGildingComparator.gildingModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.gildingStructures['ar'], contains('ذَهَبَ المَحَارِ'));
      expect(model.gildingStructures['de'], contains('Muschelgold'));
      expect(model.gildingStructures['en'], contains('shell gold'));
    });
  });
}
