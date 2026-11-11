import 'package:flutter/foundation.dart';
import '../../domain/services/verb_conjugation_engine.dart';

enum VerbTenseTab {
  past,
  present,
  imperative,
  verbalNoun,
}

/// Controller governing the interactive verb conjugation studio and declension table.
class VerbConjugationController extends ChangeNotifier {
  final TrilingualVerbParadigm paradigm;
  VerbTenseTab _activeTab = VerbTenseTab.past;
  String? _selectedPronoun;
  bool _isBookmarked = false;

  VerbConjugationController({
    required this.paradigm,
    bool initialBookmarked = false,
  }) : _isBookmarked = initialBookmarked;

  VerbTenseTab get activeTab => _activeTab;
  String? get selectedPronoun => _selectedPronoun;
  bool get isBookmarked => _isBookmarked;

  String get rootAr => paradigm.rootAr;
  String get infinitiveDe => paradigm.german.infinitive;
  String get infinitiveEn => paradigm.english.infinitive;

  /// Changes the active grammatical tense tab.
  void selectTab(VerbTenseTab tab) {
    if (_activeTab != tab) {
      _activeTab = tab;
      notifyListeners();
    }
  }

  /// Filters by specific subject pronoun or clears filter.
  void filterPronoun(String? pronounKey) {
    _selectedPronoun = pronounKey;
    notifyListeners();
  }

  /// Toggles bookmark state for this verb paradigm.
  void toggleBookmark() {
    _isBookmarked = !_isBookmarked;
    notifyListeners();
  }

  /// Resolves the Arabic conjugated form for the current tab and pronoun.
  String get activeArabicForm {
    switch (_activeTab) {
      case VerbTenseTab.past:
        return VerbConjugationEngine.resolveForm(
          paradigm,
          language: 'ar',
          tense: 'past',
          person: _selectedPronoun,
        );
      case VerbTenseTab.present:
        return VerbConjugationEngine.resolveForm(
          paradigm,
          language: 'ar',
          tense: 'present',
          person: _selectedPronoun,
        );
      case VerbTenseTab.imperative:
        return VerbConjugationEngine.resolveForm(
          paradigm,
          language: 'ar',
          tense: 'imperative',
        );
      case VerbTenseTab.verbalNoun:
        return VerbConjugationEngine.resolveForm(
          paradigm,
          language: 'ar',
          tense: 'masdar',
        );
    }
  }

  /// Resolves the German conjugated form for the current tab.
  String get activeGermanForm {
    switch (_activeTab) {
      case VerbTenseTab.past:
        return VerbConjugationEngine.resolveForm(
          paradigm,
          language: 'de',
          tense: 'preterite',
          person: _selectedPronoun,
        );
      case VerbTenseTab.present:
        return VerbConjugationEngine.resolveForm(
          paradigm,
          language: 'de',
          tense: 'present',
          person: _selectedPronoun,
        );
      case VerbTenseTab.imperative:
      case VerbTenseTab.verbalNoun:
        return VerbConjugationEngine.resolveForm(
          paradigm,
          language: 'de',
          tense: 'infinitive',
        );
    }
  }

  /// Resolves the English conjugated form for the current tab.
  String get activeEnglishForm {
    switch (_activeTab) {
      case VerbTenseTab.past:
        return VerbConjugationEngine.resolveForm(
          paradigm,
          language: 'en',
          tense: 'past',
          person: _selectedPronoun,
        );
      case VerbTenseTab.present:
        return VerbConjugationEngine.resolveForm(
          paradigm,
          language: 'en',
          tense: 'present_3rd',
          person: _selectedPronoun,
        );
      case VerbTenseTab.imperative:
      case VerbTenseTab.verbalNoun:
        return VerbConjugationEngine.resolveForm(
          paradigm,
          language: 'en',
          tense: 'infinitive',
        );
    }
  }

  /// Generates full trilingual pronoun declension rows for the current tense.
  List<Map<String, String>> get declensionRows {
    final rows = <Map<String, String>>[];
    final pronouns = [
      {'key': 'ana', 'arLabel': 'أَنَا', 'deLabel': 'ich', 'enLabel': 'I'},
      {'key': 'anta', 'arLabel': 'أَنْتَ', 'deLabel': 'du', 'enLabel': 'you'},
      {'key': 'huwa', 'arLabel': 'هُوَ', 'deLabel': 'er / sie / es', 'enLabel': 'he / she / it'},
      {'key': 'nahnu', 'arLabel': 'نَحْنُ', 'deLabel': 'wir', 'enLabel': 'we'},
    ];

    for (final p in pronouns) {
      if (_selectedPronoun != null && _selectedPronoun != p['key']) continue;

      final key = p['key']!;
      final arForm = paradigm.arabic.pronounForms[key] ?? activeArabicForm;
      final deForm = paradigm.german.presentForms[key] ?? activeGermanForm;
      final enForm = paradigm.english.presentForms[key] ?? activeEnglishForm;

      rows.add({
        'key': key,
        'pronounAr': p['arLabel']!,
        'formAr': arForm,
        'pronounDe': p['deLabel']!,
        'formDe': deForm,
        'pronounEn': p['enLabel']!,
        'formEn': enForm,
      });
    }

    return rows;
  }
}
