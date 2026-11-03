class EmphaticRuleGuide {
  final String categoryTitle;
  final String arPattern;
  final String dePattern;
  final String enPattern;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const EmphaticRuleGuide({
    required this.categoryTitle,
    required this.arPattern,
    required this.dePattern,
    required this.enPattern,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class EmphaticStructuresComparator {
  static List<EmphaticRuleGuide> getRules() {
    return const [
      EmphaticRuleGuide(
        categoryTitle: 'التوكيد المعنوي للفاعل (Agent Intensive Emphasis)',
        arPattern: 'ألفاظ التوكيد المعنوي (نَفْسُهُ، عَيْنُهُ) تتبع المؤكد في الإعراب مع ضمير رابط',
        dePattern: 'Unveränderliche Fokuspartikel "selbst" direkt nach dem Substantiv/Pronomen',
        enPattern: 'Intensive pronoun (himself, herself, itself) directly following the noun',
        exampleAr: 'قَطَفَ البَسْتَانِيُّ نَفْسُهُ ثِمَارَ البُرْتُقَالِ',
        exampleDe: 'Der Gärtner selbst pflückte die Orangen.',
        exampleEn: 'The gardener himself picked the oranges.',
      ),
      EmphaticRuleGuide(
        categoryTitle: 'توكيد الشمول والإحاطة (Total Inclusivity Emphasis)',
        arPattern: 'ألفاظ الإحاطة (كُلُّهُمْ، جَمِيعُهُمْ، عَامَّتُهُمْ) تتبع المؤكد وتؤكد عدم الاستثناء',
        dePattern: 'Indefinitpronomen "alle" / "allesamt" zur Bekräftigung der Vollständigkeit',
        enPattern: 'All of them / each and every one used emphatically',
        exampleAr: 'نَضِجَتِ الثِّمَارُ كُلُّهَا عَلَى الأَغْصَانِ',
        exampleDe: 'Die Früchte reiften allesamt an den Zweigen.',
        exampleEn: 'The fruits all ripened on the boughs.',
      ),
    ];
  }
}
