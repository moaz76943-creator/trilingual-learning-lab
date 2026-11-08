import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/camshaft_suction_pump_comparator.dart';

void main() {
  group('CamshaftSuctionPumpComparator Tests', () {
    test('Validates trilingual camshaft suction pump alignment', () {
      final model = CamshaftSuctionPumpComparator.suctionPumpModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.pumpStructures['ar'], contains('المِكْبَسُ الأَوَّلُ'));
      expect(model.pumpStructures['de'], contains('Kolben'));
      expect(model.pumpStructures['en'], contains('piston suctions'));
    });
  });
}
