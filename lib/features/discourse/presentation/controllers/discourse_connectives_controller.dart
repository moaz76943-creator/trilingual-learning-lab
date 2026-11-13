import 'package:flutter/foundation.dart';

/// Target language for academic discourse study
enum DiscourseLanguage {
  arabic(
    nameAr: 'العَرَبِيَّةُ (رَوَابِطُ النَّصِّ وَحُرُوفُ المَعَانِي)',
    nameDe: 'Arabische akademische Diskursmarker',
    nameEn: 'Arabic Scholarly Discourse Connectives',
  ),
  german(
    nameAr: 'الأَلْمَانِيَّةُ (Konjunktionaladverbien & Satzverknüpfung)',
    nameDe: 'Deutsche wissenschaftliche Konnektoren',
    nameEn: 'German Academic Sentence Connectors',
  ),
  english(
    nameAr: 'الإِنْجِلِيزِيَّةُ (Academic Discourse & Cohesion Markers)',
    nameDe: 'Englische akademische Übergangs- & Kohäsionsmarker',
    nameEn: 'English Academic Cohesion & Transition Markers',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;

  const DiscourseLanguage({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
  });
}

/// The Rhetorical Logic of Academic Discourse Connectives
enum RhetoricalRelation {
  concessionContrast(
    nameAr: 'الاسْتِدْرَاكُ وَالتَّعَارُضُ (Concession & Contrast)',
    nameDe: 'Konzession & Gegensatz (z.B. dennoch, hingegen)',
    nameEn: 'Concession & Contrast (e.g. nonetheless, whereas)',
    colorHex: 0xFFEF4444, // Red
  ),
  causationDeduction(
    nameAr: 'التَّعْلِيلُ وَالاسْتِنْتَاجُ (Causation & Deduction)',
    nameDe: 'Kausalität & Konsequenz (z.B. demzufolge, folglich)',
    nameEn: 'Causation & Result (e.g. consequently, hence)',
    colorHex: 0xFF3B82F6, // Blue
  ),
  additiveAmplification(
    nameAr: 'الإِضَافَةُ وَالتَّعْزِيزُ (Additive Amplification)',
    nameDe: 'Ergänzung & Intensivierung (z.B. darüber hinaus)',
    nameEn: 'Addition & Amplification (e.g. furthermore, moreover)',
    colorHex: 0xFF10B981, // Emerald
  ),
  exemplificationClarification(
    nameAr: 'التَّمْثِيلُ وَالتَّوْضِيحُ (Exemplification & Elaboration)',
    nameDe: 'Exemplifikation & Erläuterung (z.B. gewissermaßen)',
    nameEn: 'Exemplification & Clarification (e.g. namely, that is)',
    colorHex: 0xFFF59E0B, // Amber
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;
  final int colorHex;

  const RhetoricalRelation({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
    required this.colorHex,
  });
}

/// A specific discourse connector item
class DiscourseConnectiveItem {
  final String id;
  final DiscourseLanguage language;
  final RhetoricalRelation relation;
  final String connectiveText;
  final String syntacticCategoryAr; // e.g. "اسم فعل / حرف استدراك" or "Konjunktionaladverb (V2 Inversion)"
  final String syntacticCategoryDe;
  final String syntacticCategoryEn;
  final String premiseClauseAr; // First clause / premise
  final String premiseClauseDe;
  final String premiseClauseEn;
  final String conclusionClauseAr; // Second clause / consequence
  final String conclusionClauseDe;
  final String conclusionClauseEn;
  final String rhetoricalUsageAdviceAr;

  const DiscourseConnectiveItem({
    required this.id,
    required this.language,
    required this.relation,
    required this.connectiveText,
    required this.syntacticCategoryAr,
    required this.syntacticCategoryDe,
    required this.syntacticCategoryEn,
    required this.premiseClauseAr,
    required this.premiseClauseDe,
    required this.premiseClauseEn,
    required this.conclusionClauseAr,
    required this.conclusionClauseDe,
    required this.conclusionClauseEn,
    required this.rhetoricalUsageAdviceAr,
  });

