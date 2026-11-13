import 'package:flutter/foundation.dart';

enum CollocationCategory {
  adjectiveNoun,      // صفة وموصوف (Adjective + Noun / Adjektiv + Substantiv)
  verbNounSupport,    // الفعل الإسنادي والمفعول (Support Verb / Funktionsverbgefüge)
  verbPrepositional,  // الفعل والجار الملازم (Verb + Fixed Preposition / Feste Präposition)
  adverbialIntensifier // الظرف المؤكد المقترن (Adverb + Verb/Adjective)
}

class CollocationEntry {
  final String id;
  final CollocationCategory category;
  final String baseConcept;
  final String canonicalCollocationAr; // مشكول شكلاً تاماً
  final String canonicalCollocationEn;
  final String canonicalCollocationDe;
  final String literalMisleadingAr; // التعبير الحرفي الخاطئ الشائع
  final String literalMisleadingEn;
  final String literalMisleadingDe;
  final double mutualInformationScore; // معيار التوارد الإحصائي PMI (مثلاً 7.5 - 10.0)
  final String contextualExampleAr;
  final String contextualExampleEn;
  final String contextualExampleDe;
  final String linguisticRationaleAr;

  const CollocationEntry({
    required this.id,
    required this.category,
    required this.baseConcept,
    required this.canonicalCollocationAr,
    required this.canonicalCollocationEn,
    required this.canonicalCollocationDe,
    required this.literalMisleadingAr,
    required this.literalMisleadingEn,
    required this.literalMisleadingDe,
    required this.mutualInformationScore,
    required this.contextualExampleAr,
    required this.contextualExampleEn,
    required this.contextualExampleDe,
    required this.linguisticRationaleAr,
  });
}

class CollocationMatrixState {
  final CollocationCategory selectedCategory;
  final List<CollocationEntry> entries;
  final String selectedEntryId;
  final bool showNegativeTransferAlerts;
  final bool showCorpusConcordance;

  const CollocationMatrixState({
    this.selectedCategory = CollocationCategory.adjectiveNoun,
    this.entries = const [],
    this.selectedEntryId = 'col_adj_01',
    this.showNegativeTransferAlerts = true,
    this.showCorpusConcordance = true,
  });

  CollocationEntry? get currentEntry {
    if (entries.isEmpty) return null;
    return entries.firstWhere(
      (e) => e.id == selectedEntryId,
      orElse: () => entries.first,
    );
  }

  CollocationMatrixState copyWith({
    CollocationCategory? selectedCategory,
    List<CollocationEntry>? entries,
    String? selectedEntryId,
    bool? showNegativeTransferAlerts,
    bool? showCorpusConcordance,
  }) {
    return CollocationMatrixState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      entries: entries ?? this.entries,
      selectedEntryId: selectedEntryId ?? this.selectedEntryId,
      showNegativeTransferAlerts: showNegativeTransferAlerts ?? this.showNegativeTransferAlerts,
      showCorpusConcordance: showCorpusConcordance ?? this.showCorpusConcordance,
    );
  }
}

class CollocationMatrixController extends ChangeNotifier {
  CollocationMatrixState _state = const CollocationMatrixState();
  CollocationMatrixState get state => _state;

