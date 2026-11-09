import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/etymological_cognate_tracker.dart';

void main() {
  group('EtymologicalCognateTracker Cross-Linguistic Lookups', () {
    test('Contains curated scientific loanwords between Arabic, German, and English', () {
      final cognates = EtymologicalCognateTracker.allCognates;
      expect(cognates.length, greaterThanOrEqualTo(5));

      final alidade = cognates.firstWhere((c) => c.id == 'cognate_alidade');
      expect(alidade.arabicTerm, equals('العِضَادَةُ'));
      expect(alidade.germanTerm, equals('Die Alhidade'));
      expect(alidade.englishTerm, equals('The Alidade'));
      expect(alidade.arabicRoot, equals('ع - ض - د'));
    });

    test('Finds cognate by Arabic unvocalized query', () {
      final results = EtymologicalCognateTracker.findCognates('عضادة');
      expect(results.isNotEmpty, isTrue);
      expect(results.first.id, equals('cognate_alidade'));
    });

    test('Finds cognate by German or English scientific term', () {
      final deResults = EtymologicalCognateTracker.findCognates('azimut');
      expect(deResults.isNotEmpty, isTrue);
      expect(deResults.first.id, equals('cognate_azimuth'));

      final enResults = EtymologicalCognateTracker.findCognates('zenith');
      expect(enResults.isNotEmpty, isTrue);
      expect(enResults.first.id, equals('cognate_zenith'));
    });
  });
}
