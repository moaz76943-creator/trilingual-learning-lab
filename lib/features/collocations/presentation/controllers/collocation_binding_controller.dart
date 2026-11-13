import 'package:flutter/foundation.dart';

/// Language context for collocation study
enum CollocationLanguage {
  arabic(
    nameAr: 'العَرَبِيَّةُ (أَفْعَالُ الصِّلَةِ وَحُرُوفُ الجَرِّ)',
    nameDe: 'Arabische Verben mit festen Präpositionen',
    nameEn: 'Arabic Prepositional Verbs & Semantic Shifts',
  ),
  german(
    nameAr: 'الأَلْمَانِيَّةُ (Verben mit festen Präpositionen)',
    nameDe: 'Feste Verb-Präposition-Verbindungen & Kasus',
    nameEn: 'German Verbs with Fixed Prepositions & Cases',
  ),
  english(
    nameAr: 'الإِنْجِلِيزِيَّةُ (Dependent Prepositions & Collocations)',
    nameDe: 'Englische Verben mit abhängigen Präpositionen',
    nameEn: 'English Dependent Prepositions & Phrasal Bindings',
  );

  final String nameAr;
  final String nameDe;
  final String nameEn;

  const CollocationLanguage({
    required this.nameAr,
    required this.nameDe,
    required this.nameEn,
  });
}

/// A specific preposition attachment and its governed case / semantic outcome
class PrepositionVariant {
  final String preposition;
  final String governedCaseAr; // e.g. "اسم مجرور بالكسرة" or "Akkusativ"
  final String governedCaseDe;
  final String governedCaseEn;
  final String meaningAr;
  final String meaningDe;
  final String meaningEn;
  final String exampleSentenceAr;
  final String exampleSentenceDe;
  final String exampleSentenceEn;
  final String falseFriendWarningAr;

  const PrepositionVariant({
    required this.preposition,
    required this.governedCaseAr,
    required this.governedCaseDe,
    required this.governedCaseEn,
    required this.meaningAr,
    required this.meaningDe,
    required this.meaningEn,
    required this.exampleSentenceAr,
    required this.exampleSentenceDe,
    required this.exampleSentenceEn,
    required this.falseFriendWarningAr,
  });
}

/// Core Verb entity with multiple preposition binding variants
class PrepositionalVerb {
  final String id;
  final CollocationLanguage language;
  final String baseVerb;
  final String baseMeaningAr;
  final String baseMeaningDe;
  final String baseMeaningEn;
  final List<PrepositionVariant> variants;

  const PrepositionalVerb({
    required this.id,
    required this.language,
    required this.baseVerb,
    required this.baseMeaningAr,
    required this.baseMeaningDe,
    required this.baseMeaningEn,
    required this.variants,
  });

