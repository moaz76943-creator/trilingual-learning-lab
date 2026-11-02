class CorrelativePairRule {
  final String pairName;
  final String arPair;
  final String dePair;
  final String enPair;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const CorrelativePairRule({
    required this.pairName,
    required this.arPair,
    required this.dePair,
    required this.enPair,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class CorrelativeConjunctionsComparator {
  static List<CorrelativePairRule> getRules() {
    return const [
      CorrelativePairRule(
        pairName: 'الشمول والجمع الإيجابي (Inclusive Addition)',
        arPair: 'لَيْسَ ... فَحَسْبُ، بَلْ ... أَيْضًا',
        dePair: 'nicht nur ... sondern auch',
        enPair: 'not only ... but also',
        exampleAr: 'الوَرَقُ لَيْسَ جَمِيلًا فَحَسْبُ، بَلْ مَتِينٌ أَيْضًا',
        exampleDe: 'Das Papier ist nicht nur schön, sondern auch haltbar.',
        exampleEn: 'The paper is not only beautiful, but also durable.',
      ),
      CorrelativePairRule(
        pairName: 'التناسب والتلازم الطردي (Proportional Correlation)',
        arPair: 'كُلَّمَا ... كُلَّمَا (أَوْ جَوَابُ الشَّرْطِ المَاضِي)',
        dePair: 'je + Komparativ (Nebensatz), desto/umso + Komparativ (Hauptsatz)',
        enPair: 'the + comparative ..., the + comparative ...',
        exampleAr: 'كُلَّمَا دَقَّقَ الصَّانِعُ عَمَلَهُ ارْتَفَعَتْ قِيمَتُهُ',
        exampleDe: 'Je sorgfältiger der Handwerker arbeitet, desto höher ist der Wert.',
        exampleEn: 'The more carefully the artisan works, the higher the value.',
      ),
    ];
  }
}
