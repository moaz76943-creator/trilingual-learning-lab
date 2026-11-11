import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/data/adapters/content_schema_adapter.dart';
import 'package:trilingual_learning_lab/features/vocabulary/presentation/controllers/category_detail_controller.dart';

void main() {
  group('CategoryDetailController Vocabulary Studio State', () {
    late CanonicalCategory sampleCategory;
    late CategoryDetailController controller;

    setUp(() {
      sampleCategory = const CanonicalCategory(
        id: 'cat_astrolabe_001',
        title: TrilingualText(
          ar: 'صِنَاعَةُ الأَسْطُرْلاَبِ',
          de: 'Bau des Astrolabiums',
          en: 'Astrolabe Construction',
        ),
        level: 'B1',
        items: [
          CanonicalVocabItem(
            id: 'item_1',
            ar: 'الشَّبَكَةُ العَنْكَبُوتِيَّةُ',
            de: 'Die Rete',
            en: 'The Rete',
          ),
          CanonicalVocabItem(
            id: 'item_2',
            ar: 'العِضَادَةُ',
            de: 'Die Alhidade',
            en: 'The Alidade',
          ),
        ],
      );

      controller = CategoryDetailController(category: sampleCategory);
    });

    test('Initializes with list view mode and correct totals', () {
      expect(controller.viewMode, equals(CategoryViewMode.listView));
      expect(controller.totalItems, equals(2));
      expect(controller.masteredCount, equals(0));
      expect(controller.masteryPercentage, equals(0.0));
      expect(controller.activeSwiperIndex, equals(0));
    });

    test('Toggles view mode between listView and cardSwiper', () {
      controller.setViewMode(CategoryViewMode.cardSwiper);
      expect(controller.viewMode, equals(CategoryViewMode.cardSwiper));

      controller.setViewMode(CategoryViewMode.listView);
      expect(controller.viewMode, equals(CategoryViewMode.listView));
    });

    test('Toggles bookmarks and mastery percentages', () {
      expect(controller.isBookmarked('item_1'), isFalse);
      controller.toggleBookmark('item_1');
      expect(controller.isBookmarked('item_1'), isTrue);

      controller.toggleMastery('item_1');
      expect(controller.masteredCount, equals(1));
      expect(controller.masteryPercentage, equals(50.0)); // 1 of 2 = 50%
    });

    test('Generates valid phonetic IPA transcription for category items', () {
      final phonetics = controller.getPhonetics(sampleCategory.items.first);
      expect(phonetics.arabic.ipa, contains('ʃ')); // Sheen
      expect(phonetics.german.ipa, contains('diː'));
      expect(phonetics.english.ipa, contains('θ'));
    });
  });
}
