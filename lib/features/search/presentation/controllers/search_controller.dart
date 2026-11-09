import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:trilingual_learning_lab/data/unified_content_repository.dart';

/// Search result item encapsulating verified trilingual match context.
class SearchResultItem {
  final String id;
  final String type; // 'category', 'verb', or 'vocabulary'
  final String titleAr;
  final String titleDe;
  final String titleEn;
  final double score;

  const SearchResultItem({
    required this.id,
    required this.type,
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
    this.score = 1.0,
  });
}

/// State object representing search UI state.
class SearchState {
  final String query;
  final List<SearchResultItem> results;
  final bool isSearching;
  final String? errorMessage;

  const SearchState({
    this.query = '',
    this.results = const [],
    this.isSearching = false,
    this.errorMessage,
  });

  SearchState copyWith({
    String? query,
    List<SearchResultItem>? results,
    bool? isSearching,
    String? errorMessage,
  }) {
    return SearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      isSearching: isSearching ?? this.isSearching,
      errorMessage: errorMessage,
    );
  }
}

/// Authoritative SearchController preventing asynchronous race conditions.
/// Uses monotonic generation tokens to strictly reject stale or out-of-order query responses.
class SearchController extends ChangeNotifier {
  final UnifiedContentRepository _repository;
  SearchState _state = const SearchState();
  Timer? _debounceTimer;
  int _currentGeneration = 0;
  bool _isDisposed = false;

  SearchController({UnifiedContentRepository? repository})
      : _repository = repository ?? UnifiedContentRepository();

  SearchState get state => _state;
  bool get isDisposed => _isDisposed;

  /// Submits a query with 300ms debounce and generation tracking.
  void onQueryChanged(String query) {
    if (_isDisposed) return;
    _debounceTimer?.cancel();

    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) {
      _currentGeneration++;
      _state = const SearchState();
      notifyListeners();
      return;
    }

    _state = _state.copyWith(query: cleanQuery, isSearching: true, errorMessage: null);
    notifyListeners();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _executeSearch(cleanQuery);
    });
  }

  /// Executes query against content repository and checks generation token before committing state.
  Future<void> _executeSearch(String query) async {
    if (_isDisposed) return;
    final int requestGeneration = ++_currentGeneration;

    try {
      final List<SearchResultItem> matchedResults = [];
      final lowerQuery = query.toLowerCase();

      // Search categories
      final categories = _repository.getAllCategories();
      for (final cat in categories) {
        if (cat.titleAr.contains(query) ||
            cat.titleDe.toLowerCase().contains(lowerQuery) ||
            cat.titleEn.toLowerCase().contains(lowerQuery)) {
          matchedResults.add(SearchResultItem(
            id: cat.id,
            type: 'category',
            titleAr: cat.titleAr,
            titleDe: cat.titleDe,
            titleEn: cat.titleEn,
          ));
        }
      }

      // Search verbs
      final verbs = _repository.getAllVerbs();
      for (final verb in verbs) {
        if (verb.root.contains(query) ||
            verb.infinitiveAr.contains(query) ||
            verb.infinitiveDe.toLowerCase().contains(lowerQuery) ||
            verb.infinitiveEn.toLowerCase().contains(lowerQuery)) {
          matchedResults.add(SearchResultItem(
            id: verb.id,
            type: 'verb',
            titleAr: '${verb.infinitiveAr} (${verb.root})',
            titleDe: verb.infinitiveDe,
            titleEn: verb.infinitiveEn,
          ));
        }
      }

      // Race-Condition Guard: Commit results strictly if this response matches the latest generation
      if (!_isDisposed && requestGeneration == _currentGeneration) {
        _state = _state.copyWith(
          results: matchedResults,
          isSearching: false,
          errorMessage: null,
        );
        notifyListeners();
      } else {
        debugPrint('Rejected stale search result for generation #$requestGeneration (current: #$_currentGeneration)');
      }
    } catch (e) {
      if (!_isDisposed && requestGeneration == _currentGeneration) {
        _state = _state.copyWith(
          isSearching: false,
          errorMessage: 'حدث خطأ أثناء البحث: $e',
        );
        notifyListeners();
      }
    }
  }

  void clearSearch() {
    _currentGeneration++;
    _debounceTimer?.cancel();
    _state = const SearchState();
    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _debounceTimer?.cancel();
    super.dispose();
  }
}
