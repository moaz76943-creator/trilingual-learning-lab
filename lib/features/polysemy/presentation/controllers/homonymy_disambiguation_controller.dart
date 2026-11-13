import 'package:flutter/foundation.dart';

enum AmbiguityCategory {
  homonymicPolysemy, // المشترك اللفظي التام (Homonymy / Echte Homonymie)
  rhetoricalTawriya,  // التورية البديعية (Double Entendre / Rhetorische Doppeldeutigkeit)
  paronomasiaJinan,  // الجناس التام والمستوفي (Complete Paronomasia / Klangähnlichkeit)
  selectionalBinding // التمييز التركيبي بالسياق والإسناد (Selectional Restriction Disambiguation)
}

class AmbiguitySense {
  final String senseNameAr; // المعنى بالعربية مشكول
  final String senseNameEn;
  final String senseNameDe;
  final String contextSentenceAr; // جملة الشاهد بالعربية مشكولة
  final String contextSentenceEn;
  final String contextSentenceDe;
  final String selectionalCue; // القرينة السياقية الدالة على المعنى

  const AmbiguitySense({
    required this.senseNameAr,
    required this.senseNameEn,
    required this.senseNameDe,
    required this.contextSentenceAr,
    required this.contextSentenceEn,
    required this.contextSentenceDe,
    required this.selectionalCue,
  });
}

class DisambiguationUnit {
  final String id;
  final AmbiguityCategory category;
  final String targetLemmaAr; // اللفظ المشترك بالعربية مشكول
  final String targetLemmaEn;
  final String targetLemmaDe;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final List<AmbiguitySense> senses;
  final String linguisticAnalysisAr;
  final String linguisticAnalysisEn;
  final String linguisticAnalysisDe;
  final double disambiguationComplexity; // 0.0 إلى 1.0

  const DisambiguationUnit({
    required this.id,
    required this.category,
    required this.targetLemmaAr,
    required this.targetLemmaEn,
    required this.targetLemmaDe,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.senses,
    required this.linguisticAnalysisAr,
    required this.linguisticAnalysisEn,
    required this.linguisticAnalysisDe,
    required this.disambiguationComplexity,
  });
}

class HomonymyDisambiguationState {
  final AmbiguityCategory selectedCategory;
  final List<DisambiguationUnit> units;
  final String selectedUnitId;
  final int activeSenseIndex;
  final bool showSelectionalCues;
  final bool showComparativeGrid;

  const HomonymyDisambiguationState({
    this.selectedCategory = AmbiguityCategory.homonymicPolysemy,
    this.units = const [],
    this.selectedUnitId = 'poly_eye_01',
    this.activeSenseIndex = 0,
    this.showSelectionalCues = true,
    this.showComparativeGrid = true,
  });

  DisambiguationUnit? get currentUnit {
    if (units.isEmpty) return null;
    return units.firstWhere(
      (u) => u.id == selectedUnitId,
      orElse: () => units.first,
    );
  }

  HomonymyDisambiguationState copyWith({
    AmbiguityCategory? selectedCategory,
    List<DisambiguationUnit>? units,
    String? selectedUnitId,
    int? activeSenseIndex,
    bool? showSelectionalCues,
    bool? showComparativeGrid,
  }) {
    return HomonymyDisambiguationState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      units: units ?? this.units,
      selectedUnitId: selectedUnitId ?? this.selectedUnitId,
      activeSenseIndex: activeSenseIndex ?? this.activeSenseIndex,
      showSelectionalCues: showSelectionalCues ?? this.showSelectionalCues,
      showComparativeGrid: showComparativeGrid ?? this.showComparativeGrid,
    );
  }
}

class HomonymyDisambiguationController extends ChangeNotifier {
  HomonymyDisambiguationState _state = const HomonymyDisambiguationState();
  HomonymyDisambiguationState get state => _state;

