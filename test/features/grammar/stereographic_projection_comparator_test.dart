import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/stereographic_projection_comparator.dart';

void main() {
  group('StereographicProjectionComparator Tests', () {
    test('Validates trilingual stereographic celestial projection alignment', () {
      final model = StereographicProjectionComparator.astrolabeModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.projectionStructures['ar'], contains('القُبَّةَ السَّمَاوِيَّةَ'));
      expect(model.projectionStructures['de'], contains('Himmelsgewölbe'));
      expect(model.projectionStructures['en'], contains('celestial sphere'));
    });
  });
}
