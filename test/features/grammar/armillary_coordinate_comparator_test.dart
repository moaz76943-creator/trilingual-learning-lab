import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/armillary_coordinate_comparator.dart';

void main() {
  group('ArmillaryCoordinateComparator Tests', () {
    test('Validates trilingual armillary coordinate alignment', () {
      final model = ArmillaryCoordinateComparator.armillaryModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.coordinateStructures['ar'], contains('حَلْقَةُ البُرُوجِ المَائِلَةِ'));
      expect(model.coordinateStructures['de'], contains('geneigte Ekliptikring'));
      expect(model.coordinateStructures['en'], contains('inclined ecliptic ring'));
    });
  });
}
