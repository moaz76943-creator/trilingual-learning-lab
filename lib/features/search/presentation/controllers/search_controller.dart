import 'dart:async';
import 'package:flutter/material.dart';
import '../../../vocabulary/domain/entities/vocabulary_concept.dart';
import '../../../vocabulary/domain/repositories/content_repository.dart';

/// متحكم البحث التفاعلي الفوري المزود بـ Debouncing وتدفقات Stream
class TrilingualSearchController extends ChangeNotifier {
  final ContentRepository _repository;
  Timer? _debounceTimer;

  String _currentQuery = '';
  List<VocabularyConcept> _searchResults = [];
  bool _isLoading = false;

  TrilingualSearchController(this._repository);

  String get currentQuery => _currentQuery;
  List<VocabularyConcept> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  /// البحث باللغات الثلاث مع تأخير ذكي 300ms لمنع العبء وحفظ استقرار الذاكرة
  void onQueryChanged(String query) {
    _currentQuery = query;
    _debounceTimer?.cancel();

    if (query.trim().isEmpty) {
      _searchResults = [];
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      final result = await _repository.searchVocabulary(query);
      result.fold(
        (failure) {
          _searchResults = [];
          _isLoading = false;
          notifyListeners();
        },
        (concepts) {
          _searchResults = concepts;
          _isLoading = false;
          notifyListeners();
        },
      );
    });
  }

  void clearSearch() {
    _currentQuery = '';
    _searchResults = [];
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
