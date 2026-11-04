class ProportionalityRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ProportionalityRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class CorrelativeProportionalityComparator {
  static List<ProportionalityRuleGuide> getRules() {
    return const [
      ProportionalityRuleGuide(
        categoryTitle: 'التلازم التناسبي في الحكمة (Proportional Wisdom: بقدر ما / in dem Maße wie)',
        arConstruction: 'بِقَدْرِ مَا + فِعْلٌ مُضَارِعٌ ... بِقَدْرِ مَا + جَوَابُ التَّنَاسُبِ',
        deConstruction: 'in dem Maße, wie ... / je nachdem, wie viel ...',
        enConstruction: 'in proportion as ... / the more ... the more ...',
        exampleAr: 'بِقَدْرِ مَا يَنْقُشُ الصَّانِعُ بِتَأَنٍّ يَظْهَرُ صَفَاءُ الحِكْمَةِ',
        exampleDe: 'In dem Maße, wie der Meister mit Bedacht graviert, strahlt die Weisheit hervor.',
        exampleEn: 'In proportion as the artisan engraves with deliberate care, the clarity of wisdom shines.',
      ),
      ProportionalityRuleGuide(
        categoryTitle: 'التدرج الصاعد في الإتقان (Ascending Scale: كلما زاد / je mehr ... desto)',
        arConstruction: 'كُلَّمَا + فِعْلٌ مَاضٍ ... ازْدَادَ + فِعْلٌ جَوَابِيٌّ',
        deConstruction: 'je + Komparativ (Nebensatz) ... desto + Komparativ (Hauptsatz)',
        enConstruction: 'the + comparative ..., the + comparative ...',
        exampleAr: 'كُلَّمَا رَقَّ المِرْقَمُ ازْدَادَ الخَطُّ بَهَاءً وَدِقَّةً',
        exampleDe: 'Je feiner der Stichel ist, desto edler und genauer wird der Schriftzug.',
        exampleEn: 'The finer the graver is, the nobler and more precise the inscription becomes.',
      ),
    ];
  }
}
