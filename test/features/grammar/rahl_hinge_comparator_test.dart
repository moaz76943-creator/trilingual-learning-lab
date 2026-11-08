import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/rahl_hinge_comparator.dart';

void main() {
  group('RahlHingeComparator Tests', () {
    test('Validates trilingual folding rahl alignment', () {
      final model = RahlHingeComparator.rahlModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.rahlStructures['ar'], contains('الرَّحْلُ الخَشَبِيُّ'));
      expect(model.rahlStructures['de'], contains('Lesepult'));
      expect(model.rahlStructures['en'], contains('book rest'));
    });
  });
}
