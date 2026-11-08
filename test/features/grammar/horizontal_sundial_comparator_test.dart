import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/horizontal_sundial_comparator.dart';

void main() {
  group('HorizontalSundialComparator Tests', () {
    test('Validates trilingual horizontal sundial alignment', () {
      final model = HorizontalSundialComparator.sundialModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.sundialStructures['ar'], contains('ظِلُّ الشَّاخِصِ النُّحَاسِيِّ'));
      expect(model.sundialStructures['de'], contains('Gnomons'));
      expect(model.sundialStructures['en'], contains('brass gnomon'));
    });
  });
}
