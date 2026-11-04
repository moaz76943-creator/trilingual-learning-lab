class InceptiveRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const InceptiveRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class InceptiveApproximativeComparator {
  static List<InceptiveRuleGuide> getRules() {
    return const [
      InceptiveRuleGuide(
        categoryTitle: 'أفعال الشروع في العمل (Inceptive Aspect: شرع / anfangen)',
        arConstruction: 'شَرَعَ / طَفِقَ / أَنْشَأَ + الفِعْلُ المُضَارِعُ (تفيد البدء الفوري في الحدث)',
        deConstruction: 'anfangen / beginnen zu + Infinitiv am Satzende',
        enConstruction: 'Begin / start to + base form / start + -ing',
        exampleAr: 'شَرَعَ الخَزَّافُ يَبْنِي الخَابِيَةَ الكَبِيرَةَ بِيَدَيْهِ',
        exampleDe: 'Der Töpfer fing an, den großen Tonkrug von Hand aufzubauen.',
        exampleEn: 'The potter began building the large storage jar with his hands.',
      ),
      InceptiveRuleGuide(
        categoryTitle: 'أفعال المقاربة والوشوك (Approximative Aspect: كاد / im Begriff sein)',
        arConstruction: 'كَادَ / أَوْشَكَ + الفِعْلُ المُضَارِعُ (تفيد قرب وقوع الخبر)',
        deConstruction: 'im Begriff sein zu + Infinitiv / beinahe / fast',
        enConstruction: 'Be on the verge of / be about to + base form',
        exampleAr: 'كَادَتِ الخَابِيَةُ تَكْتَمِلُ قَبْلَ مَغِيبِ الشَّمْسِ',
        exampleDe: 'Der Tonkrug war fast vollendet vor Sonnenuntergang.',
        exampleEn: 'The clay jar was on the verge of completion before sunset.',
      ),
    ];
  }
}
