import 'package:flutter/foundation.dart';
import '../../../../core/audio/phonetic_synthesis_engine.dart';
import '../../../../data/adapters/content_schema_adapter.dart';

enum CategoryViewMode {
  listView,
  cardSwiper,
}

/// Controller governing the interactive category vocabulary detail session.
class CategoryDetailController extends ChangeNotifier {
  final CanonicalCategory category;
  CategoryViewMode _viewMode = CategoryViewMode.listView;
  int _activeSwiperIndex = 0;
  String? _currentlyPlayingItemId;
  final Set<String> _bookmarkedItemIds = {};
  final Set<String> _masteredItemIds = {};

  CategoryDetailController({
    required this.category,
    Set<String> initialBookmarks = const {},
  }) {
    _bookmarkedItemIds.addAll(initialBookmarks);
  }

  CategoryViewMode get viewMode => _viewMode;
  int get activeSwiperIndex => _activeSwiperIndex;
  String? get currentlyPlayingItemId => _currentlyPlayingItemId;
  int get totalItems => category.items.length;
  int get masteredCount => _masteredItemIds.length;

  double get masteryPercentage {
    if (category.items.isEmpty) return 0.0;
    return (_masteredItemIds.length / category.items.length) * 100.0;
  }

  /// Toggles between list view and swiper mode.
  void setViewMode(CategoryViewMode mode) {
    if (_viewMode != mode) {
      _viewMode = mode;
      notifyListeners();
    }
  }

  /// Updates active swiper card index.
  void setSwiperIndex(int index) {
    if (index >= 0 && index < category.items.length) {
      _activeSwiperIndex = index;
      notifyListeners();
    }
  }

  /// Checks if an item is bookmarked.
  bool isBookmarked(String itemId) => _bookmarkedItemIds.contains(itemId);

  /// Toggles bookmark state for [itemId].
  void toggleBookmark(String itemId) {
    if (_bookmarkedItemIds.contains(itemId)) {
      _bookmarkedItemIds.remove(itemId);
    } else {
      _bookmarkedItemIds.add(itemId);
    }
    notifyListeners();
  }

  /// Toggles mastery status for [itemId].
  void toggleMastery(String itemId) {
    if (_masteredItemIds.contains(itemId)) {
      _masteredItemIds.remove(itemId);
    } else {
      _masteredItemIds.add(itemId);
    }
    notifyListeners();
  }

  /// Plays audio pronunciation for [item] in specified [languageCode].
  Future<void> playItemAudio(CanonicalVocabItem item, String languageCode) async {
    _currentlyPlayingItemId = '${item.id}_$languageCode';
    notifyListeners();

    // In production Flutter environment, calls TrilingualAudioPlayerService.
    // Simulated async playback delay for state coordination.
    await Future.delayed(const Duration(milliseconds: 300));

    _currentlyPlayingItemId = null;
    notifyListeners();
  }

  /// Resolves the trilingual phonetic IPA comparison for [item].
  TrilingualPhoneticComparison getPhonetics(CanonicalVocabItem item) {
    return PhoneticSynthesisEngine.compare(
      arVocalized: item.ar,
      deText: item.de,
      enText: item.en,
    );
  }
}
