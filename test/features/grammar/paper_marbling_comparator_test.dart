import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/paper_marbling_comparator.dart';

void main() {
  group('PaperMarblingComparator Tests', () {
    test('Validates trilingual Ebru paper marbling alignment', () {
      final model = PaperMarblingComparator.marblingModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.marblingStructures['ar'], contains('مَرَارَةِ البَقَرِ'));
      expect(model.marblingStructures['de'], contains('Ochsengalle'));
      expect(model.marblingStructures['en'], contains('ox gall'));
    });
  });
}
