import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/clepsydra_flow_comparator.dart';

void main() {
  group('ClepsydraFlowComparator Tests', () {
    test('Validates trilingual clepsydra hydrodynamic alignment', () {
      final model = ClepsydraFlowComparator.clepsydraModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.flowStructures['ar'], contains('مَا دَامَتِ العَوَّامَةُ'));
      expect(model.flowStructures['de'], contains('Schwimmer'));
      expect(model.flowStructures['en'], contains('float maintains'));
    });
  });
}
