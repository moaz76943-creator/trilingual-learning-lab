class ExclamatoryRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ExclamatoryRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ExclamatoryWonderComparator {
  static List<ExclamatoryRuleGuide> getRules() {
    return const [
      ExclamatoryRuleGuide(
        categoryTitle: 'صيغة التعجب القياسية الأولى (مَا أَفْعَلَهُ)',
        arConstruction: 'مَا التَّعَجُّبِيَّةُ النَّكِرَةُ التَّامَّةُ + فِعْلُ التَّعَجُّبِ المَاضِي + المُتَعَجَّبُ مِنْهُ المَنْصُوبُ',
        deConstruction: 'Ausrufesatz mit "Wie + Adjektiv / Adverb + Subjekt + Verb"',
        enConstruction: 'Exclamatory clause: "How + adjective + subject + verb!"',
        exampleAr: 'مَا أَطْيَبَ رَائِحَةَ خَشَبِ الأَرْزِ المَنْحُوتِ!',
        exampleDe: 'Wie herrlich das geschnitzte Zedernholz duftet!',
        exampleEn: 'How delightfully the carved cedar wood smells!',
      ),
      ExclamatoryRuleGuide(
        categoryTitle: 'التعجب الاستحساني التعظيمي (What a ... / Welch ein...)',
        arConstruction: 'صِيَغُ التَّعَجُّبِ السَّمَاعِيِّ مِثْلَ: (لِلَّهِ دَرُّ الصَّانِعِ! / يَا لَهُ مِنْ عَمَلٍ بَدِيعٍ!)',
        deConstruction: 'Ausrufesatz mit "Welch ein / Was für ein + Nomen!"',
        enConstruction: 'Exclamatory structure: "What a + adjective + noun!"',
        exampleAr: 'يَا لَهُ مِنْ صُنْدُوقٍ أَنِيقٍ يَحْفَظُ كُنُوزَ العِلْمِ!',
        exampleDe: 'Was für eine edle Schatulle, die Schätze des Wissens bewahrt!',
        exampleEn: 'What an elegant chest that preserves the treasures of knowledge!',
      ),
    ];
  }
}
