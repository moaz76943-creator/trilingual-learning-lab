import 'package:flutter/foundation.dart';

enum ComplementCategory {
  directObjectBihi,      // المفعول به (Direct Object / Akkusativobjekt)
  absoluteCognateMutlaq, // المفعول المطلق وتوكيد الفعل وبيان نوعه وعدده (Cognate Accusative / Verstärkendes Adverbial)
  causalPurposiveLiAjlihi, // المفعول لأجله وبيان علة الحدث (Causal Adverbial / Kausalangabe - Finalität)
  comitativeMaahu,       // المفعول معه وواو المعية (Comitative Object / Begleitumstand mit "mit")
  locativeTemporalFihi   // المفعول فيه (ظرفا الزمان والمكان) (Adverbial of Time/Place / Temporal- & Lokaladverbial)
}

class ComplementScenario {
  final String id;
  final ComplementCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String complementWordAr; // الكلمة المنصوبة على أنها مفعول مشكولة
  final String sentenceAr; // الجملة العربية التامة مشكولة شكلاً تاماً
  final String sentenceEn;
  final String sentenceDe;
  final String syntacticRoleAr;
  final String syntacticRoleEn;
  final String syntacticRoleDe;
  final String crossLinguisticTransferNote; // المقارنة التداولية والترجمية
  final double semanticSalienceScore; // 0.0 إلى 1.0

  const ComplementScenario({
    required this.id,
    required this.category,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.complementWordAr,
    required this.sentenceAr,
    required this.sentenceEn,
    required this.sentenceDe,
    required this.syntacticRoleAr,
    required this.syntacticRoleEn,
    required this.syntacticRoleDe,
    required this.crossLinguisticTransferNote,
    required this.semanticSalienceScore,
  });
}

class FiveObjectsState {
  final ComplementCategory selectedCategory;
  final List<ComplementScenario> scenarios;
  final String selectedScenarioId;
  final bool showSyntacticParsing;
  final bool showUnifiedVerseDemo; // عرض الشاهد الجامع للمفاعيل الخمسة في جملة واحدة

  const FiveObjectsState({
    this.selectedCategory = ComplementCategory.absoluteCognateMutlaq,
    this.scenarios = const [],
    this.selectedScenarioId = 'comp_mutlaq_01',
    this.showSyntacticParsing = true,
    this.showUnifiedVerseDemo = true,
  });

  ComplementScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  // الجملة البلاغية الجامعة للمفاعيل الخمسة في نسق واحد
  static const String comprehensiveMasterSentenceAr =
      'ضَرَبَ المُعَلِّمُ مَثَلاً (مفعول به) يَوْمَ الجُمُعَةِ (مفعول فيه) ضَرْباً مُبِيناً (مفعول مطلق) رَغْبَةً فِي التَّعْلِيمِ (مفعول لأجله) وَطُلُوعَ الشَّمْسِ (مفعول معه).';
  static const String comprehensiveMasterSentenceEn =
      'The teacher set an example (Direct Object) on Friday (Time Adverbial) with utmost clarity (Cognate Adverbial), seeking to impart wisdom (Purpose Adverbial), alongside the rising of the sun (Comitative).';
  static const String comprehensiveMasterSentenceDe =
      'Der Lehrer gab am Freitag (Temporaladverbial) ein anschauliches Beispiel (Akkusativobjekt) in vollendeter Deutlichkeit (Modaler Verstärker), aus Hingabe zur Bildung (Kausalangabe), zeitgleich mit dem Sonnenaufgang (Komitativangabe).';

  FiveObjectsState copyWith({
    ComplementCategory? selectedCategory,
    List<ComplementScenario>? scenarios,
    String? selectedScenarioId,
    bool? showSyntacticParsing,
    bool? showUnifiedVerseDemo,
  }) {
    return FiveObjectsState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      showSyntacticParsing: showSyntacticParsing ?? this.showSyntacticParsing,
      showUnifiedVerseDemo: showUnifiedVerseDemo ?? this.showUnifiedVerseDemo,
    );
  }
}

