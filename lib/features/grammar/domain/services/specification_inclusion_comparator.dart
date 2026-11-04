class SpecificationInclusionRule {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const SpecificationInclusionRule({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class SpecificationInclusionComparator {
  static List<SpecificationInclusionRule> getRules() {
    return const [
      SpecificationInclusionRule(
        categoryTitle: 'أسلوب الاختصاص المنصوب على المدح والبيان (Specific Apposition)',
        arConstruction: 'ضمير المتكلم أو المخاطب + الاسم المختص المنصوب بفعل محذوف تقديره (أَخُصُّ)',
        deConstruction: 'Hervorhebende Apposition: "wir, insbesondere als Handwerker..."',
        enConstruction: 'Emphatic appositive inclusion: "we, especially as artisans..."',
        exampleAr: 'نَحْنُ — مَعْشَرَ الحِرَفِيِّينَ — نَبْتَغِي الإِتْقَانَ فِي كُلِّ صَنْعَةٍ',
        exampleDe: 'Wir – insbesondere als Handwerker – streben nach Meisterschaft in jedem Werk.',
        exampleEn: 'We — especially as craftsmen — strive for excellence in every craft.',
      ),
      SpecificationInclusionRule(
        categoryTitle: 'التخصيص بأداة الحصر والتمييز (Particular Inclusion)',
        arConstruction: 'خَاصَّةً / لَا سِيَّمَا + الاسم المعرف (مرفوع أو مجرور أو منصوب بحسب السياق)',
        deConstruction: 'Adverbien der Besonderheit: "vor allem", "besonders"',
        enConstruction: 'Particularly / in particular / especially',
        exampleAr: 'نُحِبُّ الأَدَوَاتِ الطَّبِيعِيَّةَ، وَلَا سِيَّمَا المَنْحُوتَةَ مِنْ خَشَبِ الأَرْزِ',
        exampleDe: 'Wir schätzen Naturwerkzeuge, vor allem jene aus Zedernholz.',
        exampleEn: 'We appreciate natural utensils, especially those carved from cedar wood.',
      ),
    ];
  }
}
