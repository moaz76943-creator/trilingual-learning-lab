class ExchangeRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ExchangeRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ProportionateExchangeComparator {
  static List<ExchangeRuleGuide> getRules() {
    return const [
      ExchangeRuleGuide(
        categoryTitle: 'باء العوض والمقابلة في التبادل (Equitable Exchange: باء المقابلة / im Austausch für)',
        arConstruction: 'بَاءُ العِوَضِ تَدْخُلُ عَلَى الثَّمَنِ أَوْ البَدِيلِ المُقَابِلِ (اشْتَرَيْتُ هَذَا بِذَاكَ)',
        deConstruction: 'im Austausch gegen / für (+ Akkusativ) drückt den Gegenwert aus',
        enConstruction: 'in exchange for / in return for + noun',
        exampleAr: 'أَعْطَيْتُهُ صَاعًا مِنَ القَمْحِ بِصَاعٍ مِنَ التَّمْرِ يَدًا بِيَدٍ',
        exampleDe: 'Ich gab ihm ein Maß Weizen im Austausch gegen ein Maß Datteln, Hand in Hand.',
        exampleEn: 'I gave him a measure of wheat in exchange for a measure of dates, hand to hand.',
      ),
      ExchangeRuleGuide(
        categoryTitle: 'المكافأة والجزاء العادل (Reciprocal Just Reward)',
        arConstruction: 'جَزَاءً بِـ / مُكَافَأَةً عَلَى + اسْمٍ مَجْرُورٍ',
        deConstruction: 'als gerechter Lohn für / zur Belohnung von',
        enConstruction: 'as a fair recompense for / in reward for',
        exampleAr: 'نَالَ الصَّانِعُ خَيْرًا جَزَاءً بِإِتْقَانِهِ وَإِخْلَاصِهِ',
        exampleDe: 'Der Handwerker empfing Gutes als gerechten Lohn für seine Meisterschaft.',
        exampleEn: 'The artisan received bounty as a fair reward for his excellence.',
      ),
    ];
  }
}
