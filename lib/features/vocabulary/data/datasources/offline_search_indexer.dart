import '../../../../core/utils/arabic_text_shaper.dart';

class SearchIndexEntry {
  final String conceptId;
  final String categoryId;
  final String token;
  const SearchIndexEntry({required this.conceptId, required this.categoryId, required this.token});
}

class OfflineSearchIndexer {
  final Map<String, List<SearchIndexEntry>> _index = {};

  void indexConcept({
    required String conceptId,
    required String categoryId,
    required String arabic,
    required String german,
    required String english,
  }) {
    final normalizedAr = ArabicTextShaper.normalize(arabic).toLowerCase();
    final de = german.toLowerCase();
    final en = english.toLowerCase();

    final allTokens = {...normalizedAr.split(' '), ...de.split(' '), ...en.split(' ')}
      ..removeWhere((t) => t.length < 2);

    for (final token in allTokens) {
      _index.putIfAbsent(token, () => []).add(
        SearchIndexEntry(conceptId: conceptId, categoryId: categoryId, token: token),
      );
    }
  }

  List<String> query(String text) {
    final clean = ArabicTextShaper.normalize(text).toLowerCase().trim();
    if (clean.isEmpty) return [];

    final results = <String>{};
    for (final entry in _index.entries) {
      if (entry.key.contains(clean)) {
        for (final item in entry.value) {
          results.add(item.conceptId);
        }
      }
    }
    return results.toList();
  }
}
