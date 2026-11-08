import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/qalamdan_inkwell_comparator.dart';

void main() {
  group('QalamdanInkwellComparator Tests', () {
    test('Validates trilingual qalamdan inkwell alignment', () {
      final model = QalamdanInkwellComparator.qalamdanModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.qalamdanStructures['ar'], contains('المِقْلَمَةِ النُّحَاسِيَّةِ'));
      expect(model.qalamdanStructures['de'], contains('Messingfutteral'));
      expect(model.qalamdanStructures['en'], contains('pen-case'));
    });
  });
}
