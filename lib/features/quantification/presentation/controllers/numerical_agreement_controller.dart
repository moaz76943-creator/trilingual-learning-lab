import 'package:flutter/foundation.dart';

enum QuantificationCategory {
  inverseAgreement3to10,  // مخالفة العدد للمعدود (٣ إلى ١٠) + جمع مجرور
  compoundTeens11to19,    // الأعداد المركبة (١١ إلى ١٩) + مفرد منصوب
  partitiveMeasureUnits,  // وحدات القياس والكميات غير المعدودة (Partitives / Maßangaben)
  vagueQuantifiers        // كنايات العدد ومحددات الكمية (كَمْ، بِضْعٌ / few-little / wenig-viel)
}

class QuantificationScenario {
  final String id;
  final QuantificationCategory category;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String expressionAr; // العبارة العربية مشكولة شكلاً تاماً
  final String expressionEn;
  final String expressionDe;
  final String grammaticalRuleAr;
  final String grammaticalRuleEn;
  final String grammaticalRuleDe;
  final String commonPitfallAr;
  final String commonPitfallEn;
  final String commonPitfallDe;
  final double syntacticComplexityScore; // 0.0 إلى 1.0

  const QuantificationScenario({
    required this.id,
    required this.category,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.expressionAr,
    required this.expressionEn,
    required this.expressionDe,
    required this.grammaticalRuleAr,
    required this.grammaticalRuleEn,
    required this.grammaticalRuleDe,
    required this.commonPitfallAr,
    required this.commonPitfallEn,
    required this.commonPitfallDe,
    required this.syntacticComplexityScore,
  });
}

class NumericalAgreementState {
  final QuantificationCategory selectedCategory;
  final List<QuantificationScenario> scenarios;
  final String selectedScenarioId;
  final int interactiveCount; // قيمة تفاعلية لتطبيق قاعدة العدد (مثلاً 3..10 أو 11..19)
  final bool isFeminineCountedNoun; // لتبديل جنس المعدود في المحاكي التفاعلي
  final bool showCommonPitfalls;

  const NumericalAgreementState({
    this.selectedCategory = QuantificationCategory.inverseAgreement3to10,
    this.scenarios = const [],
    this.selectedScenarioId = 'quant_3_10',
    this.interactiveCount = 7,
    this.isFeminineCountedNoun = false,
    this.showCommonPitfalls = true,
  });

  QuantificationScenario? get currentScenario {
    if (scenarios.isEmpty) return null;
    return scenarios.firstWhere(
      (s) => s.id == selectedScenarioId,
      orElse: () => scenarios.first,
    );
  }

  String get dynamicArabicPreview {
    final n = interactiveCount;
    final noun = isFeminineCountedNoun ? 'آيَاتٍ' : 'كُتُبٍ';
    final singular = isFeminineCountedNoun ? 'آيَةً' : 'كِتَاباً';

    if (n >= 3 && n <= 10) {
      const mascNumbers = {
        3: 'ثَلَاثَةُ',
        4: 'أَرْبَعَةُ',
        5: 'خَمْسَةُ',
        6: 'سِتَّةُ',
        7: 'سَبْعَةُ',
        8: 'ثَمَانِيَةُ',
        9: 'تِسْعَةُ',
        10: 'عَشَرَةُ',
      };
      const femNumbers = {
        3: 'ثَلَاثُ',
        4: 'أَرْبَعُ',
        5: 'خَمْسُ',
        6: 'سِتُّ',
        7: 'سَبْعُ',
        8: 'ثَمَانِي',
        9: 'تِسْعُ',
        10: 'عَشْرُ',
      };
      final numWord = isFeminineCountedNoun ? femNumbers[n] : mascNumbers[n];
      return '$numWord $noun';
    } else if (n == 11 || n == 12) {
      if (n == 11) {
        return isFeminineCountedNoun ? 'إِحْدَى عَشْرَةَ $singular' : 'أَحَدَ عَشَرَ $singular';
      } else {
        return isFeminineCountedNoun ? 'اثْنَتَا عَشْرَةَ $singular' : 'اثْنَا عَشَرَ $singular';
      }
    } else if (n >= 13 && n <= 19) {
      const unitMasc = {3: 'ثَلَاثَةَ', 4: 'أَرْبَعَةَ', 5: 'خَمْسَةَ', 6: 'سِتَّةَ', 7: 'سَبْعَةَ', 8: 'ثَمَانِيَةَ', 9: 'تِسْعَةَ'};
      const unitFem = {3: 'ثَلَاثَ', 4: 'أَرْبَعَ', 5: 'خَمْسَ', 6: 'سِتَّ', 7: 'سَبْعَ', 8: 'ثَمَانِيَ', 9: 'تِسْعَ'};
      final u = n - 10;
      if (isFeminineCountedNoun) {
        return '${unitFem[u]} عَشْرَةَ $singular';
      } else {
        return '${unitMasc[u]} عَشَرَ $singular';
      }
    }
    return 'عِشْرُونَ $singular';
  }

