import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/entities/vocabulary_concept.dart';
import '../../domain/repositories/content_repository.dart';

/// نظام التحميل التدريجي للمفردات Lazy Vocabulary Loader لتوفير الذاكرة وسلاسة التمرير
class LazyVocabLoader extends ChangeNotifier {
  final ContentRepository _repository;
  final int pageSize;

  List<VocabularyConcept> _allConcepts = [];
  final List<VocabularyConcept> _visibleConcepts = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 0;

  LazyVocabLoader(this._repository, {this.pageSize = 15});

  List<VocabularyConcept> get visibleConcepts => _visibleConcepts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  int get totalCount => _allConcepts.length;

  Future<void> loadCategory(String categoryId) async {
    _isLoading = true;
    _currentPage = 0;
    _visibleConcepts.clear();
    _hasMore = true;
    notifyListeners();

    final result = await _repository.getVocabularyByCategory(categoryId);
    result.fold(
      (failure) {
        _allConcepts = [];
        _isLoading = false;
        _hasMore = false;
        notifyListeners();
      },
      (concepts) {
        _allConcepts = concepts;
        _loadNextPageSync();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void loadNextPage() {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    notifyListeners();

    Future.microtask(() {
      _loadNextPageSync();
      _isLoading = false;
      notifyListeners();
    });
  }

  void _loadNextPageSync() {
    final start = _currentPage * pageSize;
    if (start >= _allConcepts.length) {
      _hasMore = false;
      return;
    }

    final end = (start + pageSize).clamp(0, _allConcepts.length);
    _visibleConcepts.addAll(_allConcepts.sublist(start, end));
    _currentPage++;

    if (_visibleConcepts.length >= _allConcepts.length) {
      _hasMore = false;
    }
  }

  void reset() {
    _allConcepts.clear();
    _visibleConcepts.clear();
    _currentPage = 0;
    _hasMore = true;
    _isLoading = false;
    notifyListeners();
  }
}
