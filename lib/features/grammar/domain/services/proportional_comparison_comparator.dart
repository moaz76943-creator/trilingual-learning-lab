class ProportionalRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ProportionalRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ProportionalComparisonComparator {
  static List<ProportionalRuleGuide> getRules() {
    return const [
      ProportionalRuleGuide(
        categoryTitle: 'التناسب الطردي المتوازي (Proportional Scaling: كلما / je... desto)',
        arConstruction: 'كُلَّمَا + فِعْلُ الشَّرْطِ المَاضِي ... كُلَّمَا / جَوَابُ الشَّرْطِ المَاضِي',
        deConstruction: 'je + Komparativ (Nebensatz) ... desto / umso + Komparativ + Verb (Hauptsatz)',
        enConstruction: 'the + comparative ..., the + comparative ...',
        exampleAr: 'كُلَّمَا زَادَ عُمْرُ شَجَرَةِ الزَّيْتُونِ ازْدَادَ خَشَبُهَا صَلَابَةً وَجَمَالًا',
        exampleDe: 'Je älter der Olivenbaum wird, desto fester und schöner ist sein Holz.',
        exampleEn: 'The older the olive tree becomes, the harder and more beautiful its wood is.',
      ),
      ProportionalRuleGuide(
        categoryTitle: 'التناسب بالقدر والمقدار (Proportional Magnitude: بقدر ما)',
        arConstruction: 'بِقَدْرِ مَا + فِعْلٌ ... بِقَدْرِ مَا + جَوَابٌ',
        deConstruction: 'in dem Maße, wie ... / je nach dem, wie ...',
        enConstruction: 'in proportion as ... / the more ..., the more ...',
        exampleAr: 'بِقَدْرِ مَا تَعْتَنِي بِالصَّنْعَةِ تَنَالُ ثِقَةَ النَّاسِ',
        exampleDe: 'In dem Maße, wie du das Handwerk pflegst, gewinnst du das Vertrauen.',
        exampleEn: 'In proportion as you care for the craft, you gain people\'s trust.',
      ),
    ];
  }
}
