import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/proportional_script_comparator.dart';

void main() {
  group('ProportionalScriptComparator Tests', () {
    test('Validates trilingual proportional script alignment', () {
      final model = ProportionalScriptComparator.proportionalModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.scriptStructures['ar'], contains('نِقَاطٍ مَعِينِيَّةٍ'));
      expect(model.scriptStructures['de'], contains('Rautenpunkte'));
      expect(model.scriptStructures['en'], contains('rhombic dots'));
    });
  });
}
