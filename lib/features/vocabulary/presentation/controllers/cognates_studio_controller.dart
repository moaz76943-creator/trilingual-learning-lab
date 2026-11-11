import 'package:flutter/foundation.dart';
import '../../domain/services/etymological_cognate_tracker.dart';

/// Controller governing the interactive etymological cognates studio and loanword explorer.
class CognatesStudioController extends ChangeNotifier {
  final List<CognateConnection> _allCognates;
  List<CognateConnection> _filteredCognates = [];
  String _searchQuery = '';
  String? _selectedEraFilter;
  final Set<String> _bookmarkedCognateIds = {};

  CognatesStudioController({
    List<CognateConnection>? initialCognates,
    Set<String> initialBookmarks = const {},
  }) : _allCognates = initialCognates ?? EtymologicalCognateTracker.allCognates {
    _filteredCognates = List.from(_allCognates);
    _bookmarkedCognateIds.addAll(initialBookmarks);
  }

  List<CognateConnection> get cognates => List.unmodifiable(_filteredCognates);
  String get searchQuery => _searchQuery;
  String? get selectedEraFilter => _selectedEraFilter;
  int get totalCognates => _allCognates.length;
  int get filteredCount => _filteredCognates.length;

  /// Returns unique historical transmission eras from the catalog.
  List<String> get availableEras {
    final eras = _allCognates.map((c) => c.historicalEra).toSet().toList();
    eras.sort();
    return eras;
  }

  /// Filters cognates by search text and optional historical era.
  void filterCognates({String? query, String? era}) {
    if (query != null) _searchQuery = query.trim();
    if (era != null) _selectedEraFilter = era.isEmpty ? null : era;

    var results = List<CognateConnection>.from(_allCognates);

    if (_searchQuery.isNotEmpty) {
      results = EtymologicalCognateTracker.findCognates(_searchQuery);
    }

    if (_selectedEraFilter != null) {
      results = results.where((c) => c.historicalEra.contains(_selectedEraFilter!)).toList();
    }

    _filteredCognates = results;
    notifyListeners();
  }

  /// Checks if a cognate connection is bookmarked.
  bool isBookmarked(String id) => _bookmarkedCognateIds.contains(id);

  /// Toggles bookmark state for a cognate.
  void toggleBookmark(String id) {
    if (_bookmarkedCognateIds.contains(id)) {
      _bookmarkedCognateIds.remove(id);
    } else {
      _bookmarkedCognateIds.add(id);
    }
    notifyListeners();
  }

  /// Clears active filters.
  void clearFilters() {
    _searchQuery = '';
    _selectedEraFilter = null;
    _filteredCognates = List.from(_allCognates);
    notifyListeners();
  }
}
