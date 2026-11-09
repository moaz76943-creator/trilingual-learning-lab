import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/phonetic_alignment_engine.dart';

void main() {
  group('PhoneticAlignmentEngine Articulation Detection', () {
    test('Detects Arabic emphatic and pharyngeal consonants', () {
      final hints = PhoneticAlignmentEngine.analyzeTerm(
        arTerm: 'الأَسْطُرْلاَبُ الدَّقِيقُ', // contains 'ق'
        deTerm: 'Messingastrolabium',
        enTerm: 'Brass astrolabe',
      );

      expect(hints.any((h) => h.sound == 'ق'), isTrue);
      final qafHint = hints.firstWhere((h) => h.sound == 'ق');
      expect(qafHint.difficulty, equals(ArticulationDifficulty.challenging));
      expect(qafHint.vocalTipEn, contains('uvular'));
      expect(qafHint.vocalTipAr, contains('لَهَوِيٌّ'));
    });

    test('Detects German rounded umlauts and fricatives', () {
      final hints = PhoneticAlignmentEngine.analyzeTerm(
        arTerm: 'عَجَلَةٌ',
        deTerm: 'Schöpfräder über Brücken', // contains 'ü' and 'ch'
        enTerm: 'Lifting wheels over bridges',
      );

      expect(hints.any((h) => h.sound == 'ü'), isTrue);
      expect(hints.any((h) => h.sound == 'ch'), isTrue);
      expect(hints.any((h) => h.sound == 'ع'), isTrue);
    });

    test('Returns empty list when words only contain standard common phonemes', () {
      final hints = PhoneticAlignmentEngine.analyzeTerm(
        arTerm: 'بَابٌ',
        deTerm: 'Tor',
        enTerm: 'Door',
      );

      expect(hints, isEmpty);
    });
  });
}
