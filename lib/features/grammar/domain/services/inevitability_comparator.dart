class InevitabilityRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const InevitabilityRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class InevitabilityComparator {
  static List<InevitabilityRuleGuide> getRules() {
    return const [
      InevitabilityRuleGuide(
        categoryTitle: 'اليقين الحتمي والتحقيق (Certain Assertion: قد + الماضي / zweifellos)',
        arConstruction: 'قَدْ (حرف تحقيق) + الفعل الماضي / تَبَيَّنَ يَقِينًا أَنَّ + الجملة',
        deConstruction: 'Es steht zweifellos fest, dass ... (Nebensatz: Verb am Ende)',
        enConstruction: 'It is undeniably established that + clause',
        exampleAr: 'قَدْ تَبَيَّنَ يَقِينًا أَنَّ نَقْرَ الرَّحَى يُنَعِّمُ الدَّقِيقَ',
        exampleDe: 'Es steht zweifellos fest, dass das Schärfen des Mühlsteins das Mehl feiner mahlt.',
        exampleEn: 'It is undeniably established that dressing the millstone grinds flour finer.',
      ),
      InevitabilityRuleGuide(
        categoryTitle: 'الحتمية واللزوم المطلق (Absolute Inevitability: لا محالة / unweigerlich)',
        arConstruction: 'لَا مَحَالَةَ / لَا بُدَّ وَأَنْ + الفعل المضارع المنصوب',
        deConstruction: 'unweigerlich / unausweichlich (Adverb der Notwendigkeit)',
        enConstruction: 'Inevitably / necessarily + verb',
        exampleAr: 'يَجْنِي المُجْتَهِدُ ثَمَرَةَ سَعْيِهِ لَا مَحَالَةَ',
        exampleDe: 'Der Fleißige erntet die Frucht seines Strebens unweigerlich.',
        exampleEn: 'The diligent inevitably reaps the fruit of his endeavor.',
      ),
    ];
  }
}