  static const List<PrepositionalVerb> catalog = [
    // 1. Arabic: رَغِبَ (Dramatic semantic shift based on preposition)
    PrepositionalVerb(
      id: 'ar_raghiba',
      language: CollocationLanguage.arabic,
      baseVerb: 'رَغِبَ',
      baseMeaningAr: 'الأَصْلُ: وُجُودُ مَيْلٍ نَفْسِيٍّ (طَلَبٌ أَوْ زُهْدٌ)',
      baseMeaningDe: 'Wünschen / Begehren oder Ablehnen',
      baseMeaningEn: 'To incline (desire or aversion)',
      variants: [
        PrepositionVariant(
          preposition: 'فِي',
          governedCaseAr: 'حَرْفُ جَرٍّ + اسْمٌ مَجْرُورٌ',
          governedCaseDe: 'Präposition + Genitivobjekt',
          governedCaseEn: 'Preposition + Noun',
          meaningAr: 'أَرَادَهُ وَطَلَبَهُ وَحَرَصَ عَلَيْهِ (Desire / Seek)',
          meaningDe: 'etwas begehren / an etwas interessiert sein',
          meaningEn: 'To desire / want / wish for something',
          exampleSentenceAr: 'رَغِبَ العَالِمُ فِي تَحْقِيقِ المَخْطُوطِ النَّفِيسِ.',
          exampleSentenceDe: 'Der Gelehrte wünschte die Edition des Manuskripts.',
          exampleSentenceEn: 'The scholar desired to edit the precious manuscript.',
          falseFriendWarningAr: 'رَغِبَ فِي تَعْنِي الرَّغْبَةَ الصَّرِيحَةَ؛ وَلا يَجُوزُ اسْتِبْدَالُهَا بِـ (عَنْ).',
        ),
        PrepositionVariant(
          preposition: 'عَنْ',
          governedCaseAr: 'حَرْفُ جَرٍّ + اسْمٌ مَجْرُورٌ',
          governedCaseDe: 'Präposition + Genitivobjekt',
          governedCaseEn: 'Preposition + Noun',
          meaningAr: 'زَهِدَ فِيهِ وَانْصَرَفَ عَنْهُ وَتَرَكَهُ (Abstain / Turn away from)',
          meaningDe: 'etwas ablehnen / verschmähen / ablassen von',
          meaningEn: 'To turn away from / abstain from / renounce',
          exampleSentenceAr: 'رَغِبَ الزَّاهِدُ عَنْ زَخَارِفِ الدُّنْيَا الفَانِيَةِ.',
          exampleSentenceDe: 'Der Asket wandte sich vom irdischen Prunk ab.',
          exampleSentenceEn: 'The ascetic turned away from worldly vanity.',
          falseFriendWarningAr: 'تَحْذِيرٌ دِلالِيٌّ خَطِيرٌ: حَرْفُ (عَنْ) يَعْكِسُ المَعْنَى تَمَاماً لِيُصْبِحَ زُهْداً وَتَرْكاً!',
        ),
      ],
    ),

    // 2. Arabic: عَدَلَ (Shift between justice, turning away, and equating)
    PrepositionalVerb(
      id: 'ar_adala',
      language: CollocationLanguage.arabic,
      baseVerb: 'عَدَلَ',
      baseMeaningAr: 'الأَصْلُ: الاسْتِقَامَةُ أَوِ المَيْلُ',
      baseMeaningDe: 'Gerecht sein / abweichen / gleichsetzen',
      baseMeaningEn: 'To judge / deviate / equate',
      variants: [
        PrepositionVariant(
          preposition: 'عَنْ',
          governedCaseAr: 'حَرْفُ جَرٍّ + اسْمٌ مَجْرُورٌ',
          governedCaseDe: 'Präposition + Dativ',
          governedCaseEn: 'Preposition + Object',
          meaningAr: 'تَرَكَ الرَّأْيَ وَتَرَاجَعَ عَنْهُ (Abandon / Deviate)',
          meaningDe: 'ablassen von / abweichen',
          meaningEn: 'To abandon / retract / turn away from a plan',
          exampleSentenceAr: 'عَدَلَ القَاضِي عَنْ حُكْمِهِ السَّابِقِ لِظُهُورِ بَيِّنَةٍ جَدِيدَةٍ.',
          exampleSentenceDe: 'Der Richter wich von seinem früheren Urteil ab.',
          exampleSentenceEn: 'The judge retracted his earlier verdict upon new evidence.',
          falseFriendWarningAr: 'عَدَلَ عَنْ تَعْنِي الرُّجُوعَ عَنِ الشَّيْءِ وَتَرْكَهُ، وَلَيْسَتْ مِنَ العَدْلِ القَضَائِيِّ.',
        ),
        PrepositionVariant(
          preposition: 'إِلَى',
          governedCaseAr: 'حَرْفُ جَرٍّ + اسْمٌ مَجْرُورٌ',
          governedCaseDe: 'Präposition + Dativ',
          governedCaseEn: 'Preposition + Object',
          meaningAr: 'مَالَ إِلَيْهِ وَانْتَقَلَ نَحْوَهُ (Turn towards)',
          meaningDe: 'übergehen zu / sich zuwenden',
          meaningEn: 'To turn towards / shift to another alternative',
          exampleSentenceAr: 'عَدَلَ البَاحِثُ إِلَى مَنْهَجِ الاسْتِقْرَاءِ التَّجْرِيبِيِّ.',
          exampleSentenceDe: 'Der Forscher ging zur empirischen Induktion über.',
          exampleSentenceEn: 'The researcher turned to empirical induction.',
          falseFriendWarningAr: 'عَدَلَ إِلَى تُفِيدُ الانْتِقَالَ الإِيجَابِيَّ نَحْوَ بَدِيلٍ آخَرَ.',
        ),
      ],
    ),

    // 3. German: warten (auf + Akkusativ)
    PrepositionalVerb(
      id: 'de_warten',
      language: CollocationLanguage.german,
      baseVerb: 'warten',
      baseMeaningAr: 'الانْتِظَارُ وَالتَّرَقُّبُ',
      baseMeaningDe: 'Zeit verbringen bis etwas eintrifft',
      baseMeaningEn: 'To wait',
      variants: [
        PrepositionVariant(
          preposition: 'auf + Akkusativ',
          governedCaseAr: 'حَالَةُ النَّصْبِ الأَلْمَانِيَّةُ (Akkusativ)',
          governedCaseDe: 'Präposition mit Akkusativ',
          governedCaseEn: 'Preposition governing Accusative',
          meaningAr: 'يَنْتَظِرُ شَخْصاً أَوْ أَمْراً مُسْتَقْبَلاً (Wait for)',
          meaningDe: 'warten auf jemanden/etwas (Akk.)',
          meaningEn: 'To wait for someone or something',
          exampleSentenceAr: 'يَنْتَظِرُ الطُّلابُ الأُسْتَاذَ أَمَامَ المَجْمَعِ.',
          exampleSentenceDe: 'Die Studenten warten auf den Professor vor der Akademie.',
          exampleSentenceEn: 'The students are waiting for the professor outside the academy.',
          falseFriendWarningAr: 'خَطَأٌ شَائِعٌ جِدّاً: حَرْفُ الجَرِّ فِي الأَلْمَانِيَّةِ هُوَ (auf) وَلَيْسَ (für)! كَمَا يَتَطَلَّبُ حَالَةَ النَّصْبِ (Akkusativ).',
        ),
      ],
    ),

    // 4. German: sich freuen (auf vs über)
    PrepositionalVerb(
      id: 'de_freuen',
      language: CollocationLanguage.german,
      baseVerb: 'sich freuen',
      baseMeaningAr: 'الفَرَحُ وَالسُّرُورُ',
      baseMeaningDe: 'Freude empfinden',
      baseMeaningEn: 'To be pleased / joyful',
      variants: [
        PrepositionVariant(
          preposition: 'auf + Akkusativ',
          governedCaseAr: 'حَالَةُ النَّصْبِ (Akkusativ) - لِلْمُسْتَقْبَلِ',
          governedCaseDe: 'Vorfreude auf Zukünftiges (Akk.)',
          governedCaseEn: 'Anticipation of future events',
          meaningAr: 'يَتَشَوَّقُ وَيَفْرَحُ بِأَمْرٍ قَادِمٍ فِي المُسْتَقْبَلِ (Look forward to)',
          meaningDe: 'sich auf ein zukünftiges Ereignis freuen',
          meaningEn: 'To look forward to an upcoming event',
          exampleSentenceAr: 'يَتَشَوَّقُ البَاحِثُ إِلَى لِقَاءِ زُمَلائِهِ فِي المُؤْتَمَرِ.',
          exampleSentenceDe: 'Der Forscher freut sich auf die Konferenz.',
          exampleSentenceEn: 'The researcher is looking forward to the conference.',
          falseFriendWarningAr: 'اسْتِخْدَامُ (auf) هُنَا يَدُلُّ حَصْراً عَلَى التَّشَوُّقِ لِأَمْرٍ قَادِمٍ لَمْ يَقَعْ بَعْدُ.',
        ),
        PrepositionVariant(
          preposition: 'über + Akkusativ',
          governedCaseAr: 'حَالَةُ النَّصْبِ (Akkusativ) - لِلْحَاضِرِ أَوِ المَاضِي',
          governedCaseDe: 'Freude über Gegenwärtiges/Vergangenes (Akk.)',
          governedCaseEn: 'Joy regarding current/past reality',
          meaningAr: 'يَفْرَحُ بِأَمْرٍ حَاصِلٍ حَالِيّاً أَوْ وَقَعَ فِي المَاضِي (Happy about)',
          meaningDe: 'sich über ein bestehendes Ereignis freuen',
          meaningEn: 'To be glad / happy about a present or past event',
          exampleSentenceAr: 'فَرِحَ الطَّالِبُ بِنَجَاحِهِ فِي الامْتِحَانِ.',
          exampleSentenceDe: 'Der Student freut sich über das bestandene Examen.',
          exampleSentenceEn: 'The student is happy about passing the examination.',
          falseFriendWarningAr: 'حَرْفُ (über) يُسْتَعْمَلُ عِنْدَمَا يَكُونُ الحَدَثُ قَدْ تَحَقَّقَ بِالفِعْلِ.',
        ),
      ],
    ),

    // 5. English: depend on / look forward to
    PrepositionalVerb(
      id: 'en_depend',
      language: CollocationLanguage.english,
      baseVerb: 'depend',
      baseMeaningAr: 'الاعْتِمَادُ وَالتَّعَلُّقُ',
      baseMeaningDe: 'Abhängen / Angewiesen sein',
      baseMeaningEn: 'To be contingent upon',
      variants: [
        PrepositionVariant(
          preposition: 'on / upon',
          governedCaseAr: 'حَرْفُ جَرٍّ مَعَ اسْمٍ أَوْ مَصْدَرٍ صَرِيحٍ',
          governedCaseDe: 'Präposition mit Objekt',
          governedCaseEn: 'Preposition + Noun / Gerund',
          meaningAr: 'يَعْتَمِدُ عَلَى الشَّخْصِ أَوْ يَرْتَبِطُ بِالشَّرْطِ (Rely on)',
          meaningDe: 'abhängen von (Dativ)',
          meaningEn: 'To rely on or be determined by',
          exampleSentenceAr: 'تَعْتَمِدُ دِقَّةُ النَّتِيجَةِ عَلَى مِعْيَارِيَّةِ القِيَاسِ.',
          exampleSentenceDe: 'Die Genauigkeit hängt von der Messkalibrierung ab.',
          exampleSentenceEn: 'The accuracy depends on the calibration of the scale.',
          falseFriendWarningAr: 'فِي الأَلْمَانِيَّةِ يَأْخُذُ الفِعْلُ (von + Dat)، بَيْنَمَا فِي الإِنْجِلِيزِيَّةِ (on)، وَفِي العَرَبِيَّةِ (عَلَى).',
        ),
      ],
    ),
  ];
}

