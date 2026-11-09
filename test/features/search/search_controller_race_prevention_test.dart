import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/data/unified_content_repository.dart';
import 'package:trilingual_learning_lab/features/search/presentation/controllers/search_controller.dart';

void main() {
  group('SearchController Generation Token & Race Prevention Tests', () {
    late UnifiedContentRepository repository;

    setUp(() {
      repository = UnifiedContentRepository();
      repository.clearCaches();

      repository.registerCategory(ContentCategory(
        id: 'cat_astronomy',
        titleAr: 'عِلْمُ الفَلَكِ',
        titleDe: 'Astronomie',
        titleEn: 'Astronomy',
        level: 'B1',
        items: [],
      ));

      repository.registerCategory(ContentCategory(
        id: 'cat_optics',
        titleAr: 'البَصَرِيَّاتُ وَالعَدَسَاتُ',
        titleDe: 'Optik und Linsen',
        titleEn: 'Optics and Lenses',
        level: 'B1',
        items: [],
      ));
    });

    test('Initializes with empty search state', () {
      final controller = SearchController(repository: repository);
      expect(controller.state.query, isEmpty);
      expect(controller.state.results, isEmpty);
      expect(controller.state.isSearching, isFalse);
      controller.dispose();
    });

    test('Finds relevant multilingual matches across Arabic and German', () async {
      final controller = SearchController(repository: repository);
      controller.onQueryChanged('فلك');

      // Allow debounce timer to fire
      await Future<void>.delayed(const Duration(milliseconds: 350));

      expect(controller.state.results.length, equals(1));
      expect(controller.state.results.first.id, equals('cat_astronomy'));
      expect(controller.state.results.first.titleDe, equals('Astronomie'));

      controller.dispose();
    });

    test('Rejects stale query results when query is cleared rapidly', () async {
      final controller = SearchController(repository: repository);
      controller.onQueryChanged('Optik');
      controller.clearSearch(); // Immediately clears before timer fires

      await Future<void>.delayed(const Duration(milliseconds: 350));

      // Proves stale Optik results were discarded and state remains clean
      expect(controller.state.results, isEmpty);
      expect(controller.state.isSearching, isFalse);

      controller.dispose();
    });
  });
}