  static const List<DiscourseConnectiveItem> catalog = [
    // 1. Arabic: بَيْدَ أَنَّ (Concession)
    DiscourseConnectiveItem(
      id: 'ar_bayda_anna',
      language: DiscourseLanguage.arabic,
      relation: RhetoricalRelation.concessionContrast,
      connectiveText: 'بَيْدَ أَنَّ',
      syntacticCategoryAr: 'أَدَاةُ اسْتِدْرَاكٍ وَنَصْبٍ (تَلِي فِكْرَةً مُنَاقِضَةً)',
      syntacticCategoryDe: 'Konzessive Subjunktion (Wohingegen / Jedoch)',
      syntacticCategoryEn: 'Adversative Conjunction (Albeit / However)',
      premiseClauseAr: 'أَجْمَعَ الفَلَكِيُّونَ القُدَمَاءُ عَلَى حَرَكَةِ الأَفْلاكِ الدَّائِرِيَّةِ،',
      premiseClauseDe: 'Die antiken Astronomen stimmten über die Kreisbahnen überein,',
      premiseClauseEn: 'Ancient astronomers agreed upon circular planetary orbits,',
      conclusionClauseAr: 'ابْنَ الشَّاطِرِ بَرْهَنَ أَنَّ الأَفْلاكَ البَيْضَاوِيَّةَ تُفَسِّرُ مَسِيرَ الكَوَاكِبِ بِدِقَّةٍ أَعْلَى.',
      conclusionClauseDe: 'Ibn al-Shatir bewies jedoch, dass elliptische Modelle die Planetenbahnen präziser erklären.',
      conclusionClauseEn: 'Ibn al-Shatir nevertheless proved that epicyclic models explain planetary tracks with superior precision.',
      rhetoricalUsageAdviceAr: '«بَيْدَ أَنَّ» مِنْ أَرْقَى أَدَوَاتِ الاسْتِدْرَاكِ فِي الفُصْحَى؛ تَدْخُلُ عَلَى الجُمْلَةِ الاسْمِيَّةِ وَتَنْصِبُ مَا بَعْدَهَا، وَتُسْتَعْمَلُ عِنْدَ إِثْبَاتِ أَمْرٍ يُخَالِفُ المَظْنُونَ.',
    ),

    // 2. Arabic: وَمِنْ ثَمَّ (Causation/Deduction)
    DiscourseConnectiveItem(
      id: 'ar_wa_min_thamma',
      language: DiscourseLanguage.arabic,
      relation: RhetoricalRelation.causationDeduction,
      connectiveText: 'وَمِنْ ثَمَّ',
      syntacticCategoryAr: 'رَابِطٌ اسْتِنْتَاجِيٌّ بِمَعْنَى (لِذَلِكَ / فَبِنَاءً عَلَى هَذَا)',
      syntacticCategoryDe: 'Konsekutives Adverb (Folglich / Demnach)',
      syntacticCategoryEn: 'Consecutive Adverb (Consequently / Hence)',
      premiseClauseAr: 'تَطَابَقَتِ النَّتَائِجُ التَّجْرِيبِيَّةُ مَعَ حِسَابَاتِ المِيزَانِ الهَيْدْرُوسْتَاتِيكِيِّ،',
      premiseClauseDe: 'Die experimentellen Befunde stimmten mit den Waage-Berechnungen überein,',
      premiseClauseEn: 'The experimental empirical findings matched the hydrostatic balance calculations,',
      conclusionClauseAr: 'ثَبُتَ يَقِيناً خُلُوُّ السَّبِيكَةِ مِنْ أَيِّ غِشٍّ أَوْ مَعْدِنٍ دَخِيلٍ.',
      conclusionClauseDe: 'wurde zweifelsfrei bewiesen, dass die Legierung frei von Fälschung war.',
      conclusionClauseEn: 'the absolute purity of the alloy was established beyond doubt.',
      rhetoricalUsageAdviceAr: '«وَمِنْ ثَمَّ» رَابِطٌ اسْتِنْتَاجِيٌّ سَبَبِيٌّ (بِفَتْحِ الثَّاءِ: ثَمَّ بِمَعْنَى هُنَاكَ)؛ وَالخَطَأُ الشَّائِعُ ضَمُّ الثَّاءِ ظَنّاً أَنَّهَا حَرْفُ عَطْفٍ.',
    ),

    // 3. German: demzufolge / folglich (V2 Inversion)
    DiscourseConnectiveItem(
      id: 'de_demzufolge',
      language: DiscourseLanguage.german,
      relation: RhetoricalRelation.causationDeduction,
      connectiveText: 'demzufolge',
      syntacticCategoryAr: 'ظَرْفُ عَطْفٍ اسْتِنْتَاجِيٌّ (يَقْتَضِي تَقْدِيمَ الفِعْلِ V2 Inversion)',
      syntacticCategoryDe: 'Konjunktionaladverb mit Inversion (Verb an Position 2)',
      syntacticCategoryEn: 'Conjunctive Adverb with V2 Inversion',
      premiseClauseAr: 'تَغَيَّرَتْ كَثَافَةُ الوَسَطِ البَصَرِيِّ،',
      premiseClauseDe: 'Die optische Dichte des Mediums veränderte sich maßgeblich,',
      premiseClauseEn: 'The optical density of the medium altered significantly,',
      conclusionClauseAr: 'انْكَسَرَ شُعَاعُ الضَّوْءِ بِمِقْدَارِ زَاوِيَةٍ مَحْسُوبَةٍ.',
      conclusionClauseDe: 'brach der Lichtstrahl in einem exakt berechenbaren Winkel.',
      conclusionClauseEn: 'the light ray refracted at an empirically predictable angle.',
      rhetoricalUsageAdviceAr: 'فِي الأَلْمَانِيَّةِ عِنْدَمَا يَبْدَأُ الشَّطْرُ الثَّانِي بِـ (demzufolge) أَوْ (folglich)، يَجِبُ تَقْدِيمُ الفِعْلِ فَوْراً قَبْلَ الفَاعِلِ (brach der Lichtstrahl).',
    ),

    // 4. German: nichtsdestotrotz / dessen ungeachtet (Concession)
    DiscourseConnectiveItem(
      id: 'de_nichtsdestotrotz',
      language: DiscourseLanguage.german,
      relation: RhetoricalRelation.concessionContrast,
      connectiveText: 'nichtsdestotrotz',
      syntacticCategoryAr: 'أَدَاةُ اسْتِدْرَاكٍ أَلْمَانِيَّةٌ رَفِيعَةٌ (بِمَعْنَى: مَعَ ذَلِكَ / رَغْمَ هَذَا)',
      syntacticCategoryDe: 'Konzessives Adverbial (Trotzdem / Dennoch)',
      syntacticCategoryEn: 'Concessive Adverb (Nonetheless / Notwithstanding)',
      premiseClauseAr: 'كَانَتْ أَدَوَاتُ الرَّصْدِ بَدَائِيَّةً فِي ذَلِكَ العَصْرِ،',
      premiseClauseDe: 'Die Beobachtungsinstrumente jener Epoche waren noch elementar,',
      premiseClauseEn: 'The observational instruments of that era were still rudimentary,',
      conclusionClauseAr: 'اسْتَطَاعَ البِيرُونِيُّ حِسَابَ نِصْفِ قُطْرِ الأَرْضِ بِدِقَّةٍ مُذْهِلَةٍ.',
      conclusionClauseDe: 'berechnete Al-Biruni den Erdumfang mit staunenswerter Präzision.',
      conclusionClauseEn: 'Al-Biruni determined the Earth’s radius with astonishing accuracy.',
      rhetoricalUsageAdviceAr: 'تُسْتَعْمَلُ (nichtsdestotrotz) فِي الخِطَابِ الأَكَادِيمِيِّ الرَّفِيعِ لِلتَّعْبِيرِ عَنْ بُلُوغِ النَّتِيجَةِ رَغْمَ وُجُودِ عَائِقٍ جَسِيمٍ.',
    ),

    // 5. English: furthermore / moreover (Additive)
    DiscourseConnectiveItem(
      id: 'en_furthermore',
      language: DiscourseLanguage.english,
      relation: RhetoricalRelation.additiveAmplification,
      connectiveText: 'Furthermore,',
      syntacticCategoryAr: 'رَابِطُ تَعْزِيزٍ وَإِضَافَةٍ لِلْحُجَّةِ (Moreover)',
      syntacticCategoryDe: 'Additiver Satzkonnektor (Darüber hinaus)',
      syntacticCategoryEn: 'Additive Transition Marker',
      premiseClauseAr: 'أَثْبَتَتِ النَّظَرِيَّةُ صِحَّةَ الفَرْضِيَّةِ الأُولَى،',
      premiseClauseDe: 'Die Theorie bestätigte die Ausgangshypothese vollumfänglich,',
      premiseClauseEn: 'The theoretical model substantiated the primary hypothesis;',
      conclusionClauseAr: 'فَتَحَتْ آفَاقاً جَدِيدَةً فِي تَصْمِيمِ آلاتِ التَّحَكُّمِ الذَّاتِيِّ.',
      conclusionClauseDe: 'eröffnete sie neue Horizonte im Entwurf automatischer Steuerungen.',
      conclusionClauseEn: 'it paved unprecedented pathways in self-regulating cybernetic automata.',
      rhetoricalUsageAdviceAr: '«Furthermore» تُسْتَعْمَلُ لِإِضَافَةِ حُجَّةٍ أَقْوَى تَدْعَمُ الفِكْرَةَ السَّابِقَةَ، مَعَ فَصْلِهَا بِفَاصِلَةٍ فِي بِدَايَةِ الجُمْلَةِ.',
    ),
  ];
}

/// State of the Academic Discourse Connectives Studio
class DiscourseConnectivesState {
  final DiscourseLanguage selectedLanguage;
  final RhetoricalRelation selectedRelation;
  final DiscourseConnectiveItem selectedConnective;
  final bool isInteractiveSlotChallenge;
  final String? chosenSlotConnective;
  final bool? isSlotChallengeCorrect;

