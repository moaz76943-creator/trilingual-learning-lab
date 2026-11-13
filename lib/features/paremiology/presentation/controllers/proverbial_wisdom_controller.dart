import 'package:flutter/foundation.dart';

enum WisdomTheme {
  patiencePerseverance, // الصبر والمثابرة وحسن العاقبة (Patience & Fortitude / Geduld & Ausdauer)
  justiceRetribution,   // العدالة وعاقبة المكر والخديعة (Justice & Reaping Actions / Gerechtigkeit)
  adversityBenefit,     // المنحة في طي المحنة والفرج بعد الشدة (Adversity & Hidden Grace / Trost im Unglück)
  cautionHumility       // التواضع والحذر وتجنب الغرور (Prudence & Modesty / Vorsicht & Demut)
}

class ProverbialEntry {
  final String id;
  final WisdomTheme theme;
  final String titleAr;
  final String titleEn;
  final String titleDe;
  final String canonicalProverbAr; // المثل العربي الفصيح مشكولاً شكلاً تاماً
  final String canonicalProverbEn;
  final String canonicalProverbDe;
  final String literalMeaningAr;
  final String literalMeaningEn;
  final String literalMeaningDe;
  final String culturalOriginAr;
  final String universalWisdomAr;
  final String contextualExampleAr;
  final double paremiologicalEquivalence; // 0.0 إلى 1.0 (مؤشر التكافؤ الحكمي)

  const ProverbialEntry({
    required this.id,
    required this.theme,
    required this.titleAr,
    required this.titleEn,
    required this.titleDe,
    required this.canonicalProverbAr,
    required this.canonicalProverbEn,
    required this.canonicalProverbDe,
    required this.literalMeaningAr,
    required this.literalMeaningEn,
    required this.literalMeaningDe,
    required this.culturalOriginAr,
    required this.universalWisdomAr,
    required this.contextualExampleAr,
    required this.paremiologicalEquivalence,
  });
}

class ProverbialWisdomState {
  final WisdomTheme selectedTheme;
  final List<ProverbialEntry> entries;
  final String selectedEntryId;
  final bool showLiteralVsFigurative;
  final bool showCulturalOrigins;

  const ProverbialWisdomState({
    this.selectedTheme = WisdomTheme.patiencePerseverance,
    this.entries = const [],
    this.selectedEntryId = 'prov_pat_01',
    this.showLiteralVsFigurative = true,
    this.showCulturalOrigins = true,
  });

  ProverbialEntry? get currentEntry {
    if (entries.isEmpty) return null;
    return entries.firstWhere(
      (e) => e.id == selectedEntryId,
      orElse: () => entries.first,
    );
  }

  ProverbialWisdomState copyWith({
    WisdomTheme? selectedTheme,
    List<ProverbialEntry>? entries,
    String? selectedEntryId,
    bool? showLiteralVsFigurative,
    bool? showCulturalOrigins,
  }) {
    return ProverbialWisdomState(
      selectedTheme: selectedTheme ?? this.selectedTheme,
      entries: entries ?? this.entries,
      selectedEntryId: selectedEntryId ?? this.selectedEntryId,
      showLiteralVsFigurative: showLiteralVsFigurative ?? this.showLiteralVsFigurative,
      showCulturalOrigins: showCulturalOrigins ?? this.showCulturalOrigins,
    );
  }
}

class ProverbialWisdomController extends ChangeNotifier {
  ProverbialWisdomState _state = const ProverbialWisdomState();
  ProverbialWisdomState get state => _state;

  ProverbialWisdomController() {
    _initializeCatalogue();
  }