  NumericalAgreementState copyWith({
    QuantificationCategory? selectedCategory,
    List<QuantificationScenario>? scenarios,
    String? selectedScenarioId,
    int? interactiveCount,
    bool? isFeminineCountedNoun,
    bool? showCommonPitfalls,
  }) {
    return NumericalAgreementState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      scenarios: scenarios ?? this.scenarios,
      selectedScenarioId: selectedScenarioId ?? this.selectedScenarioId,
      interactiveCount: interactiveCount ?? this.interactiveCount,
      isFeminineCountedNoun: isFeminineCountedNoun ?? this.isFeminineCountedNoun,
      showCommonPitfalls: showCommonPitfalls ?? this.showCommonPitfalls,
    );
  }
}

class NumericalAgreementController extends ChangeNotifier {
  NumericalAgreementState _state = const NumericalAgreementState();
  NumericalAgreementState get state => _state;

  NumericalAgreementController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultScenarios = [
      // 1. الأعداد المفردة (3-10): المخالفة والجمع المجرور
      const QuantificationScenario(
        id: 'quant_3_10',
        category: QuantificationCategory.inverseAgreement3to10,
        titleAr: 'مُخَالَفَةُ العَدَدِ لِلْمَعْدُودِ (٣ - ١٠) وَتَمْيِيزُهُ المَجْرُورُ',
        titleEn: 'Inverse Gender Agreement (3–10) & Plural Quantification',
        titleDe: 'Zahl-Genus-Regel & Plural-Deklination nach Kardinalzahlen',
        expressionAr: 'قَرَأْتُ سَبْعَةَ كُتُبٍ نَافِعَةٍ فِي ثَمَانِي لَيَالٍ مُبَارَكَةٍ.',
        expressionEn: 'I read seven beneficial books over eight blessed nights.',
        expressionDe: 'Ich las sieben nützliche Bücher in acht gesegneten Nächten.',
        grammaticalRuleAr: 'الأَعْدَادُ (٣-١٠) تُخَالِفُ مُفْرَدَ المَعْدُودِ تَذْكِيراً وَتَأْنِيثاً، وَتَمْيِيزُهَا جَمْعُ قِلَّةٍ مَجْرُورٌ بِالإِضَافَةِ.',
        grammaticalRuleEn: 'Plural countable nouns take plural inflection regardless of gender; compound modifiers stay singular ("a seven-book shelf").',
        grammaticalRuleDe: 'Im Deutschen bleibt das Adjektiv nach Kardinalzahlen stark dekliniert ("sieben nützliche Bücher", Akkusativ Plural).',
        commonPitfallAr: 'الخطأ الشائع: تَطْبِيقُ التَّذْكِيرِ عَلَى (كُتُبٍ) بِنَاءً عَلَى لَفْظِ الجَمْعِ دُونَ الرُّجُوعِ لِلْمُفْرَدِ (كِتَابٌ مُذَكَّرٌ).',
        commonPitfallEn: 'Pitfall: Adding plural "-s" inside hyphenated numerical modifiers ("eight-nights stay" is incorrect).',
        commonPitfallDe: 'Fehlerquelle: Falsche Adjektivendung (-en statt -e) im Akkusativ Plural ohne Artikel.',
        syntacticComplexityScore: 0.94,
      ),

      // 2. الأعداد المركبة (11-19): التطابق الجزئي والتمييز المنصوب
      const QuantificationScenario(
        id: 'quant_11_19',
        category: QuantificationCategory.compoundTeens11to19,
        titleAr: 'الأَعْدَادُ المُرَكَّبَةُ (١١ - ١٩): البِنَاءُ عَلَى فَتْحِ الجُزْأَيْنِ',
        titleEn: 'Compound Numerals (11–19) & Singular Accusative Specification',
        titleDe: 'Zusammengesetzte Zahlen (11–19) & Invariante Wortstellung',
        expressionAr: 'حَفِظَ الطَّالِبُ أَحَدَ عَشَرَ جُزْءاً وَخَمْسَ عَشْرَةَ سُورَةً.',
        expressionEn: 'The student memorized eleven sections and fifteen chapters.',
        expressionDe: 'Der Schüler lernte elf Abschnitte und fünfzehn Kapitel auswendig.',
        grammaticalRuleAr: '(١١-١٢) يُطَابِقَانِ المَعْدُودَ بِجُزْأَيْهِمَا، أَمَّا (١٣-١٩) فَالْجُزْءُ الأَوَّلُ يُخَالِفُ وَالثَّانِي يُطَابِقُ مَعَ تَمْيِيزٍ مُفْرَدٍ مَنْصُوبٍ.',
        grammaticalRuleEn: 'All numerals above 1 require plural nouns in English ("fifteen chapters"), unlike Arabic singular accusative.',
        grammaticalRuleDe: 'Zahlen ab 13 werden zusammengeschrieben; ab 21 erfolgt im Deutschen Einer-vor-Zehner-Umkehrung (einundzwanzig).',
        commonPitfallAr: 'الخطأ الشائع: جَمْعُ التَّمْيِيزِ بَعْدَ الأَعْدَادِ المُرَكَّبَةِ مِثْلَ (خَمْسَ عَشْرَةَ سُوَرٍ) وَالصَّوَابُ الإِفْرَادُ وَالنَّصْبُ.',
        commonPitfallEn: 'Pitfall: Omitting pluralization when translating directly from Arabic singular tamyiz ("fifteen chapter").',
        commonPitfallDe: 'Fehlerquelle: Vertauschung der Zehner- und Einerstelle beim Sprechen oder Schreiben über 20.',
        syntacticComplexityScore: 0.98,
      ),

      // 3. وحدات القياس والكميات غير المعدودة (Partitives & Maßangaben)
      const QuantificationScenario(
        id: 'quant_part_01',
        category: QuantificationCategory.partitiveMeasureUnits,
        titleAr: 'تَمْيِيزُ المَقَادِيرِ وَالأَسْمَاءُ غَيْرُ المَعْدُودَةِ (Partitives)',
        titleEn: 'Partitive Constructions & Uncountable Noun Quantification',
        titleDe: 'Mengen- und Maßangaben: Invariante Neutra/Maskulina im Plural',
        expressionAr: 'أَخَذْتُ قِطْعَتَيْنِ مِنَ النَّصِيحَةِ الخَالِصَةِ وَكُوبَيْنِ مِنَ المَاءِ العَذْبِ.',
        expressionEn: 'I took two pieces of sincere advice and two glasses of fresh water.',
        expressionDe: 'Ich erhielt zwei wertvolle Ratschläge und zwei Glas frisches Wasser.',
        grammaticalRuleAr: 'يَجُوزُ فِي تَمْيِيزِ المَقَادِيرِ النَّصْبُ أَوِ الجَرُّ بِـ(مِنْ) أَوْ بِالإِضَافَةِ لإِيضَاحِ النَّوْعِ وَالْمِقْدَارِ.',
        grammaticalRuleEn: 'Uncountable nouns ("advice", "information") cannot take direct numerals and require partitive containers ("two pieces of advice").',
        grammaticalRuleDe: 'Maskuline und neutrale Maßeinheiten bleiben nach Zahlen im Singular ("zwei Glas", "drei Kilo", "fünf Euro").',
        commonPitfallAr: 'الخطأ الشائع: تَجْمِيعُ الكَلِمَاتِ غَيْرِ المَعْدُودَةِ فِي الإِنْجِلِيزِيَّةِ مِثْلَ (two advices / informations).',
        commonPitfallEn: 'Pitfall: Pluralizing mass nouns ("two advices", "three breads") instead of using partitive counters.',
        commonPitfallDe: 'Fehlerquelle: Falsche Pluralbildung bei Maßangaben wie "zwei Gläser Wasser" statt "zwei Glas Wasser".',
        syntacticComplexityScore: 0.92,
      ),

      // 4. كنايات العدد ومحددات الكمية (كَمْ، بِضْعٌ / few-little)
      const QuantificationScenario(
        id: 'quant_vag_01',
        category: QuantificationCategory.vagueQuantifiers,
        titleAr: 'كِنَايَاتُ العَدَدِ وَمُحَدِّدَاتُ الكَمِّيَّةِ (كَمْ وَبِضْعٌ / Few vs. Little)',
        titleEn: 'Vague Quantifiers & Polarity: Few/A Few vs. Little/A Little',
        titleDe: 'Indefinitpronomen & Mengenwörter: wenig vs. ein wenig / einige',
        expressionAr: 'كَمْ آيَةٍ مُحْكَمَةٍ تَدَبَّرْتَهَا، وَلَا يَزَالُ مَعَنَا بِضْعُ سَاعَاتٍ نَغْتَنِمُهَا.',
        expressionEn: 'How many clear verses have you pondered, while we still have a few precious hours left.',
        expressionDe: 'Wie viele klare Verse hast du bedacht, während uns noch einige kostbare Stunden bleiben.',
        grammaticalRuleAr: '(كَمْ) الخَبَرِيَّةُ تَدُلُّ عَلَى الكَثْرَةِ وَتَمْيِيزُهَا مَجْرُورٌ، وَ(بِضْعٌ) تَدُلُّ عَلَى (٣-٩) وَتُخَالِفُ المَعْدُودَ.',
        grammaticalRuleEn: '"A few / a little" carry positive sufficiency, whereas "few / little" highlight scarcity.',
        grammaticalRuleDe: '"Einige" steht im Plural für Zählbares, "etwas / ein wenig" im Singular für Nichtzählbares.',
        commonPitfallAr: 'الخطأ الشائع: الخَلْطُ بَيْنَ (كَمْ) الاسْتِفْهَامِيَّةِ (تَمْيِيزٌ مُفْرَدٌ مَنْصُوبٌ) وَ(كَمْ) الخَبَرِيَّةِ (تَمْيِيزٌ مَجْرُورٌ).',
        commonPitfallEn: 'Pitfall: Confusing "fewer" (countable) with "less" (uncountable), or "little" with "a little".',
        commonPitfallDe: 'Fehlerquelle: Verwendung von "viele" mit Singular-Stoffnamen ("viele Zeit" statt "viel Zeit").',
        syntacticComplexityScore: 0.95,
      ),
    ];

    _state = _state.copyWith(
      scenarios: defaultScenarios,
      selectedScenarioId: defaultScenarios.first.id,
    );
  }

  void selectCategory(QuantificationCategory category) {
    final filtered = _state.scenarios.where((s) => s.category == category).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedScenarioId;
    int nextCount = _state.interactiveCount;
    if (category == QuantificationCategory.inverseAgreement3to10) nextCount = 7;
    if (category == QuantificationCategory.compoundTeens11to19) nextCount = 15;
    _state = _state.copyWith(
      selectedCategory: category,
      selectedScenarioId: nextId,
      interactiveCount: nextCount,
    );
    notifyListeners();
  }

  void updateInteractiveCount(int count) {
    _state = _state.copyWith(interactiveCount: count.clamp(3, 19));
    notifyListeners();
  }

  void toggleCountedNounGender() {
    _state = _state.copyWith(isFeminineCountedNoun: !_state.isFeminineCountedNoun);
    notifyListeners();
  }

  void toggleCommonPitfalls() {
    _state = _state.copyWith(showCommonPitfalls: !_state.showCommonPitfalls);
    notifyListeners();
  }
}
