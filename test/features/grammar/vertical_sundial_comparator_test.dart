import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/vertical_sundial_comparator.dart';

void main() {
  group('VerticalSundialComparator Tests', () {
    test('Validates trilingual vertical declining sundial alignment', () {
      final model = VerticalSundialComparator.verticalModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.sundialStructures['ar'], contains('جِدَارُ المِئْذَنَةِ'));
      expect(model.sundialStructures['de'], contains('Minarettwand'));
      expect(model.sundialStructures['en'], contains('minaret wall'));
    });
  });
}
