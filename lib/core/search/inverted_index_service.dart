import 'package:flutter/foundation.dart';
import 'morphological_search_tokenizer.dart';

/// Inverted index posting pointing to a specific indexed document field.
class InvertedIndexPosting {
  final String entityId;
  final String entityType;
  final int weight;

  const InvertedIndexPosting({
    required this.entityId,
    required this.entityType,
    required this.weight,
  });
}

/// In-memory inverted index providing O(1) multi-term keyword search lookups.
class InvertedIndexService {
  final Map<String, List<InvertedIndexPosting>> _index = {};
  int _documentCount = 0;

  int get totalIndexedTokens => _index.length;
  int get documentCount => _documentCount;

  /// Indexes an entity document with multiple searchable fields.
  void addDocument({
    required String entityId,
    required String entityType,
    required Map<String, String> fields,
  }) {
    _documentCount++;

    for (final entry in fields.entries) {
      final fieldName = entry.key;
      final text = entry.value;
      if (text.trim().isEmpty) continue;

      final isTitle = fieldName.contains('title');
      final weight = isTitle ? 30 : 15;

      final tokens = MorphologicalSearchTokenizer.tokenize(text);

      for (final token in tokens) {
        final postings = _index.putIfAbsent(token, () => []);
        // Avoid duplicate postings for same entity within same token
        if (!postings.any((p) => p.entityId == entityId)) {
          postings.add(InvertedIndexPosting(
            entityId: entityId,
            entityType: entityType,
            weight: weight,
          ));
        }
      }
    }
  }

  /// Searches the inverted index using multi-token intersection and scoring.
  List<String> search(String query, {String? entityTypeFilter, int limit = 25}) {
    final clean = query.trim();
    if (clean.isEmpty) return const [];

    final queryTokens = MorphologicalSearchTokenizer.tokenize(clean);
    if (queryTokens.isEmpty) return const [];

    final scoreMap = <String, int>{};

    for (final token in queryTokens) {
      final postings = _index[token];
      if (postings != null) {
        for (final p in postings) {
          if (entityTypeFilter != null && p.entityType != entityTypeFilter) {
            continue;
          }
          scoreMap[p.entityId] = (scoreMap[p.entityId] ?? 0) + p.weight;
        }
      }
    }

    final sortedEntries = scoreMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final results = sortedEntries.map((e) => e.key).toList();
    if (results.length > limit) {
      return results.sublist(0, limit);
    }
    return results;
  }

  /// Clears the entire inverted index.
  void clear() {
    _index.clear();
    _documentCount = 0;
  }
}
