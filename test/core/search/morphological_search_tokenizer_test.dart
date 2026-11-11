import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/search/inverted_index_service.dart';
import 'package:trilingual_learning_lab/core/search/morphological_search_tokenizer.dart';

void main() {
  group('MorphologicalSearchTokenizer & InvertedIndexService Critical Tests', () {
    test('Tokenizes vocalized Arabic and strips prefixes cleanly', () {
      const sentence = 'بِالأَسْطُرْلاَبِ وَالعِضَادَةِ';
      final tokens = MorphologicalSearchTokenizer.tokenizeArabic(sentence);

      // Should extract both prefixed and stripped stems
      expect(tokens.contains('اسطرلاب'), isTrue); // Stripped al- and bi-
      expect(tokens.contains('عضاده'), isTrue);   // Stripped al- and wa-
    });

    test('Tokenizes German text with umlauts and compound constituents', () {
      const german = 'Das Schattenquadrat';
      final tokens = MorphologicalSearchTokenizer.tokenizeGerman(german);

      expect(tokens.contains('schattenquadrat'), isTrue);
      expect(tokens.contains('quadrat'), isTrue); // Compound component extracted
    });

    test('InvertedIndexService indexes documents and performs O(1) keyword lookups', () {
      final indexService = InvertedIndexService();

      indexService.addDocument(
        entityId: 'cat_astrolabe',
        entityType: 'category',
        fields: {
          'title_ar': 'صِنَاعَةُ الأَسْطُرْلاَبِ',
          'title_de': 'Das Messingastrolabium',
          'title_en': 'Brass Astrolabe Construction',
        },
      );

      indexService.addDocument(
        entityId: 'verb_magnify',
        entityType: 'verb',
        fields: {
          'title_ar': 'كَبَّرَ - يُكَبِّرُ',
          'title_de': 'vergrößern',
          'title_en': 'to magnify',
        },
      );

      expect(indexService.documentCount, equals(2));
      expect(indexService.totalIndexedTokens, greaterThan(5));

      // Search with prefix-stripped Arabic token
      final resultsAr = indexService.search('بالاسطرلاب');
      expect(resultsAr.isNotEmpty, isTrue);
      expect(resultsAr.first, equals('cat_astrolabe'));

      // Search with German umlaut word
      final resultsDe = indexService.search('vergroessern');
      expect(resultsDe.isNotEmpty, isTrue);
      expect(resultsDe.first, equals('verb_magnify'));

      // Entity type filtering
      final resultsFiltered = indexService.search('اسطرلاب', entityTypeFilter: 'verb');
      expect(resultsFiltered.isEmpty, isTrue);
    });
  });
}