class FiveObjectsController extends ChangeNotifier {
  FiveObjectsState _state = const FiveObjectsState();
  FiveObjectsState get state => _state;

  FiveObjectsController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. المفعول المطلق: المصدر المنصوب المؤكد أو المبين للنوع والعدد
      const ComplementScenario(
        id: 'comp_mutlaq_01',
        category: ComplementCategory.absoluteCognateMutlaq,
        titleAr: 'المَفْعُولُ المُطْلَقُ: تَوْكِيدُ الحَدَثِ وَبَيَانُ نَوْعِهِ وَعَدَدِهِ',
        titleEn: 'Cognate Accusative: Verbal Intensification & Manner Specification',
        titleDe: 'Kognates Adverbial (Absolutes Objekt) zur Intensivierung & Spezifikation',
        complementWordAr: 'صَبْراً جَمِيلاً',
        sentenceAr: 'فَاصْبِرْ عَلَى لَأْوَاءِ الدُّنْيَا صَبْراً جَمِيلاً، وَتَوَكَّلْ عَلَى الرَّحْمَنِ تَوَكُّلاً.',
        sentenceEn: 'Endure the tribulations of worldly life with noble patience, and rely upon the Merciful with unyielding reliance.',
        sentenceDe: 'Ertrage die Mühsal des Lebens mit edler Geduld, und vertraue dem Barmherzigen mit unerschütterlicher Ergebenheit.',
        syntacticRoleAr: '(صَبْراً): مَفْعُولٌ مُطْلَقٌ مَنْصُوبٌ مُبَيِّنٌ لِلنَّوْعِ لِأَنَّهُ مَوْصُوفٌ بِـ(جَمِيلاً)، وَ(تَوَكُّلاً): مُؤَكِّدٌ لِلْفِعْلِ.',
        syntacticRoleEn: 'Cognate accusative deriving directly from root verb; English translates via adverbial phrases ("with noble patience").',
        syntacticRoleDe: 'Im Deutschen durch adverbiale Bestimmungen der Art und Weise ("mit edler Geduld") oder verstärkende Adverbien ausgedrückt.',
        crossLinguisticTransferNote: 'المفعول المطلق خاصية سامية عبقرية لتعزيز الحدث اشتقاقياً؛ ولا يقابلها تكرار الجذر في الإنجليزية والألمانية بل ألفاظ التوكيد (utterly / zutiefst).',
        semanticSalienceScore: 0.98,
      ),

      // 2. المفعول لأجله: المصدر القلبي الدال على الباعث والغاية
      const ComplementScenario(
        id: 'comp_ajlihi_01',
        category: ComplementCategory.causalPurposiveLiAjlihi,
        titleAr: 'المَفْعُولُ لِأَجْلِهِ: بَيَانُ البَاعِثِ القَلْبِيِّ وَعِلَّةِ الوُقُوعِ',
        titleEn: 'Causal-Purposive Object: Teleological Intent & Mental Catalyst',
        titleDe: 'Kausal-Finales Objekt: Angabe des inneren Beweggrundes & Motivs',
        complementWordAr: 'رَغْبَةً فِي الأَجْرِ',
        sentenceAr: 'يَقُومُ المُتَطَوِّعُ بِإِغَاثَةِ المَلْهُوفِينَ رَغْبَةً فِي نَيْلِ مَرْضَاةِ اللَّهِ.',
        sentenceEn: 'The volunteer aids the distressed out of a fervent desire to attain God’s pleasure.',
        sentenceDe: 'Der Freiwillige hilft den Notleidenden aus dem aufrichtigen Bestreben, Gottes Wohlgefallen zu erlangen.',
        syntacticRoleAr: '(رَغْبَةً): مَفْعُولٌ لِأَجْلِهِ مَنْصُوبٌ؛ مَصْدَرٌ قَلْبِيٌّ وَقَعَ بَيَاناً لِسَبَبِ وَعِلَّةِ إِغَاثَةِ المَلْهُوفِينَ.',
        syntacticRoleEn: 'Adverbial of purpose/reason ("out of desire"); answers the diagnostic question "Why?" without prepositional clunky phrasing.',
        syntacticRoleDe: 'Präpositionale Kausal- und Finalangabe ("aus dem Bestreben / um ... willen"); im Deutschen meist durch Präpositionen markiert.',
        crossLinguisticTransferNote: 'في العربية يُنصب مباشرة بلا حرف جر إذا كان مصدراً قلبياً متفقاً مع الفعل في الفاعل والزمان، بينما تتطلب الغربية حروف السببية (out of / aus).',
        semanticSalienceScore: 0.95,
      ),

