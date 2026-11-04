class ComplexCausalRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ComplexCausalRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ComplexCausalComparator {
  static List<ComplexCausalRuleGuide> getRules() {
    return const [
      ComplexCausalRuleGuide(
        categoryTitle: 'السببية السببية المركبة (Prepositional Causality: بناءً على / aufgrund)',
        arConstruction: 'بِنَاءً عَلَى / انْطِلَاقًا مِنْ + الاسم المجرور الموضح للدافع',
        deConstruction: 'Präposition "aufgrund" / "infolge" (+ Genitiv)',
        enConstruction: 'On the basis of / owing to + noun phrase',
        exampleAr: 'طَارَ الحَمَامُ الزَّاجِلُ سَرِيعًا بِنَاءً عَلَى تَدْرِيبِهِ المُتْقَنِ',
        exampleDe: 'Die Brieftaube flog rasch aufgrund ihres gründlichen Trainings.',
        exampleEn: 'The carrier pigeon flew swiftly owing to its thorough training.',
      ),
      ComplexCausalRuleGuide(
        categoryTitle: 'الربط الاستنتاجي في صدر الجملة (Inferential Result: من هنا / demzufolge)',
        arConstruction: 'مِنْ هُنَا / مِنْ ثَمَّ (ظرف دال على التفرع المنطقي)',
        deConstruction: 'Konjunktionaladverb: "demzufolge", "aus diesem Grund" (Inversion)',
        enConstruction: 'Hence / for this reason / consequently',
        exampleAr: 'أَخْلَصَ الصَّانِعُ فِي رِعَايَتِهَا، وَمِنْ هُنَا أَلِفَتِ البَيْتَ',
        exampleDe: 'Der Züchter sorgte treu für sie; demzufolge blieb sie dem Heim treu.',
        exampleEn: 'The breeder cared faithfully for it; hence it remained loyal to home.',
      ),
    ];
  }
}
