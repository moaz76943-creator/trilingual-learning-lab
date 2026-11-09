import 'package:flutter/foundation.dart';
import '../../../../core/linguistics/arabic_diacritics_service.dart';

enum SearchEntityType {
  category,
  verb,
  dialogue,
  sentence,
  grammarRule,
}

class SearchResultItem {
  final String id;
  final SearchEntityType entityType;
  final String titleAr;
  final String titleDe;
  final String titleEn;
  final String matchedField;
  final String matchedText;
  final int relevanceScore;
  final Map<String, dynamic> metadata;

  const SearchResultItem({
    required this.id,
    required this.entityType,
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
    required this.matchedField,
    required this.matchedText,
    required this.relevanceScore,
    this.metadata = const {},
  });
}

class IndexedDocument {
  final String id;
  final SearchEntityType entityType;
  final String titleAr;
  final String titleDe;
  final String titleEn;
  final Map<String, String> searchableFields;
  final Map<String, dynamic> metadata;

  const IndexedDocument({
    required this.id,
    required this.entityType,
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
    required this.searchableFields,
    this.metadata = const {},
  });
}

/// Trilingual search indexer supporting diacritic-insensitive, umlaut-tolerant,
/// multi-entity full-text queries with relevance ranking.
class TrilingualSearchIndexer {
  final List<IndexedDocument> _documents = [];

  int get indexedCount => _documents.length;

  void addDocument(IndexedDocument doc) {
    _documents.removeWhere((d) => d.id == doc.id && d.entityType == doc.entityType);
    _documents.add(doc);
  }

  void addAll(List<IndexedDocument> docs) {
    for (final doc in docs) {
      addDocument(doc);
    }
  }

  void clear() {
    _documents.clear();
  }

  /// Searches the index across Arabic, German, and English fields.
  /// Ranks results by:
  /// - Exact match: 100 points
  /// - Prefix match: 50 points
  /// - Substring match: 25 points
  /// - Primary title field boost: +15 points
  List<SearchResultItem> search(String query, {SearchEntityType? filterType, int limit = 20}) {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return const [];

    final normQuery = ArabicDiacriticsService.normalizeForSearch(cleanQuery);
    final results = <SearchResultItem>[];

    for (final doc in _documents) {
      if (filterType != null && doc.entityType != filterType) {
        continue;
      }

      int bestScore = 0;
      String bestField = '';
      String bestMatchedText = '';

      for (final entry in doc.searchableFields.entries) {
        final rawText = entry.value;
        if (rawText.isEmpty) continue;

        final normText = ArabicDiacriticsService.normalizeForSearch(rawText);
        int fieldScore = 0;

        if (normText == normQuery) {
          fieldScore = 100;
        } else if (normText.startsWith(normQuery)) {
          fieldScore = 50;
        } else if (normText.contains(normQuery)) {
          fieldScore = 25;
        }

        if (fieldScore > 0) {
          if (entry.key.contains('title')) {
            fieldScore += 15;
          }

          if (fieldScore > bestScore) {
            bestScore = fieldScore;
            bestField = entry.key;
            bestMatchedText = rawText;
          }
        }
      }

      if (bestScore > 0) {
        results.add(SearchResultItem(
          id: doc.id,
          entityType: doc.entityType,
          titleAr: doc.titleAr,
          titleDe: doc.titleDe,
          titleEn: doc.titleEn,
          matchedField: bestField,
          matchedText: bestMatchedText,
          relevanceScore: bestScore,
          metadata: doc.metadata,
        ));
      }
    }

    // Sort descending by relevance score
    results.sort((a, b) => b.relevanceScore.compareTo(a.relevanceScore));

    if (results.length > limit) {
      return results.sublist(0, limit);
    }
    return results;
  }
}