/// State representation for Collocation & Preposition Binding Studio
class CollocationBindingState {
  final CollocationLanguage selectedLanguage;
  final PrepositionalVerb selectedVerb;
  final int selectedVariantIndex;
  final bool isQuizModeActive;
  final bool? lastQuizResult; // true if correct, false if wrong

  const CollocationBindingState({
    required this.selectedLanguage,
    required this.selectedVerb,
    required this.selectedVariantIndex,
    required this.isQuizModeActive,
    required this.lastQuizResult,
  });

  factory CollocationBindingState.initial() {
    final first = PrepositionalVerb.catalog.first;
    return CollocationBindingState(
      selectedLanguage: CollocationLanguage.arabic,
      selectedVerb: first,
      selectedVariantIndex: 0,
      isQuizModeActive: false,
      lastQuizResult: null,
    );
  }

  PrepositionVariant get activeVariant =>
      selectedVerb.variants[selectedVariantIndex];

  CollocationBindingState copyWith({
    CollocationLanguage? selectedLanguage,
    PrepositionalVerb? selectedVerb,
    int? selectedVariantIndex,
    bool? isQuizModeActive,
    bool? lastQuizResult,
  }) {
    return CollocationBindingState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedVerb: selectedVerb ?? this.selectedVerb,
      selectedVariantIndex:
          selectedVariantIndex ?? this.selectedVariantIndex,
      isQuizModeActive: isQuizModeActive ?? this.isQuizModeActive,
      lastQuizResult: lastQuizResult ?? this.lastQuizResult,
    );
  }
}