  void _initializeCatalogue() {
    final defaultEntries = [
      // 1. الصبر والمثابرة: الصبر مفتاح الفرج / Practice makes perfect / Übung macht den Meister
      const ProverbialEntry(
        id: 'prov_pat_01',
        theme: WisdomTheme.patiencePerseverance,
        titleAr: 'عَاقِبَةُ الصَّبْرِ وَالمُثَابَرَةِ عَلَى المَكَارِهِ',
        titleEn: 'Fortitude & Diligence: Enduring Labor Yields Mastery',
        titleDe: 'Ausdauer & Meisterschaft: Geduld bringt Früchte',
        canonicalProverbAr: 'الصَّبْرُ مِفْتَاحُ الفَرَجِ، وَمَنْ جَدَّ وَجَدَ.',
        canonicalProverbEn: 'Patience is the key to relief, and practice makes perfect.',
        canonicalProverbDe: 'Geduld bringt Rosen, und Übung macht den Meister.',
        literalMeaningAr: 'الصَّبْرُ آلَةٌ لِفَتْحِ أَبْوَابِ التَّيْسِيرِ، وَمَنْ بَذَلَ الجَهْدَ لَقِيَ الثَّمَرَةَ.',
        literalMeaningEn: 'Literal EN: Patience unlocks deliverance; diligence locates attainment.',
        literalMeaningDe: 'Wörtlich DE: Geduld ist der Schlüssel zur Befreiung; Fleiß findet Lohn.',
        culturalOriginAr: 'مَثَلٌ عَرَبِيٌّ إِسْلَامِيٌّ مَأْثُورٌ مُسْتَمَدٌّ مِنْ تَعَالِيمِ التَّوَكُّلِ وَاحْتِسَابِ الأَجْرِ عِنْدَ اللهِ.',
        universalWisdomAr: 'الحِكْمَةُ الكَوْنِيَّةُ: أَنَّ تَجَاوُزَ الشَّدَائِدِ وَبُلُوغَ الإِتْقَانِ مَرْهُونَانِ بِطُولِ النَّفَسِ وَعَدَمِ الاسْتِعْجَالِ.',
        contextualExampleAr: 'تَحَلَّ بِالصَّبْرِ الجَمِيلِ فِي دِرَاسَتِكَ؛ فَالصَّبْرُ مِفْتَاحُ الفَرَجِ، وَكُلُّ عُسْرٍ يَعْقُبُهُ يُسْرٌ.',
        paremiologicalEquivalence: 0.98,
      ),

      // 2. العدالة وعاقبة المكر والخديعة: من حفر حفرة لأخيه / Wer anderen eine Grube gräbt
      const ProverbialEntry(
        id: 'prov_jus_01',
        theme: WisdomTheme.justiceRetribution,
        titleAr: 'سُوءُ عَاقِبَةِ المَكْرِ وَانْعِكَاسُ الكَيْدِ عَلَى صَاحِبِهِ',
        titleEn: 'Poetic Justice: The Plotter Caught in His Own Snare',
        titleDe: 'Kausalität des Unrechts: Wer anderen eine Grube gräbt',
        canonicalProverbAr: 'مَنْ حَفَرَ حُفْرَةً لِأَخِيهِ، وَقَعَ فِيهَا.',
        canonicalProverbEn: 'He who digs a pit for another falls into it himself.',
        canonicalProverbDe: 'Wer anderen eine Grube gräbt, fällt selbst hinein.',
        literalMeaningAr: 'مَنْ أَعَدَّ شَرَكاً لِإِيقَاعِ غَيْرِهِ ارْتَدَّ إِلَيْهِ سُوءُ صَنِيعِهِ.',
        literalMeaningEn: 'Literal EN: Whoever excavates a pitfall for his fellow will stumble into it.',
        literalMeaningDe: 'Wörtlich DE: Wer für andere eine Grube aushebt, stürzt selbst hinein.',
        culturalOriginAr: 'أَصْلٌ حِكَمِيٌّ عَرِيقٌ يُطَابِقُ قَوْلَهُ تَعَالَى: ﴿وَلَا يَحِيقُ المَكْرُ السَّيِّئُ إِلَّا بِأَهْلِهِ﴾.',
        universalWisdomAr: 'الحِكْمَةُ الكَوْنِيَّةُ: ارْتِدَادُ الظُّلْمِ عَلَى الظَّالِمِ، وَأَنَّ المَكْرَ حَبْلُهُ قَصِيرٌ وَشَرُّهُ مَرْدُودٌ.',
        contextualExampleAr: 'حَاوَلَ التَّآمُرَ لِتَعْطِيلِ زُمَلَائِهِ، فَمَنْ حَفَرَ حُفْرَةً لِأَخِيهِ وَقَعَ فِيهَا وَخَسِرَ مَصْدَاقِيَّتَهُ.',
        paremiologicalEquivalence: 0.99,
      ),

      // 3. المنحة في طي المحنة: رب ضارة نافعة / A blessing in disguise / Glück im Unglück
      const ProverbialEntry(
        id: 'prov_adv_01',
        theme: WisdomTheme.adversityBenefit,
        titleAr: 'الخَيْرُ الكَامِنُ فِي المَكْرُوهِ وَبَشَائِرُ الأَمَلِ',
        titleEn: 'Silver Linings: Hidden Grace in Adverse Circumstances',
        titleDe: 'Segen im Ungemach: Das Gute im scheinbaren Nachteil',
        canonicalProverbAr: 'رُبَّ ضَارَّةٍ نَافِعَةٌ، وَعَسَى أَنْ تَكْرَهُوا شَيْئاً وَهُوَ خَيْرٌ لَكُمْ.',
        canonicalProverbEn: 'A blessing in disguise / Every cloud has a silver lining.',
        canonicalProverbDe: 'Glück im Unglück / Nicht alles Schlechte bringt nur Schaden.',
        literalMeaningAr: 'قَدْ يَكُونُ الشَّيْءُ الَّذِي تَظُنُّهُ مُضِرّاً هُوَ عَيْنَ السَّبَبِ فِي نَجَاتِكَ وَظَفَرِكَ.',
        literalMeaningEn: 'Literal EN: Frequently an apparent harm turns out to be beneficial.',
        literalMeaningDe: 'Wörtlich DE: Manch schädliches Ereignis erweist sich als heilsam.',
        culturalOriginAr: 'قَاعِدَةٌ إِيمَانِيَّةٌ عَمِيقَةٌ تُوَجِّهُ قَلْبَ المُؤْمِنِ إِلَى التَّفَاؤُلِ وَحُسْنِ الظَّنِّ بِقَضَاءِ اللهِ وَقَدَرِهِ.',
        universalWisdomAr: 'الحِكْمَةُ الكَوْنِيَّةُ: مَحْدُودِيَّةُ الإِدْرَاكِ البَشَرِيِّ عَنْ إِحَاطَةِ عَوَاقِبِ الأُمُورِ، وَتَحَوُّلِ المِحَنِ إِلَى مِنَحٍ.',
        contextualExampleAr: 'فَاتَهُ مَوْعِدُ السَّفَرِ فَحَزِنَ، ثُمَّ كَانَتْ رُبَّ ضَارَّةٍ نَافِعَةٍ إِذْ أَنْقَذَهُ اللَّهُ مِنْ مَخَاطِرَ جَسِيمَةٍ.',
        paremiologicalEquivalence: 0.96,
      ),

      // 4. التواضع والحذر: لكل جواد كبوة / Nobody is infallible / Auch der Beste strauchelt
      const ProverbialEntry(
        id: 'prov_hum_01',
        theme: WisdomTheme.cautionHumility,
        titleAr: 'طَبِيعَةُ النَّقْصِ البَشَرِيِّ وَمُدَارَاةُ العَثَرَاتِ',
        titleEn: 'Inherent Human Fallibility: Even the Noble Steed Stumbles',
        titleDe: 'Menschliche Unvollkommenheit: Selbst das edelste Ross strauchelt',
        canonicalProverbAr: 'لِكُلِّ جَوَادٍ كَبْوَةٌ، وَلِكُلِّ عَالِمٍ هَفْوَةٌ.',
        canonicalProverbEn: 'Even Homer nods / The best horse stumbles sometimes.',
        canonicalProverbDe: 'Auch der beste Gaul strauchelt einmal / Irren ist menschlich.',
        literalMeaningAr: 'حَتَّى الفَرَسُ الأَصِيلُ قَدْ يَزِلُّ قَدَمُهُ، وَالعَالِمُ النِّحْرِيرُ قَدْ يَعْرِضُ لَهُ السَّهْوُ.',
        literalMeaningEn: 'Literal EN: Every noble courser has a stumble, and every sage an oversight.',
        literalMeaningDe: 'Wörtlich DE: Jedes edle Ross strauchelt einmal, und jeder Gelehrte begeht einen Fehltritt.',
        culturalOriginAr: 'مَثَلٌ فَرَاسِيٌّ عَرَبِيٌّ بَدَوِيٌّ أَصِيلٌ يَدْعُو لِلتَّسَامُحِ مَعَ زَلَّاتِ أَهْلِ الفَضْلِ.',
        universalWisdomAr: 'الحِكْمَةُ الكَوْنِيَّةُ: نَفْيُ العِصْمَةِ عَنِ البَشَرِ، وَالحَثُّ عَلَى العَفْوِ وَالتَّرَاحُمِ عِنْدَ وُقُوعِ العَثْرَةِ.',
        contextualExampleAr: 'لَا تُشَدِّدْ عَلَى أَخِيكَ لِخَطَأٍ وَاحِدٍ بَعْدَ إِحْسَانٍ طَوِيلٍ؛ فَلِكُلِّ جَوَادٍ كَبْوَةٌ.',
        paremiologicalEquivalence: 0.95,
      ),
    ];

    _state = _state.copyWith(
      entries: defaultEntries,
      selectedEntryId: defaultEntries.first.id,
    );
  }

  void selectTheme(WisdomTheme theme) {
    final filtered = _state.entries.where((e) => e.theme == theme).toList();
    final nextId = filtered.isNotEmpty ? filtered.first.id : _state.selectedEntryId;
    _state = _state.copyWith(
      selectedTheme: theme,
      selectedEntryId: nextId,
    );
    notifyListeners();
  }

  void selectEntry(String id) {
    _state = _state.copyWith(selectedEntryId: id);
    notifyListeners();
  }

  void toggleLiteralVsFigurative() {
    _state = _state.copyWith(showLiteralVsFigurative: !_state.showLiteralVsFigurative);
    notifyListeners();
  }

  void toggleCulturalOrigins() {
    _state = _state.copyWith(showCulturalOrigins: !_state.showCulturalOrigins);
    notifyListeners();
  }
}
