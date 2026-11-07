import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/saphea_projection_comparator.dart';

void main() {
  group('SapheaProjectionComparator Tests', () {
    test('Validates trilingual universal Saphea projection alignment', () {
      final model = SapheaProjectionComparator.sapheaModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.projectionStructures['ar'], contains('إِسْقَاطِ الزَّرْقَالِيِّ'));
      expect(model.projectionStructures['de'], contains('Projektion von az-Zarqali'));
      expect(model.projectionStructures['en'], contains('al-Zarqali’s universal projection'));
    });
  });
}
