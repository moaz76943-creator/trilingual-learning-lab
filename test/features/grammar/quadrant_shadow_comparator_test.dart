import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/quadrant_shadow_comparator.dart';

void main() {
  group('QuadrantShadowComparator Tests', () {
    test('Validates trilingual quadrant shadow alignment', () {
      final model = QuadrantShadowComparator.quadrantModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.shadowStructures['ar'], contains('مُرَبَّعِ الظِّلِّ'));
      expect(model.shadowStructures['de'], contains('Schattenquadrat'));
      expect(model.shadowStructures['en'], contains('shadow square'));
    });
  });
}
