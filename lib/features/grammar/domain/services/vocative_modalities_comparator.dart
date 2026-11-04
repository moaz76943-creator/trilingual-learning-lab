class VocativeRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const VocativeRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class VocativeModalitiesComparator {
  static List<VocativeRuleGuide> getRules() {
    return const [
      VocativeRuleGuide(
        categoryTitle: 'النداء التكريمي للمفرد المعرف (Honorable Direct Address)',
        arConstruction: 'يَا + أَيُّهَا + الاسم المعرف بأل (نعت مرفوع لفظاً للمنادى)',
        deConstruction: 'Höfliche direkte Anrede mit "Herr / Meister" oder "Lieber..."',
        enConstruction: 'Respectful direct address: "O respected / Dear craftsman"',
        exampleAr: 'يَا أَيُّهَا الصَّانِعُ المَاهِرُ، بَارَكَ اللهُ فِي عَمَلِكَ',
        exampleDe: 'O werter Meister, möge Gott Ihr Werk segnen.',
        exampleEn: 'O skilled artisan, may God bless your work.',
      ),
      VocativeRuleGuide(
        categoryTitle: 'المنادى المضاف لبيان القرابة والمحبة (Affectionate Genitive Vocative)',
        arConstruction: 'أداة النداء + منادى مضاف منصوب بالفتحة (يَا أَخِي / يَا جَارَنَا)',
        deConstruction: 'Anrede mit Possessivpronomen: "Mein lieber Bruder / Unser werter Nachbar"',
        enConstruction: 'Direct address with possessive: "My dear brother / Our good neighbor"',
        exampleAr: 'يَا أَخِي الكَرِيمَ، أَفْسِحْ لِأَخِيكَ فِي المَجْلِسِ',
        exampleDe: 'Mein lieber Bruder, mache deinem Nächsten Platz im Raum.',
        exampleEn: 'My noble brother, make room for your fellow in the gathering.',
      ),
    ];
  }
}