  const DiscourseConnectivesState({
    required this.selectedLanguage,
    required this.selectedRelation,
    required this.selectedConnective,
    required this.isInteractiveSlotChallenge,
    required this.chosenSlotConnective,
    required this.isSlotChallengeCorrect,
  });

  factory DiscourseConnectivesState.initial() {
    final first = DiscourseConnectiveItem.catalog.first;
    return DiscourseConnectivesState(
      selectedLanguage: DiscourseLanguage.arabic,
      selectedRelation: RhetoricalRelation.concessionContrast,
      selectedConnective: first,
      isInteractiveSlotChallenge: false,
      chosenSlotConnective: null,
      isSlotChallengeCorrect: null,
    );
  }

  DiscourseConnectivesState copyWith({
    DiscourseLanguage? selectedLanguage,
    RhetoricalRelation? selectedRelation,
    DiscourseConnectiveItem? selectedConnective,
    bool? isInteractiveSlotChallenge,
    String? chosenSlotConnective,
    bool? isSlotChallengeCorrect,
  }) {
    return DiscourseConnectivesState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedRelation: selectedRelation ?? this.selectedRelation,
      selectedConnective: selectedConnective ?? this.selectedConnective,
      isInteractiveSlotChallenge:
          isInteractiveSlotChallenge ?? this.isInteractiveSlotChallenge,
      chosenSlotConnective: chosenSlotConnective ?? this.chosenSlotConnective,
      isSlotChallengeCorrect:
          isSlotChallengeCorrect ?? this.isSlotChallengeCorrect,
    );
  }
}

/// Controller managing Discourse Connectives & Argumentation Studio
class DiscourseConnectivesController extends ChangeNotifier {
  DiscourseConnectivesState _state = DiscourseConnectivesState.initial();

