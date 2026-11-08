import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/flute_automaton_comparator.dart';

void main() {
  group('FluteAutomatonComparator Tests', () {
    test('Validates trilingual hydraulic flute automaton alignment', () {
      final model = FluteAutomatonComparator.fluteModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.automatonStructures['ar'], contains('الأُسْطُوَانَةُ المُنَقَّطَةُ'));
      expect(model.automatonStructures['de'], contains('Walze'));
      expect(model.automatonStructures['en'], contains('pinned cylinder'));
    });
  });
}
