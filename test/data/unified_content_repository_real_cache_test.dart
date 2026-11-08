import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/data/unified_content_repository.dart';

void main() {
  group('UnifiedContentRepository Real Caching & Query Tests', () {
    late UnifiedContentRepository repository;

    setUp(() {
      repository = UnifiedContentRepository();
      repository.clearCaches();
    });

    test('Starts with empty cache and unverified load status', () {
      expect(repository.isLoaded, isFalse);
      expect(repository.categoryCount, 0);
      expect(repository.verbCount, 0);
    });

    test('Populates and retrieves concrete categories with full multilingual metadata', () {
      final category = ContentCategory.fromJson({
        'category_id': 'cat_test_001',
        'title': {
          'ar': 'حِجَارَةُ القِرَاءَةِ البِلَّوْرِيَّةُ',
          'de': 'Kristall-Lesesteine',
          'en': 'Crystal Reading Stones',
        },
        'level': 'B1',
        'vocabulary': [
          {'id': 'item_1', 'ar': 'عَدَسَةٌ', 'de': 'Linse', 'en': 'lens'}
        ]
      });

      repository.registerCategory(category);
      expect(repository.categoryCount, 1);

      final fetched = repository.getCategoryById('cat_test_001');
      expect(fetched, isNotNull);
      expect(fetched!.titleAr, contains('حِجَارَةُ القِرَاءَةِ'));
      expect(fetched.titleDe, equals('Kristall-Lesesteine'));
      expect(fetched.titleEn, equals('Crystal Reading Stones'));
      expect(fetched.items.length, 1);
    });

    test('Populates and retrieves concrete verbs with complete conjugations', () {
      final verb = ContentVerb.fromJson({
        'verb_id': 'verb_test_001',
        'root': 'ك - ب - ر',
        'trilingual': {
          'ar': {'infinitive': 'تَكْبِيرٌ', 'past': 'كَبَّرَ'},
          'de': {'infinitive': 'vergrößern'},
          'en': {'infinitive': 'to magnify'}
        }
      });

      repository.registerVerb(verb);
      expect(repository.verbCount, 1);

      final fetched = repository.getVerbById('verb_test_001');
      expect(fetched, isNotNull);
      expect(fetched!.root, equals('ك - ب - ر'));
      expect(fetched.infinitiveDe, equals('vergrößern'));
      expect(fetched.infinitiveEn, equals('to magnify'));
    });
  });
}