  DiscourseConnectivesState get state => _state;

  void setLanguage(DiscourseLanguage lang) {
    final available = DiscourseConnectiveItem.catalog
        .where((item) => item.language == lang)
        .toList();
    final first = available.isNotEmpty ? available.first : DiscourseConnectiveItem.catalog.first;

    _state = _state.copyWith(
      selectedLanguage: lang,
      selectedRelation: first.relation,
      selectedConnective: first,
      isInteractiveSlotChallenge: false,
      chosenSlotConnective: null,
      isSlotChallengeCorrect: null,
    );
    notifyListeners();
  }

  void selectRelation(RhetoricalRelation relation) {
    final available = DiscourseConnectiveItem.catalog
        .where((item) => item.language == _state.selectedLanguage && item.relation == relation)
        .toList();
    final item = available.isNotEmpty ? available.first : _state.selectedConnective;

    _state = _state.copyWith(
      selectedRelation: relation,
      selectedConnective: item,
      chosenSlotConnective: null,
      isSlotChallengeCorrect: null,
    );
    notifyListeners();
  }

  void selectConnective(DiscourseConnectiveItem item) {
    _state = _state.copyWith(
      selectedConnective: item,
      selectedLanguage: item.language,
      selectedRelation: item.relation,
      chosenSlotConnective: null,
      isSlotChallengeCorrect: null,
    );
    notifyListeners();
  }

  void toggleSlotChallenge() {
    _state = _state.copyWith(
      isInteractiveSlotChallenge: !_state.isInteractiveSlotChallenge,
      chosenSlotConnective: null,
      isSlotChallengeCorrect: null,
    );
    notifyListeners();
  }

  bool evaluateSlotChoice(String chosen) {
    final isCorrect = (chosen.trim() == _state.selectedConnective.connectiveText.replaceAll(',', '').trim());
    _state = _state.copyWith(
      chosenSlotConnective: chosen,
      isSlotChallengeCorrect: isCorrect,
    );
    notifyListeners();
    return isCorrect;
  }

  void reset() {
    _state = DiscourseConnectivesState.initial();
    notifyListeners();
  }
}
