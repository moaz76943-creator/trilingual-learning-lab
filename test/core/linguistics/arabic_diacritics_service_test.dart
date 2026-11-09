import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/linguistics/arabic_diacritics_service.dart';

void main() {
  group('ArabicDiacriticsService Normalization & Matching', () {
    test('stripTashkeel removes all harakat and tatweel while keeping base text', () {
      const fullyVocalized = 'الأَسْطُرْلاَبُ النُّحَاسِـيُّ';
      final stripped = ArabicDiacriticsService.stripTashkeel(fullyVocalized);
      expect(stripped, equals('الاسطرلاب النحاسي'));
    });

    test('normalizeArabic unifies Alef variants, Taa Marbuta, and Alef Maksura', () {
      const input = 'إِبْرِيقُ مَاءٍ عَلَى رُبْوَةٍ وَقُرَى';
      final normalized = ArabicDiacriticsService.normalizeArabic(input);

      // إ -> ا, ة -> ه, ى -> ي
      expect(normalized, contains('ابريق'));
      expect(normalized, contains('ربوه'));
      expect(normalized, contains('قري'));
      expect(normalized.contains('إ'), isFalse);
      expect(normalized.contains('ة'), isFalse);
      expect(normalized.contains('ى'), isFalse);
    });

    test('normalizeGerman converts umlauts and ß to standard phonetic digraphs', () {
      const german = 'Große Präzisions-Messingräder über Öffnungen';
      final normalized = ArabicDiacriticsService.normalizeGerman(german);

      expect(normalized, contains('grosse'));
      expect(normalized, contains('praezisions'));
      expect(normalized, contains('messingraeder'));
      expect(normalized, contains('ueber'));
      expect(normalized, contains('oeffnungen'));
    });

    test('matchesTrilingual matches unvocalized search query against vocalized text', () {
      const arabicTitle = 'نَقْشُ صَفَائِحِ الرُّبْعِ المُجَيَّبِ';
      expect(ArabicDiacriticsService.matchesTrilingual(arabicTitle, 'نقش'), isTrue);
      expect(ArabicDiacriticsService.matchesTrilingual(arabicTitle, 'صفائح'), isTrue);
      expect(ArabicDiacriticsService.matchesTrilingual(arabicTitle, 'الربع المجيب'), isTrue);
    });

    test('matchesTrilingual matches German search with and without umlauts', () {
      const germanTitle = 'Schöpfräder und Flaschenzüge';
      expect(ArabicDiacriticsService.matchesTrilingual(germanTitle, 'schöpfrad'), isTrue);
      expect(ArabicDiacriticsService.matchesTrilingual(germanTitle, 'schoepfrad'), isTrue);
      expect(ArabicDiacriticsService.matchesTrilingual(germanTitle, 'flaschenzug'), isTrue);
    });
  });
}
