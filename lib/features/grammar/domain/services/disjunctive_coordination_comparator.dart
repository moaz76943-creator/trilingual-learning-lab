class DisjunctiveRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const DisjunctiveRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class DisjunctiveCoordinationComparator {
  static List<DisjunctiveRuleGuide> getRules() {
    return const [
      DisjunctiveRuleGuide(
        categoryTitle: 'العطف التخييري البسيط (Simple Disjunctive: أو / oder)',
        arConstruction: 'أَوْ (حرف عطف يفيد التخيير أو الإباحة أو الشك أو التقسيم)',
        deConstruction: 'Konjunktion "oder" auf Position 0 (verbindet gleichrangige Satzglieder)',
        enConstruction: 'Coordinating conjunction "or" linking coordinate elements',
        exampleAr: 'نَصْنَعُ البِسَاطَ مِنَ الصُّوفِ النَّقِيِّ أَوْ شَعْرِ الإِبِلِ',
        exampleDe: 'Wir fertigen den Teppich aus reiner Wolle oder Kamelhaar.',
        exampleEn: 'We craft the rug from pure wool or camel hair.',
      ),
      DisjunctiveRuleGuide(
        categoryTitle: 'طلب التعيين الدقيق بين أمرين (Designation: أَمْ / entweder... oder)',
        arConstruction: 'أَمْ (المتصلة المسبوقة بهمزة الاستفهام أو همزة التسوية لطلب التعيين)',
        deConstruction: 'Mehrteiliger Konnektor "entweder ... oder" zur Hervorhebung von Alternativen',
        enConstruction: 'Correlative "either ... or ..." / direct interrogative alternative',
        exampleAr: 'أَبِسَاطَ اللِّبْدِ تُفَضِّلُ أَمْ حَصِيرَ السَّعَفِ؟',
        exampleDe: 'Bevorzugst du entweder den Filzteppich oder die Palmblattmatte?',
        exampleEn: 'Do you prefer the felt rug or the palm leaf mat?',
      ),
    ];
  }
}
