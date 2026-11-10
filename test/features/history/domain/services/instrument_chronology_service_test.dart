import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/history/domain/services/instrument_chronology_service.dart';

void main() {
  group('InstrumentChronologyService Historical Eras', () {
    test('Exposes 4 golden eras with vocalized Arabic and German names', () {
      final eras = InstrumentChronologyService.allEras;
      expect(eras.length, equals(4));

      final houseOfWisdom = eras.first;
      expect(houseOfWisdom.nameAr, contains('بَيْتِ الحِكْمَةِ'));
      expect(houseOfWisdom.nameDe, contains('Hauses der Weisheit'));
      expect(houseOfWisdom.primaryScholars.contains('Al-Khwarizmi'), isTrue);
    });

    test('Finds historical era by scholar name', () {
      final biruniEras = InstrumentChronologyService.findErasForScholar('Al-Biruni');
      expect(biruniEras.isNotEmpty, isTrue);
      expect(biruniEras.first.id, equals('era_golden_andalusian_persian'));

      final jazariEras = InstrumentChronologyService.findErasForScholar('Al-Jazari');
      expect(jazariEras.isNotEmpty, isTrue);
      expect(jazariEras.first.id, equals('era_maragha_samarkand'));
    });

    test('Validates instrument presence within a specific era', () {
      expect(
        InstrumentChronologyService.isInstrumentInEra(
          'universal_astrolabe_saphaea',
          'era_golden_andalusian_persian',
        ),
        isTrue,
      );
      expect(
        InstrumentChronologyService.isInstrumentInEra(
          'universal_astrolabe_saphaea',
          'era_abbasid_house_of_wisdom',
        ),
        isFalse,
      );
    });
  });
}
