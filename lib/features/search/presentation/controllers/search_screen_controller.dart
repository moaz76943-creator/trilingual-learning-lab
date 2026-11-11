import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/services/trilingual_search_indexer.dart';

enum SearchState {
  idle,
  searching,
  success,
  empty,
}

/// Controller governing live search queries, faceted filtering, and search history.
class SearchScreenController extends ChangeNotifier {
  final TrilingualSearchIndexer indexer;
  SearchState _state = SearchState.idle;
  String _currentQuery = '';
  SearchEntityType? _selectedFilter;
  List<SearchResultItem> _results = [];
  final List<String> _recentQueries = [];
  int _searchGeneration = 0;

  SearchScreenController({
    required this.indexer,
    List<String> initialRecentQueries = const [],
  }) {
    _recentQueries.addAll(initialRecentQueries);
  }

  SearchState get state => _state;
  String get currentQuery => _currentQuery;
  SearchEntityType? get selectedFilter => _selectedFilter;
  List<SearchResultItem> get results => List.unmodifiable(_results);
  List<String> get recentQueries => List.unmodifiable(_recentQueries);

  /// Updates active filter chip (null = all).
  void setFilter(SearchEntityType? filter) {
    if (_selectedFilter != filter) {
      _selectedFilter = filter;
      if (_currentQuery.trim().isNotEmpty) {
        executeSearch(_currentQuery);
      } else {
        notifyListeners();
      }
    }
  }

  /// Executes live search with monotonic generation tokens to prevent race conditions.
  Future<void> executeSearch(String query) async {
    final clean = query.trim();
    _currentQuery = query;

    if (clean.isEmpty) {
      _results = [];
      _state = SearchState.idle;
      notifyListeners();
      return;
    }

    final generation = ++_searchGeneration;
    _state = SearchState.searching;
    notifyListeners();

    // Perform indexed search
    final items = indexer.search(
      clean,
      filterType: _selectedFilter,
      limit: 30,
    );

    // Reject out-of-order stale search responses
    if (generation != _searchGeneration) return;

    _results = items;
    _state = items.isEmpty ? SearchState.empty : SearchState.success;

    // Track in recent queries if not already present
    if (clean.isNotEmpty && !_recentQueries.contains(clean)) {
      _recentQueries.insert(0, clean);
      if (_recentQueries.length > 10) {
        _recentQueries.removeLast();
      }
    }

    notifyListeners();
  }

  /// Clears the current search text and results.
  void clearQuery() {
    _currentQuery = '';
    _results = [];
    _state = SearchState.idle;
    notifyListeners();
  }

  /// Removes an individual query from search history.
  void removeRecentQuery(String query) {
    _recentQueries.remove(query);
    notifyListeners();
  }

  /// Clears all recent queries.
  void clearRecentQueries() {
    _recentQueries.clear();
    notifyListeners();
  }
}
