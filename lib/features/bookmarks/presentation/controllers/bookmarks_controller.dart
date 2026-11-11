import 'package:flutter/foundation.dart';
import '../../../../core/database/sqlite_database_service.dart';

enum BookmarkFilterType {
  all,
  vocabulary,
  verb,
  dialogue,
  grammar,
}

/// Rich domain model representing a saved bookmark with trilingual translations.
class UserBookmarkItem {
  final String id;
  final String entityId;
  final String entityType; // 'vocabulary', 'verb', 'dialogue', 'grammar'
  final String titleAr;
  final String titleDe;
  final String titleEn;
  final String note;
  final DateTime createdAt;

  const UserBookmarkItem({
    required this.id,
    required this.entityId,
    required this.entityType,
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
    this.note = '',
    required this.createdAt,
  });

  UserBookmarkItem copyWith({String? note}) {
    return UserBookmarkItem(
      id: id,
      entityId: entityId,
      entityType: entityType,
      titleAr: titleAr,
      titleDe: titleDe,
      titleEn: titleEn,
      note: note ?? this.note,
      createdAt: createdAt,
    );
  }
}

/// Controller governing the interactive bookmarks studio, notes, and filters.
class BookmarksController extends ChangeNotifier {
  final SqliteDatabaseService databaseService;
  final List<UserBookmarkItem> _bookmarks = [];
  BookmarkFilterType _activeFilter = BookmarkFilterType.all;
  bool _isLoading = false;

  BookmarksController({
    required this.databaseService,
    List<UserBookmarkItem> initialBookmarks = const [],
  }) {
    _bookmarks.addAll(initialBookmarks);
  }

  bool get isLoading => _isLoading;
  BookmarkFilterType get activeFilter => _activeFilter;
  int get totalBookmarks => _bookmarks.length;

  /// Returns bookmarks filtered by active filter type.
  List<UserBookmarkItem> get filteredBookmarks {
    if (_activeFilter == BookmarkFilterType.all) {
      return List.unmodifiable(_bookmarks);
    }
    final typeStr = _activeFilter.name;
    return _bookmarks.where((b) => b.entityType == typeStr).toList();
  }

  /// Sets active filter chip.
  void setFilter(BookmarkFilterType filter) {
    if (_activeFilter != filter) {
      _activeFilter = filter;
      notifyListeners();
    }
  }

  /// Loads bookmarks from SQLite database.
  Future<void> loadBookmarks() async {
    _isLoading = true;
    notifyListeners();

    try {
      final rows = await databaseService.query('bookmarks', orderByField: 'created_at', descending: true);
      _bookmarks.clear();

      for (final r in rows) {
        _bookmarks.add(UserBookmarkItem(
          id: r['id'] as String,
          entityId: r['entity_id'] as String,
          entityType: r['entity_type'] as String,
          titleAr: r['title_ar'] as String? ?? 'مُفْرَدَةٌ مَحْفُوظَةٌ',
          titleDe: r['title_de'] as String? ?? 'Gespeichertes Element',
          titleEn: r['title_en'] as String? ?? 'Saved Item',
          note: r['note'] as String? ?? '',
          createdAt: DateTime.tryParse(r['created_at'] as String? ?? '') ?? DateTime.now(),
        ));
      }
    } catch (_) {
      // In offline/in-memory mode, retain existing bookmarks
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new bookmark and commits to database.
  Future<void> addBookmark(UserBookmarkItem item) async {
    _bookmarks.removeWhere((b) => b.id == item.id);
    _bookmarks.insert(0, item);
    notifyListeners();

    try {
      await databaseService.insert('bookmarks', {
        'id': item.id,
        'entity_id': item.entityId,
        'entity_type': item.entityType,
        'title_ar': item.titleAr,
        'title_de': item.titleDe,
        'title_en': item.titleEn,
        'note': item.note,
        'created_at': item.createdAt.toIso8601String(),
      });
    } catch (_) {}
  }

  /// Updates custom study note for [bookmarkId].
  Future<void> updateNote(String bookmarkId, String newNote) async {
    final idx = _bookmarks.indexWhere((b) => b.id == bookmarkId);
    if (idx != -1) {
      _bookmarks[idx] = _bookmarks[idx].copyWith(note: newNote);
      notifyListeners();

      try {
        await databaseService.updateById('bookmarks', bookmarkId, {'note': newNote});
      } catch (_) {}
    }
  }

  /// Removes bookmark by [bookmarkId].
  Future<void> removeBookmark(String bookmarkId) async {
    _bookmarks.removeWhere((b) => b.id == bookmarkId);
    notifyListeners();

    try {
      await databaseService.deleteById('bookmarks', bookmarkId);
    } catch (_) {}
  }
}
