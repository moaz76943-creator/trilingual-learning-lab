import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/ahar_sizing_comparator.dart';

void main() {
  group('AharSizingComparator Tests', () {
    test('Validates trilingual Ahar paper sizing alignment', () {
      final model = AharSizingComparator.sizingModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.sizingStructures['ar'], contains('عَصِيرِ الآهَارِ'));
      expect(model.sizingStructures['de'], contains('Ahar-Schlichte'));
      expect(model.sizingStructures['en'], contains('Ahar glaze'));
    });
  });
}
