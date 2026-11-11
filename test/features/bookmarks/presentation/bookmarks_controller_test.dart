import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/database/sqlite_database_service.dart';
import 'package:trilingual_learning_lab/features/bookmarks/presentation/controllers/bookmarks_controller.dart';

void main() {
  group('BookmarksController Saved Study Hub State', () {
    late SqliteDatabaseService db;
    late BookmarksController controller;

    setUp(() async {
      db = SqliteDatabaseService();
      await db.initialize();

      controller = BookmarksController(
        databaseService: db,
        initialBookmarks: [
          UserBookmarkItem(
            id: 'bm_vocab_1',
            entityId: 'item_astrolabe',
            entityType: 'vocabulary',
            titleAr: 'الشَّبَكَةُ العَنْكَبُوتِيَّةُ',
            titleDe: 'Die Rete',
            titleEn: 'The Rete',
            createdAt: DateTime(2026, 11, 10, 10, 0),
          ),
          UserBookmarkItem(
            id: 'bm_verb_1',
            entityId: 'verb_magnify',
            entityType: 'verb',
            titleAr: 'كَبَّرَ - يُكَبِّرُ',
            titleDe: 'vergrößern',
            titleEn: 'to magnify',
            createdAt: DateTime(2026, 11, 10, 11, 0),
          ),
        ],
      );
    });

    test('Initializes with all bookmarks and default filter', () {
      expect(controller.totalBookmarks, equals(2));
      expect(controller.activeFilter, equals(BookmarkFilterType.all));
      expect(controller.filteredBookmarks.length, equals(2));
    });

    test('Filters bookmarks by entityType accurately', () {
      controller.setFilter(BookmarkFilterType.vocabulary);
      expect(controller.filteredBookmarks.length, equals(1));
      expect(controller.filteredBookmarks.first.id, equals('bm_vocab_1'));

      controller.setFilter(BookmarkFilterType.verb);
      expect(controller.filteredBookmarks.length, equals(1));
      expect(controller.filteredBookmarks.first.id, equals('bm_verb_1'));
    });

    test('Adds new bookmark and updates study notes', () async {
      final newBookmark = UserBookmarkItem(
        id: 'bm_grammar_1',
        entityId: 'grammar_quadrant',
        entityType: 'grammar',
        titleAr: 'أُسْلُوبُ الشَّرْطِ',
        titleDe: 'Konditionalsatz',
        titleEn: 'Conditional clause',
        createdAt: DateTime.now(),
      );

      await controller.addBookmark(newBookmark);
      expect(controller.totalBookmarks, equals(3));

      await controller.updateNote('bm_grammar_1', 'قَاعِدَةٌ مُهِمَّةٌ لِلِامْتِحَانِ');
      final updated = controller.filteredBookmarks.firstWhere((b) => b.id == 'bm_grammar_1');
      expect(updated.note, equals('قَاعِدَةٌ مُهِمَّةٌ لِلِامْتِحَانِ'));
    });

    test('Removes bookmark from memory and database', () async {
      expect(controller.totalBookmarks, equals(2));
      await controller.removeBookmark('bm_vocab_1');
      expect(controller.totalBookmarks, equals(1));
      expect(controller.filteredBookmarks.any((b) => b.id == 'bm_vocab_1'), isFalse);
    });
  });
}
