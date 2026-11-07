import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/convex_magnification_comparator.dart';

void main() {
  group('ConvexMagnificationComparator Tests', () {
    test('Validates complete trilingual optical alignment', () {
      final model = ConvexMagnificationComparator.readingStoneModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.opticalStructures['ar'], contains('كُلَّمَا'));
      expect(model.opticalStructures['de'], contains('Je stärker'));
      expect(model.opticalStructures['en'], contains('The more pronounced'));
    });
  });
}