  HomonymyDisambiguationController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultUnits = [
      // 1. المشترك اللفظي التام: العَيْن (العين الباصرة، عين الماء، عين القوم)
      const DisambiguationUnit(
        id: 'poly_eye_01',
        category: AmbiguityCategory.homonymicPolysemy,
        targetLemmaAr: 'العَيْنُ',
        targetLemmaEn: 'Spring / Eye / Essence',
        targetLemmaDe: 'Quelle / Auge / Kern',
        titleAr: 'تَعَدُّدُ دَلَالَاتِ لَفْظِ (العَيْنِ) فِي اللِّسَانِ العَرَبِيِّ',
        titleEn: 'Radical Polysemy & Homonymy: The Multi-Faceted "Ayn"',
        titleDe: 'Polysemie & Homonymie: Das Bedeutungsspektrum von "Ayn"',
        senses: [
          AmbiguitySense(
            senseNameAr: 'عُضْوُ الإِبْصَارِ وَالرُّؤْيَةِ',
            senseNameEn: 'Organ of sight (Anatomical eye)',
            senseNameDe: 'Das Sehorgan (Auge)',
            contextSentenceAr: 'أَبْصَرَتْ عَيْنُهُ جَمَالَ صُنْعِ اللَّهِ فِي الآفَاقِ.',
            contextSentenceEn: 'His eye perceived the exquisite majesty of divine creation.',
            contextSentenceDe: 'Sein Auge erblickte die erhabene Schönheit der Schöpfung.',
            selectionalCue: 'الفِعْلُ (أَبْصَرَ) وَمَفْعُولُهُ يَقْتَصِرَانِ عَلَى حَاسَّةِ النَّظَرِ.',
          ),
          AmbiguitySense(
            senseNameAr: 'يَنْبُوعُ المَاءِ المُنْفَجِرِ مِنَ الأَرْضِ',
            senseNameEn: 'Freshwater water spring',
            senseNameDe: 'Die natürliche Wasserquelle',
            contextSentenceAr: 'فَجَّرَ اللَّهُ فِي هَذَا الوَادِي عَيْناً عَذْبَةً سَلْسَبِيلاً.',
            contextSentenceEn: 'God caused a sweet freshwater spring to burst forth in this valley.',
            contextSentenceDe: 'Gott ließ in diesem Tal eine frische, lebendige Quelle entspringen.',
            selectionalCue: 'الفِعْلُ (فَجَّرَ) وَوَصْفُ (عَذْبَةً) يُعَيِّنَانِ مَعْنَى المَاءِ.',
          ),
          AmbiguitySense(
            senseNameAr: 'سَيِّدُ القَوْمِ وَكَبِيرُهُمْ وَطَلِيعَتُهُمْ',
            senseNameEn: 'Dignitary, chief, or focal leader of a people',
            senseNameDe: 'Würdenträger, Leitfigur oder Vorsteher',
            contextSentenceAr: 'حَضَرَ عَيْنُ القَوْمِ لِعَقْدِ الصُّلْحِ بَيْنَ القَبَائِلِ.',
            contextSentenceEn: 'The foremost dignitary of the community arrived to broker reconciliation.',
            contextSentenceDe: 'Die führende Persönlichkeit der Gemeinde traf ein, um Frieden zu stiften.',
            selectionalCue: 'الإِضَافَةُ إِلَى (القَوْمِ) وَسِيَاقُ الصُّلْحِ يُثْبِتَانِ الشَّخْصِيَّةَ المَرْجِعِيَّةَ.',
          ),
        ],
        linguisticAnalysisAr: 'لَفْظُ (العَيْنِ) مِنْ أَعْرَقِ المُشْتَرَكَاتِ اللَّفْظِيَّةِ، وَتَتَمَحْوَرُ دَلَالَاتُهُ حَوْلَ الأَصَالَةِ وَالنَّبْعِ وَالمَرْكَزِيَّةِ.',
        linguisticAnalysisEn: 'A prime example of homophonic polysemy where context-bound selectional restrictions disambiguate referential meaning.',
        linguisticAnalysisDe: 'Klassische Homonymie und Polysemie: Kontextuelle Prädikate lösen die referenzielle Mehrdeutigkeit auf.',
        disambiguationComplexity: 0.95,
      ),

      // 2. التورية البديعية: المعنى القريب المورى به والمعنى البعيد المراد
      const DisambiguationUnit(
        id: 'poly_taw_01',
        category: AmbiguityCategory.rhetoricalTawriya,
        targetLemmaAr: 'الجَدُّ',
        targetLemmaEn: 'Jadd (Grandfather vs. Fortune / Earnest Endeavor)',
        targetLemmaDe: 'Jadd (Großvater vs. Schicksalsglück / Ernsthafter Fleiß)',
        titleAr: 'التَّوْرِيَةُ البَدِيعِيَّةُ بَيْنَ القُرْبِ الظَّاهِرِ وَالعُمْقِ المَقْصُودِ',
        titleEn: 'Rhetorical Double Entendre: Apparent Closeness vs. Latent Intent',
        titleDe: 'Rhetorische Doppeldeutigkeit (Tawriya): Scheinbarer Sinn vs. Tiefensinn',
        senses: [
          AmbiguitySense(
            senseNameAr: 'المَعْنَى القَرِيبُ المَوْرَى بِهِ: أَبُو الأَبِ أَوِ الأُمِّ',
            senseNameEn: 'Surface Meaning: Ancestor or Grandfather',
            senseNameDe: 'Oberflächensinn: Der Großvater / Ahne',
            contextSentenceAr: 'إِنَّ ابْنَ عَمِّكَ صَاحِبُ جَدٍّ مَشْهُورٍ فِي السِّيَادَةِ.',
            contextSentenceEn: 'Your cousin is associated with a renowned grandfather of nobility.',
            contextSentenceDe: 'Dein Vetter blickt auf einen ruhmreichen Großvater zurück.',
            selectionalCue: 'الذِّهْنُ يَنْصَرِفُ أَوَّلاً لِلنَّسَبِ لِوُجُودِ (ابْنِ عَمِّكَ).',
          ),
          AmbiguitySense(
            senseNameAr: 'المَعْنَى البَعِيدُ المَقْصُودُ: الحَظُّ الوَافِرُ وَالعَزِيمَةُ المَاضِيَةُ',
            senseNameEn: 'Targeted Deep Meaning: High fortune, destiny, and resolute toil',
            senseNameDe: 'Eigentlicher Tiefensinn: Hohes Glück, Würde und beharrlicher Fleiß',
            contextSentenceAr: 'إِنَّ ابْنَ عَمِّكَ صَاحِبُ جَدٍّ يُنَالُ بِهِ كُلُّ شَرَفٍ وَعُلُوٍّ.',
            contextSentenceEn: 'Truly your cousin possesses great fortune and earnest resolve whereby supreme honor is achieved.',
            contextSentenceDe: 'Wahrlich, dein Vetter besitzt jenes Schicksalsglück und jene Tatkraft, die zu höchster Ehre führen.',
            selectionalCue: 'قَرِينَةُ (يُنَالُ بِهِ كُلُّ شَرَفٍ) تُؤَكِّدُ السَّعْيَ وَالحَظَّ وَلَيْسَ الشَّيْخُوخَةَ.',
          ),
        ],
        linguisticAnalysisAr: 'التَّوْرِيَةُ هِيَ إِيرَادُ لَفْظٍ لَهُ مَعْنَيَانِ: قَرِيبٌ غَيْرُ مُرَادٍ، وَبَعِيدٌ هُوَ المَقْصُودُ لِتَحْفِيزِ فِطْنَةِ السَّامِعِ.',
        linguisticAnalysisEn: 'Stylistic double entendre engaging cognitive processing by initially presenting a salient distractor sense.',
        linguisticAnalysisDe: 'Rhetorische Verdeckung: Der vordergründige Sinn weicht bei reflektierter Lektüre dem tieferen Gehalt.',
        disambiguationComplexity: 0.92,
      ),

      // 3. التكافؤ المقارن مع الألمانية: Schloss (قصر vs. قفل)
      const DisambiguationUnit(
        id: 'poly_schloss_01',
        category: AmbiguityCategory.homonymicPolysemy,
        targetLemmaAr: 'القَصْرُ وَالقُفْلُ',
        targetLemmaEn: 'Castle / Lock (Schloss)',
        targetLemmaDe: 'Das Schloss (Burg vs. Türverschluss)',
        titleAr: 'المُشْتَرَكُ اللَّفْظِيُّ فِي الأَلْمَانِيَّةِ وَمُقَابِلُهُ التَّرْجَمِيُّ',
        titleEn: 'German Homonym Disambiguation: "Schloss" (Palace vs. Lock)',
        titleDe: 'Homonym-Disambiguierung im Deutschen: Schloss (Palast vs. Schloss)',
        senses: [
          AmbiguitySense(
            senseNameAr: 'القَصْرُ أَوْ القَلْعَةُ المَنِيعَةُ',
            senseNameEn: 'Palace, chateau, or monumental fortress',
            senseNameDe: 'Prachtvolles Gebäude / Residenz / Burg',
            contextSentenceAr: 'يَقِفُ القَصْرُ المَلَكِيُّ شَامِخاً عَلَى قِمَّةِ الجَبَلِ.',
            contextSentenceEn: 'The royal palace stands majestically atop the mountain peak.',
            contextSentenceDe: 'Das königliche Schloss thront majestätisch auf der Bergspitze.',
            selectionalCue: 'الفِعْلُ (thront) وَوَصْفُ (königlich) يُحَدِّدَانِ المَبْنَى الصَّرْحِيَّ.',
          ),
          AmbiguitySense(
            senseNameAr: 'القُفْلُ المَعْدِنِيُّ لِإِغْلَاقِ الأَبْوَابِ',
            senseNameEn: 'Mechanical lock or padlock',
            senseNameDe: 'Mechanische Schließvorrichtung',
            contextSentenceAr: 'أَدْخَلَ المِفْتَاحَ فِي القُفْلِ لِيَفْتَحَ بَابَ البَيْتِ.',
            contextSentenceEn: 'He inserted the key into the lock to open the entrance door.',
            contextSentenceDe: 'Er steckte den Schlüssel ins Schloss, um die Haustür zu öffnen.',
            selectionalCue: 'السِّيَاقُ مَعَ (Schlüssel) وَ(Haustür) يُعَيِّنُ أَدَاةَ الإِغْلَاقِ.',
          ),
        ],
        linguisticAnalysisAr: 'كَلِمَةُ (Schloss) فِي الأَلْمَانِيَّةِ تَجْمَعُ بَيْنَ القَصْرِ وَالقُفْلِ؛ وَتُفَرِّقُ بَيْنَهُمَا قَرَائِنُ الإِسْنَادِ الفِعْلِيِّ.',
        linguisticAnalysisEn: 'German homonym resolved dynamically by co-occurring argument structures (key vs. architecture).',
        linguisticAnalysisDe: 'Klassisches Teekesselchen: Die semantische Zuordnung erfolgt durch syntagmatische Umgebungselemente.',
        disambiguationComplexity: 0.88,
      ),

      // 4. الجناس التام والمستوفي
      const DisambiguationUnit(
        id: 'poly_jin_01',
        category: AmbiguityCategory.paronomasiaJinan,
        targetLemmaAr: 'السَّاعَةُ',
        targetLemmaEn: 'The Hour / Timepiece (As-Sa\'ah)',
        targetLemmaDe: 'Die Stunde / Der Jüngste Tag (As-Sa\'ah)',
        titleAr: 'الجِنَاسُ التَّامُّ فِي اللَّفْظِ مَعَ اخْتِلَافِ المَعْنَى',
        titleEn: 'Complete Paronomasia: Identical Phonetics with Divergent Semantics',
        titleDe: 'Vollständige Paronomasie: Lautliche Identität bei Sinndifferenz',
        senses: [
          AmbiguitySense(
            senseNameAr: 'يَوْمُ القِيَامَةِ وَالبَعْثِ الحَقِّ',
            senseNameEn: 'The Day of Resurrection (The Ultimate Hour)',
            senseNameDe: 'Der Tag des Gerichts / Die Auferstehungsstunde',
            contextSentenceAr: 'وَيَوْمَ تَقُومُ السَّاعَةُ يُبْلِسُ المُجْرِمُونَ.',
            contextSentenceEn: 'And on the day when the Hour strikes, the transgressors will despair.',
            contextSentenceDe: 'Und an dem Tag, da die Stunde heraufzieht, werden die Übeltäter verstummen.',
            selectionalCue: 'الفِعْلُ (تَقُومُ) مَعْرُوفٌ فِي الاصْطِلَاحِ الشَّرْعِيِّ بِيَوْمِ البَعْثِ.',
          ),
          AmbiguitySense(
            senseNameAr: 'الجُزْءُ القَصِيرُ مِنَ الوَقْتِ وَالزَّمَنِ',
            senseNameEn: 'A fleeting hour or brief span of temporal duration',
            senseNameDe: 'Eine kurze Zeitspanne oder irdische Stunde',
            contextSentenceAr: 'مَا لَبِثُوا غَيْرَ سَاعَةٍ كَذَلِكَ كَانُوا يُؤْفَكُونَ.',
            contextSentenceEn: 'They tarried but an hour; thus were they deluded.',
            contextSentenceDe: 'Sie verweilten nur eine Stunde; so ließen sie sich täuschen.',
            selectionalCue: 'السِّيَاقُ يَتَحَدَّثُ عَنِ اللُّبْثِ وَانْقِضَاءِ الزَّمَنِ الدُّنْيَوِيِّ.',
          ),
        ],
        linguisticAnalysisAr: 'اتِّفَاقُ اللَّفْظَيْنِ فِي الحُرُوفِ وَالتَّرْتِيبِ وَالحَرَكَاتِ مَعَ بَيْنُونَةِ المَعْنَى يُعَدُّ جِنَاساً تَامّاً مَرْقُوماً.',
        linguisticAnalysisEn: 'Homophonic identity across all phonological tiers paired with distinct semantic mappings creates poetic cadence.',
        linguisticAnalysisDe: 'Vollkommene klangliche Übereinstimmung zur Erzeugung eines einprägsamen Sinnkontrastes.',
        disambiguationComplexity: 0.94,
      ),
    ];

    _state = _state.copyWith(
      units: defaultUnits,
      selectedUnitId: defaultUnits.first.id,
      activeSenseIndex: 0,
    );
  }

  void selectCategory(AmbiguityCategory category) {
    final filtered = _state.units.where((u) => u.category == category).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedUnitId;
    _state = _state.copyWith(
      selectedCategory: category,
      selectedUnitId: nextId,
      activeSenseIndex: 0,
    );
    notifyListeners();
  }

  void selectUnit(String id) {
    _state = _state.copyWith(
      selectedUnitId: id,
      activeSenseIndex: 0,
    );
    notifyListeners();
  }

  void setActiveSense(int index) {
    _state = _state.copyWith(activeSenseIndex: index);
    notifyListeners();
  }

  void toggleSelectionalCues() {
    _state = _state.copyWith(showSelectionalCues: !_state.showSelectionalCues);
    notifyListeners();
  }

  void toggleComparativeGrid() {
    _state = _state.copyWith(showComparativeGrid: !_state.showComparativeGrid);
    notifyListeners();
  }
}