/// Controller managing Collocation and Preposition Binding Studio
class CollocationBindingController extends ChangeNotifier {
  CollocationBindingState _state = CollocationBindingState.initial();

  CollocationBindingState get state => _state;

  void setLanguage(CollocationLanguage lang) {
    final available = PrepositionalVerb.catalog
        .where((v) => v.language == lang)
        .toList();
    final first = available.isNotEmpty ? available.first : PrepositionalVerb.catalog.first;

    _state = _state.copyWith(
      selectedLanguage: lang,
      selectedVerb: first,
      selectedVariantIndex: 0,
      isQuizModeActive: false,
      lastQuizResult: null,
    );
    notifyListeners();
  }

  void selectVerb(PrepositionalVerb verb) {
    _state = _state.copyWith(
      selectedVerb: verb,
      selectedLanguage: verb.language,
      selectedVariantIndex: 0,
      lastQuizResult: null,
    );
    notifyListeners();
  }

  void selectVariant(int index) {
    if (index >= 0 && index < _state.selectedVerb.variants.length) {
      _state = _state.copyWith(
        selectedVariantIndex: index,
        lastQuizResult: null,
      );
      notifyListeners();
    }
  }

  void toggleQuizMode() {
    _state = _state.copyWith(
      isQuizModeActive: !_state.isQuizModeActive,
      lastQuizResult: null,
    );
    notifyListeners();
  }

  /// Submit guess for preposition attachment
  bool evaluatePrepositionChoice(String chosenPreposition) {
    final correct = _state.activeVariant.preposition == chosenPreposition;
    _state = _state.copyWith(lastQuizResult: correct);
    notifyListeners();
    return correct;
  }

  void reset() {
    _state = CollocationBindingState.initial();
    notifyListeners();
  }
}