      // 3. المفعول معه: الاسم الصريح الواقع بعد واو المعية
      const ComplementScenario(
        id: 'comp_maahu_01',
        category: ComplementCategory.comitativeMaahu,
        titleAr: 'المَفْعُولُ مَعَهُ: بَيَانُ المُصَاحَبَةِ المَقْرُونَةِ بِوَاوِ المَعِيَّةِ',
        titleEn: 'Comitative Object: Simultaneous Accompaniment with Waw al-Ma\'iyyah',
        titleDe: 'Komitatives Objekt: Begleitumstand und Gleichzeitigkeit (Waw-al-Ma\'iyyah)',
        complementWordAr: 'وَسَيَلَانَ الوَادِي',
        sentenceAr: 'سَارَ الرَّحَّالَةُ العَالِمُ وَسَيَلَانَ الوَادِي مُسْتَكْشِفاً مَسَالِكَ الأَرْضِ.',
        sentenceEn: 'The scholarly explorer traversed alongside the rushing stream, surveying the terrain.',
        sentenceDe: 'Der gelehrte Reisende wanderte entlang des strömenden Tals und erkundete die Pfade.',
        syntacticRoleAr: '(سَيَلَانَ): مَفْعُولٌ مَعَهُ مَنْصُوبٌ بِالفَتْحَةِ بَعْدَ وَاوِ المَعِيَّةِ الَّتِي بِمَعْنَى (مَعَ)، حَيْثُ يَمْتَنِعُ العَطْفُ هُنَا.',
        syntacticRoleEn: 'Comitative accusative governed by associative particle "wa" (meaning "with/alongside"); distinguishes accompaniment from joint agency.',
        syntacticRoleDe: 'Komitatives Verhältnis: Das Deutsche nutzt Präpositionalphrasen ("entlang des", "zeitgleich mit"), da ein reines Objekt fehlt.',
        crossLinguisticTransferNote: 'يمتنع العطف حين يستحيل اشتراك ما بعد الواو في أصل الفعل (فالوادي لا يسير مع الرحالة على قدميه)، فتتعين واو المعية لنصب المفعول معه.',
        semanticSalienceScore: 0.94,
      ),

