import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/bookbinding_tooling_comparator.dart';

void main() {
  group('BookbindingToolingComparator Tests', () {
    test('Validates trilingual bookbinding blind tooling alignment', () {
      final model = BookbindingToolingComparator.toolingModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.toolingStructures['ar'], contains('مِكْوَاةَ النُّحَاسِ'));
      expect(model.toolingStructures['de'], contains('Messingstempel'));
      expect(model.toolingStructures['en'], contains('finishing iron'));
    });
  });
}
