class SupplicatoryRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const SupplicatoryRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class SupplicatoryGrammarComparator {
  static List<SupplicatoryRuleGuide> getRules() {
    return const [
      SupplicatoryRuleGuide(
        categoryTitle: 'صيغ الدعاء بالفعل الماضي لفظاً الدال على المستقبل معنى (Optative Past)',
        arConstruction: 'الفعل الماضي للدلالة على تحقق الدعاء وثبوته برحمة الله (بَارَكَ اللهُ / جَزَاكَ اللهُ)',
        deConstruction: 'Optativ mit "Möge + Subjekt" (Möge Gott dich segnen und belohnen)',
        enConstruction: 'Optative with "May + Subject + base form" (May God bless you)',
        exampleAr: 'بَارَكَ اللهُ فِي عَمَلِكَ الصَّالِحِ',
        exampleDe: 'Möge Gott dein gutes Werk segnen.',
        exampleEn: 'May God bless your righteous work.',
      ),
      SupplicatoryRuleGuide(
        categoryTitle: 'الدعاء بالاسم المشتق والصفة المباركة (Nominal Benediction)',
        arConstruction: 'جملة اسمية تفيد الثبوت والدوام في البركة (طَهُورٌ إِنْ شَاءَ اللهُ / سَلَامٌ عَلَيْكُمْ)',
        deConstruction: 'Segenswünsche im Substantiv: "Friede sei mit euch" / "Reicher Segen"',
        enConstruction: 'Nominal blessings: "Peace be upon you" / "Blessed abundance"',
        exampleAr: 'سَلَامٌ عَلَيْكُمْ بِمَا صَبَرْتُمْ',
        exampleDe: 'Friede sei mit euch für eure geduldige Ausdauer.',
        exampleEn: 'Peace be upon you for your patient endurance.',
      ),
    ];
  }
}
