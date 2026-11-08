import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/ink_chemistry_comparator.dart';

void main() {
  group('InkChemistryComparator Tests', () {
    test('Validates trilingual ink chemistry alignment', () {
      final model = InkChemistryComparator.inkModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.inkStructures['ar'], contains('عَفْصِ حَلَبَ'));
      expect(model.inkStructures['de'], contains('Galläpfel'));
      expect(model.inkStructures['en'], contains('gallnuts'));
    });
  });
}
