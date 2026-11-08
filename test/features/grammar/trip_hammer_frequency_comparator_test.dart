import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/trip_hammer_frequency_comparator.dart';

void main() {
  group('TripHammerFrequencyComparator Tests', () {
    test('Validates trilingual paper-mill trip-hammer alignment', () {
      final model = TripHammerFrequencyComparator.tripHammerModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.hammerStructures['ar'], contains('مَطَارِقَ السِّنْدِيَانِ'));
      expect(model.hammerStructures['de'], contains('Eichenholzhämmer'));
      expect(model.hammerStructures['en'], contains('drop-hammers'));
    });
  });
}