  CollocationMatrixController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultEntries = [
      // 1. صفة وموصوف: مطر غزير / Heavy rain / Starker Regen
      const CollocationEntry(
        id: 'col_adj_01',
        category: CollocationCategory.adjectiveNoun,
        baseConcept: 'هطول الأمطار بكثافة (Intense Precipitation)',
        canonicalCollocationAr: 'مَطَرٌ غَزِيرٌ / غَيْثٌ هَطِلٌ',
        canonicalCollocationEn: 'Torrential / Heavy rain',
        canonicalCollocationDe: 'Starker Regen / Wolkenbruchartiger Niederschlag',
        literalMisleadingAr: 'مَطَرٌ قَوِيٌّ / مَطَرٌ ثَقِيلٌ (تَرْجَمَةٌ حَرْفِيَّةٌ رَكِيكَةٌ)',
        literalMisleadingEn: 'Strong rain / Thick rain (Unnatural collocation)',
        literalMisleadingDe: 'Schwerer Regen (im Deutschen unüblich für Niederschlagsmenge)',
        mutualInformationScore: 9.4,
        contextualExampleAr: 'هَطَلَ مَطَرٌ غَزِيرٌ سَقَى الأَرْضَ بَعْدَ طُولِ جَفَافٍ، فَانْتَعَشَتِ الزُّرُوعُ.',
        contextualExampleEn: 'Torrential rain drenched the fertile plains, replenishing the parched aquifers.',
        contextualExampleDe: 'Starker Regen tränkte den ausgetrockneten Boden und belebte die Natur.',
        linguisticRationaleAr: 'يَسْتَعْمِلُ اللِّسَانُ العَرَبِيُّ (غَزِيراً) وَ(هَطِلاً) مَعَ المَطَرِ، بَيْنَمَا تَقْتَرِنُ الإِنْجِلِيزِيَّةُ بِـ (Heavy/Torrential) وَالأَلْمَانِيَّةُ بِـ (Stark).',
      ),

      // 2. الفعل الإسنادي والمفعول: اتخاذ قرار / Make a decision / Eine Entscheidung treffen
      const CollocationEntry(
        id: 'col_verb_01',
        category: CollocationCategory.verbNounSupport,
        baseConcept: 'الحسم والعزم على أمر (Decision-Making)',
        canonicalCollocationAr: 'اتَّخَذَ قَرَاراً / قَطَعَ أَمْراً',
        canonicalCollocationEn: 'Make / Reach a decision',
        canonicalCollocationDe: 'Eine Entscheidung treffen / fällen',
        literalMisleadingAr: 'عَمِلَ قَرَاراً / فَعَلَ قَرَاراً (رَكَاكَةٌ نَاتِجَةٌ عَنِ التَّدَاخُلِ)',
        literalMisleadingEn: 'Do a decision / Take a cut (Calque error)',
        literalMisleadingDe: 'Eine Entscheidung machen (Umgangssprachlicher Anglizismus-Fehler)',
        mutualInformationScore: 9.8,
        contextualExampleAr: 'اتَّخَذَ المَجْلِسُ الاسْتِشَارِيُّ قَرَاراً حَاسِماً بِالإِجْمَاعِ لِتَعْزِيزِ البَحْثِ العِلْمِيِّ.',
        contextualExampleEn: 'The executive committee reached a unanimous decision to prioritize ethical research.',
        contextualExampleDe: 'Der Beirat traf eine einstimmige Entscheidung zur Förderung exzellenter Forschung.',
        linguisticRationaleAr: 'تَرْكِيبُ الفِعْلِ الوَظِيفِيِّ (Funktionsverbgefüge): يُفَضِّلُ الأَلْمَانِيُّ (treffen/fällen) وَالإِنْجِلِيزِيُّ (make/reach) وَالعَرَبِيُّ (اتَّخَذَ/أَبْرَمَ).',
      ),

      // 3. الفعل والجار الملازم: الاعتماد على / Depend on / Abhängen von
      const CollocationEntry(
        id: 'col_prep_01',
        category: CollocationCategory.verbPrepositional,
        baseConcept: 'الاستناد والارتباط الوثيق (Contingency & Reliance)',
        canonicalCollocationAr: 'اعْتَمَدَ عَلَى / عَوَّلَ عَلَى',
        canonicalCollocationEn: 'Rely on / Depend upon',
        canonicalCollocationDe: 'Abhängen von / Sich verlassen auf (+ Akk)',
        literalMisleadingAr: 'اعْتَمَدَ فِي / عَوَّلَ بِـ (خَطَأٌ فِي حَرْفِ الجَرِّ المُلَازِمِ)',
        literalMisleadingEn: 'Rely at / Depend of (Incorrect preposition binding)',
        literalMisleadingDe: 'Abhängen über (Falsche Rektion der Präposition)',
        mutualInformationScore: 9.1,
        contextualExampleAr: 'يُعَوِّلُ طَالِبُ العِلْمِ عَلَى الدَّأَبِ وَالإِخْلَاصِ فِي تَحْصِيلِ المَعَارِفِ.',
        contextualExampleEn: 'True scholarly mastery relies upon methodical diligence and unyielding perseverance.',
        contextualExampleDe: 'Wahre wissenschaftliche Meisterschaft hängt von methodischer Ausdauer und Sorgfalt ab.',
        linguisticRationaleAr: 'التَّعَدِّي بِحُرُوفِ الجَرِّ المَحْفُوظَةِ (Prepositional Rection): تَتَعَلَّقُ (عَلَى) بِـ(اعْتَمَدَ)، وَ(on) بِـ(rely)، وَ(von) بِـ(abhängen).',
      ),

      // 4. الظرف المؤكد المقترن: رفض قاطع / Flatly reject / Kategorisch ablehnen
      const CollocationEntry(
        id: 'col_adv_01',
        category: CollocationCategory.adverbialIntensifier,
        baseConcept: 'الرفض التام والمطلق (Categorical Refusal)',
        canonicalCollocationAr: 'رَفَضَ رَفْضاً قَاطِعاً / بَاتّاً',
        canonicalCollocationEn: 'Flatly reject / Categorically deny',
        canonicalCollocationDe: 'Kategorisch ablehnen / Rundweg zurückweisen',
        literalMisleadingAr: 'رَفَضَ بِشَكْلٍ مَقْطُوعٍ (تَعْبِيرٌ مُعْوَجٌّ)',
        literalMisleadingEn: 'Reject cuttingly / Sharply refuse (Suboptimal intensifier)',
        literalMisleadingDe: 'Schnittig ablehnen (Unsinnige Wortverbindung)',
        mutualInformationScore: 9.6,
        contextualExampleAr: 'رَفَضَ العَالِمُ رَفْضاً قَاطِعاً كُلَّ شُبْهَةٍ تُنَافِي النَّزَاهَةَ الأَكَادِيمِيَّةَ.',
        contextualExampleEn: 'The scholar flatly rejected any assertion that would compromise intellectual integrity.',
        contextualExampleDe: 'Der Forscher lehnte jegliche Einmischung, die die wissenschaftliche Redlichkeit bedroht, kategorisch ab.',
        linguisticRationaleAr: 'اقْتِرَانُ المَفْعُولِ المُطْلَقِ المَوْصُوفِ فِي العَرَبِيَّةِ (رَفْضاً قَاطِعاً) يُقَابِلُهُ الظَّرْفُ المَنُوطُ (flatly/kategorisch).',
      ),
    ];

    _state = _state.copyWith(
      entries: defaultEntries,
      selectedEntryId: defaultEntries.first.id,
    );
  }

  void selectCategory(CollocationCategory category) {
    final filtered = _state.entries.where((e) => e.category == category).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedEntryId;
    _state = _state.copyWith(
      selectedCategory: category,
      selectedEntryId: nextId,
    );
    notifyListeners();
  }

  void selectEntry(String id) {
    _state = _state.copyWith(selectedEntryId: id);
    notifyListeners();
  }

  void toggleNegativeTransferAlerts() {
    _state = _state.copyWith(showNegativeTransferAlerts: !_state.showNegativeTransferAlerts);
    notifyListeners();
  }

  void toggleCorpusConcordance() {
    _state = _state.copyWith(showCorpusConcordance: !_state.showCorpusConcordance);
    notifyListeners();
  }
}