      // 4. المفعول فيه: ظرفا الزمان والمكان المتضمنان معنى (في)
      const ComplementScenario(
        id: 'comp_fihi_01',
        category: ComplementCategory.locativeTemporalFihi,
        titleAr: 'المَفْعُولُ فِيهِ: الإِطَارُ الزَّمَانِيُّ وَالمَكَانِيُّ المُتَضَمِّنُ مَعْنَى (فِي)',
        titleEn: 'Adverbial of Time & Space (Zarf): Locative & Temporal Inclusivity',
        titleDe: 'Temporal- und Lokaladverbial (Maf\'ul Fihi): Der situative Handlungsrahmen',
        complementWordAr: 'فَوْقَ الذُّرَى سَحَراً',
        sentenceAr: 'وَقَفَ المُتَأَمِّلُ فَوْقَ الذُّرَى سَحَراً يَتَدَبَّرُ آيَاتِ الآفَاقِ.',
        sentenceEn: 'The contemplator stood atop the summits at dawn, pondering the cosmic signs.',
        sentenceDe: 'Der Nachsinnende stand in der Morgendämmerung auf den Berggipfeln und betrachtete die Zeichen.',
        syntacticRoleAr: '(فَوْقَ): مَفْعُولٌ فِيهِ ظَرْفُ مَكَانٍ مَنْصُوبٌ، وَ(سَحَراً): مَفْعُولٌ فِيهِ ظَرْفُ زَمَانٍ مَنْصُوبٌ.',
        syntacticRoleEn: 'Direct temporal and locative adverbs carrying inherent prepositional containment ("in/at/upon").',
        syntacticRoleDe: 'Temporale und lokale Adverbiale; im Deutschen meist durch Präpositionalkasūs (Dativ/Akkusativ) realisiert.',
        crossLinguisticTransferNote: 'شرط المفعول فيه تضمن معنى حرف الظرفية (في)؛ فإذا لم يتضمنها أُعرب حسب موقعه من الجملة (مثلاً: يَوْمُ الجُمُعَةِ يَوْمٌ مُبَارَكٌ).',
        semanticSalienceScore: 0.93,
      ),

      // 5. المفعول به: المتمم المباشر الواقع عليه فعل الفاعل
      const ComplementScenario(
        id: 'comp_bihi_01',
        category: ComplementCategory.directObjectBihi,
        titleAr: 'المَفْعُولُ بِهِ: المَحَلُّ الصَّرِيحُ الَّذِي وَقَعَ عَلَيْهِ فِعْلُ الفَاعِلِ',
        titleEn: 'Direct Object (Maf\'ul Bihi): Patient/Theme Argument Realization',
        titleDe: 'Direktes Akkusativobjekt: Der unmittelbare Träger der Handlung',
        complementWordAr: 'العِلْمَ النَّافِعَ',
        sentenceAr: 'يَطْلُبُ الحَكِيمُ العِلْمَ النَّافِعَ لِيَبْنِيَ بِهِ الحَضَارَةَ وَيَصُونَ الفَضِيلَةَ.',
        sentenceEn: 'The wise seeker pursues beneficial knowledge to cultivate civilization and safeguard virtue.',
        sentenceDe: 'Der Weise sucht nach nützlichem Wissen, um Zivilisation zu schaffen und Tugend zu wahren.',
        syntacticRoleAr: '(العِلْمَ): مَفْعُولٌ بِهِ مَنْصُوبٌ بِالفَتْحَةِ الظَّاهِرَةِ، وَقَعَ عَلَيْهِ فِعْلُ الطَّلَبِ مُبَاشَرَةً.',
        syntacticRoleEn: 'Core direct complement (transitive patient/theme) marked by morphological accusative.',
        syntacticRoleDe: 'Direktes Objekt im Akkusativ, gebunden an die Rektion des transitiven Verbs.',
        crossLinguisticTransferNote: 'المفعول به هو الأصل في المفاعيل، وسائر المفاعيل الأربعة الأخرى تسمى قيوداً ومتممات ظرفية وسببية ومصاحبة مؤكدة.',
        semanticSalienceScore: 0.96,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectCategory(ComplementCategory category) {
    final filtered = _state.scenarios.where((s) => s.category == category).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedScenarioId;
    _state = _state.copyWith(
      selectedCategory: category,
      selectedScenarioId: nextId,
    );
    notifyListeners();
  }

  void selectScenario(String id) {
    _state = _state.copyWith(selectedScenarioId: id);
    notifyListeners();
  }

  void toggleSyntacticParsing() {
    _state = _state.copyWith(showSyntacticParsing: !_state.showSyntacticParsing);
    notifyListeners();
  }

  void toggleUnifiedVerseDemo() {
    _state = _state.copyWith(showUnifiedVerseDemo: !_state.showUnifiedVerseDemo);
    notifyListeners();
  }
}
