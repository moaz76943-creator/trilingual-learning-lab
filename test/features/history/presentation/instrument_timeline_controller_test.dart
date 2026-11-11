import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/history/presentation/controllers/instrument_timeline_controller.dart';

void main() {
  group('InstrumentTimelineController Interactive Studio State', () {
    late InstrumentTimelineController controller;

    setUp(() {
      controller = InstrumentTimelineController();
    });

    test('Initializes with House of Wisdom era and resolves catalog', () {
      expect(controller.eras.length, equals(4));
      expect(controller.activeEraIndex, equals(0));
      expect(controller.activeEra!.id, equals('era_abbasid_house_of_wisdom'));
      expect(controller.activeInstruments.length, equals(2));
      expect(controller.activeInstruments.first.id, equals('planispheric_astrolabe'));
    });

    test('Switches active era and resolves corresponding instrument catalog', () {
      controller.selectEra(1); // Golden Age
      expect(controller.activeEraIndex, equals(1));
      expect(controller.activeEra!.id, equals('era_golden_andalusian_persian'));

      final instruments = controller.activeInstruments;
      expect(instruments.length, equals(2));
      expect(instruments.any((i) => i.id == 'universal_astrolabe_saphaea'), isTrue);
    });

    test('Tracks explored instrument milestones', () {
      expect(controller.exploredCount, equals(0));

      controller.markInstrumentExplored('planispheric_astrolabe');
      expect(controller.exploredCount, equals(1));

      // Duplicate exploration does not duplicate count
      controller.markInstrumentExplored('planispheric_astrolabe');
      expect(controller.exploredCount, equals(1));
    });
  });
}
