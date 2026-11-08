import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/mistara_ruling_comparator.dart';

void main() {
  group('MistaraRulingComparator Tests', () {
    test('Validates trilingual manuscript Mistara ruling alignment', () {
      final model = MistaraRulingComparator.mistaraModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.rulingStructures['ar'], contains('مِسْطَرَةِ الحَرِيرِ'));
      expect(model.rulingStructures['de'], contains('Linierbrett'));
      expect(model.rulingStructures['en'], contains('Mistara ruling board'));
    });
  });
}
