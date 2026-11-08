import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/saqiya_gearing_comparator.dart';

void main() {
  group('SaqiyaGearingComparator Tests', () {
    test('Validates trilingual saqiya mechanical gearing alignment', () {
      final model = SaqiyaGearingComparator.saqiyaModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.saqiyaStructures['ar'], contains('التُّرْسُ الأُفُقِيُّ'));
      expect(model.saqiyaStructures['de'], contains('Kronrad'));
      expect(model.saqiyaStructures['en'], contains('crown wheel'));
    });
  });
}
