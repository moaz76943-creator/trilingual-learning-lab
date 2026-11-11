import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/search/domain/services/trilingual_search_indexer.dart';
import 'package:trilingual_learning_lab/features/search/presentation/controllers/search_screen_controller.dart';

void main() {
  group('SearchScreenController Live Search Lifecycle', () {
    late TrilingualSearchIndexer indexer;
    late SearchScreenController controller;

    setUp(() {
      indexer = TrilingualSearchIndexer();
      indexer.addAll([
        const IndexedDocument(
          id: 'cat_astrolabe',
          entityType: SearchEntityType.category,
          titleAr: 'صِنَاعَةُ الأَسْطُرْلاَبِ',
          titleDe: 'Bau des Astrolabiums',
          titleEn: 'Astrolabe Construction',
          searchableFields: {
            'title_ar': 'صِنَاعَةُ الأَسْطُرْلاَبِ',
            'title_de': 'Bau des Astrolabiums',
            'title_en': 'Astrolabe Construction',
          },
        ),
        const IndexedDocument(
          id: 'verb_magnify',
          entityType: SearchEntityType.verb,
          titleAr: 'كَبَّرَ - يُكَبِّرُ',
          titleDe: 'vergrößern',
          titleEn: 'to magnify',
          searchableFields: {
            'title_ar': 'كَبَّرَ - يُكَبِّرُ',
            'title_de': 'vergrößern',
            'title_en': 'to magnify',
          },
        ),
      ]);

      controller = SearchScreenController(indexer: indexer);
    });

    test('Initializes with idle state and empty query', () {
      expect(controller.state, equals(SearchState.idle));
      expect(controller.currentQuery, isEmpty);
      expect(controller.results, isEmpty);
      expect(controller.selectedFilter, isNull);
    });

    test('Executes search successfully matching unvocalized query and ranks results', () async {
      await controller.executeSearch('اسطرلاب');

      expect(controller.state, equals(SearchState.success));
      expect(controller.results.length, equals(1));
      expect(controller.results.first.id, equals('cat_astrolabe'));
      expect(controller.recentQueries.contains('اسطرلاب'), isTrue);
    });

    test('Applies faceted filter chip correctly', () async {
      // Search with Verb filter
      controller.setFilter(SearchEntityType.verb);
      await controller.executeSearch('vergroessern');

      expect(controller.results.length, equals(1));
      expect(controller.results.first.id, equals('verb_magnify'));

      // If filter changed to category, query should yield empty
      controller.setFilter(SearchEntityType.category);
      expect(controller.results, isEmpty);
      expect(controller.state, equals(SearchState.empty));
    });

    test('Tracks and removes recent queries', () async {
      await controller.executeSearch('بحث 1');
      await controller.executeSearch('بحث 2');

      expect(controller.recentQueries.length, equals(2));
      expect(controller.recentQueries.first, equals('بحث 2'));

      controller.removeRecentQuery('بحث 1');
      expect(controller.recentQueries.length, equals(1));

      controller.clearRecentQueries();
      expect(controller.recentQueries, isEmpty);
    });
  });
}
