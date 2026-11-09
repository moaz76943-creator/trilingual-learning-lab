import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/linguistics/arabic_diacritics_service.dart';
import 'package:trilingual_learning_lab/features/search/domain/services/trilingual_search_indexer.dart';

void main() {
  group('TrilingualSearchIndexer Multi-Entity Queries & Ranking', () {
    late TrilingualSearchIndexer indexer;

    setUp(() {
      indexer = TrilingualSearchIndexer();
      indexer.addAll([
        const IndexedDocument(
          id: 'cat_astrolabe_001',
          entityType: SearchEntityType.category,
          titleAr: 'صِنَاعَةُ الأَسْطُرْلاَبِ النُّحَاسِيِّ',
          titleDe: 'Bau des Messingastrolabiums',
          titleEn: 'Brass Astrolabe Construction',
          searchableFields: {
            'title_ar': 'صِنَاعَةُ الأَسْطُرْلاَبِ النُّحَاسِيِّ',
            'title_de': 'Bau des Messingastrolabiums',
            'title_en': 'Brass Astrolabe Construction',
            'item_1_ar': 'حُجْرَةُ الصَّفَائِحِ',
            'item_1_de': 'Mutter der Einlegeplatten',
            'item_1_en': 'Mater of Plates',
          },
        ),
        const IndexedDocument(
          id: 'verb_magnify_001',
          entityType: SearchEntityType.verb,
          titleAr: 'كَبَّرَ - يُكَبِّرُ',
          titleDe: 'vergrößern',
          titleEn: 'to magnify',
          searchableFields: {
            'title_ar': 'كَبَّرَ - يُكَبِّرُ',
            'title_de': 'vergrößern',
            'title_en': 'to magnify',
            'root': 'ك - ب - ر',
          },
        ),
        const IndexedDocument(
          id: 'dial_water_001',
          entityType: SearchEntityType.dialogue,
          titleAr: 'حِوَارُ السَّاعَةِ المَائِيَّةِ',
          titleDe: 'Wasseruhr-Gespräch',
          titleEn: 'Water Clock Dialogue',
          searchableFields: {
            'title_ar': 'حِوَارُ السَّاعَةِ المَائِيَّةِ',
            'title_de': 'Wasseruhr-Gespräch',
            'title_en': 'Water Clock Dialogue',
            'line_1_ar': 'هَلِ انْتَظَمَ تَدَفُّقُ المَاءِ عَبْرَ الصِّمَامِ؟',
          },
        ),
      ]);
    });

    test('Indexes documents and updates indexedCount', () {
      expect(indexer.indexedCount, equals(3));
    });

    test('Finds Arabic content without tashkeel and boosts title match', () {
      final results = indexer.search('اسطرلاب');
      expect(results.isNotEmpty, isTrue);
      expect(results.first.id, equals('cat_astrolabe_001'));
      expect(results.first.relevanceScore, greaterThanOrEqualTo(40));
    });

    test('Finds item vocabulary inside category', () {
      final results = indexer.search('صفائح');
      expect(results.isNotEmpty, isTrue);
      expect(results.first.id, equals('cat_astrolabe_001'));
      expect(results.first.matchedField, equals('item_1_ar'));
    });

    test('Finds German umlaut terms flexibly', () {
      final results = indexer.search('vergroessern');
      expect(results.isNotEmpty, isTrue);
      expect(results.first.id, equals('verb_magnify_001'));
      expect(results.first.entityType, equals(SearchEntityType.verb));
    });

    test('Filters results by entityType', () {
      final catResults = indexer.search('ماء', filterType: SearchEntityType.category);
      expect(catResults.isEmpty, isTrue);

      final dialResults = indexer.search('ماء', filterType: SearchEntityType.dialogue);
      expect(dialResults.isNotEmpty, isTrue);
      expect(dialResults.first.id, equals('dial_water_001'));
    });

    test('Empty query returns empty results', () {
      expect(indexer.search('   '), isEmpty);
    });
  });
}
