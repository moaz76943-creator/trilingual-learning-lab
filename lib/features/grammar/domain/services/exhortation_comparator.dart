class ExhortationRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ExhortationRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ExhortationComparator {
  static List<ExhortationRuleGuide> getRules() {
    return const [
      ExhortationRuleGuide(
        categoryTitle: 'أسلوب التحضيض والحث على الخير (Urgent Exhortation: هلّا / doch)',
        arConstruction: 'هَلَّا / أَلَا (أداة تحضيض وحث برفق) + الفعل المضارع المرفوع',
        deConstruction: 'Imperativ mit Abtönungspartikel "doch" / "mal" (Lass uns doch...)',
        enConstruction: 'Why not + base form / "Won\'t you..." as gentle encouragement',
        exampleAr: 'هَلَّا أَتْقَنْتَ تَرْتِيبَ الفُسَيْفِسَاءِ لِتَبْدُوَ بَدِيعَةً؟',
        exampleDe: 'Füge doch die Mosaiksteinchen mit Geduld zusammen!',
        exampleEn: 'Why not arrange the mosaic tesserae carefully so they shine?',
      ),
      ExhortationRuleGuide(
        categoryTitle: 'التنديم واللوم على التقصير في الماضي (Reproachful Past: لولا / hättest doch)',
        arConstruction: 'لَوْلَا / لَوْمَا + الفعل الماضي (تفيد لوم المفرط على ترك الأولى)',
        deConstruction: 'Konjunktiv II der Vergangenheit: "Du hättest doch ... sollen/können"',
        enConstruction: 'You should have / could have + past participle',
        exampleAr: 'لَوْلَا بَكَّرْتَ فِي العَمَلِ لَأَنْجَزْتَ قَبْلَ الغُرُوبِ',
        exampleDe: 'Hättest du doch früher begonnen, so wärst du vor Sonnenuntergang fertig gewesen.',
        exampleEn: 'Had you started earlier, you would have finished before sunset.',
      ),
    ];
  }
}
