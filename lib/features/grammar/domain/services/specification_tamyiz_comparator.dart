class SpecificationRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const SpecificationRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class SpecificationTamyizComparator {
  static List<SpecificationRuleGuide> getRules() {
    return const [
      SpecificationRuleGuide(
        categoryTitle: 'التمييز الملحوظ لبيان جهة الزيادة أو الكيفية (Tamyiz of Aspect)',
        arConstruction: 'اسم نكرة منصوب يفسر إبهام نسبة الجملة (ازْدَادَ الحَكِيمُ وَقَارًا)',
        deConstruction: 'Präpositionale Ergänzung mit "an + Dativ" (wuchs an Weisheit)',
        enConstruction: 'Prepositional phrase "in / in terms of" (grew in wisdom)',
        exampleAr: 'طَابَ القَبْوُ الحَجَرِيُّ هَوَاءً وَبُرُودَةً',
        exampleDe: 'Das Steingewölbe war angenehm an Luft und Kühle.',
        exampleEn: 'The stone cellar was pleasant in terms of air and coolness.',
      ),
      SpecificationRuleGuide(
        categoryTitle: 'تمييز المقادير والأوزان والمكاييل (Tamyiz of Measure)',
        arConstruction: 'اسم نكرة منصوب بعد أسماء الأوزان والمقاييس (رِطْلٌ زَيْتًا)',
        deConstruction: 'Appositionale Mengenangabe ohne Präposition (ein Pfund Öl)',
        enConstruction: 'Direct measure noun + of + substance (a pound of oil)',
        exampleAr: 'اشْتَرَيْتُ رِطْلًا صَابُونًا مُعَتَّقًا',
        exampleDe: 'Ich kaufte ein Pfund gereifte Seife.',
        exampleEn: 'I bought a pound of cured soap.',
      ),
    ];
  }
}
