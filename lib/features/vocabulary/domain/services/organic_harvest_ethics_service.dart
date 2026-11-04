class OrganicHarvestEthicTerm {
  final String harvestStage;
  final String arabic;
  final String german;
  final String english;
  final String ethicalGuideline;

  const OrganicHarvestEthicTerm({
    required this.harvestStage,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ethicalGuideline,
  });
}

class OrganicHarvestEthicsService {
  static List<OrganicHarvestEthicTerm> getTerms() {
    return const [
      OrganicHarvestEthicTerm(
        harvestStage: 'العصر البارد دون حرارة (Gentle Cold Pressing)',
        arabic: 'العَصْرُ عَلَى البَارِدِ لِحِفْظِ خَيْرَاتِ الشَّجَرَةِ المُبَارَكَةِ',
        german: 'Schonende Kaltpressung zur Bewahrung aller wertvollen Inhaltsstoffe.',
        english: 'Gentle cold pressing to preserve all natural goodness of the olive.',
        ethicalGuideline: 'عدم اللجوء إلى درجات الحرارة العالية لزيادة الكمية على حساب الجودة والصحة.',
      ),
      OrganicHarvestEthicTerm(
        harvestStage: 'الحفظ في أواني الفخار المعتمة (Shielded Natural Storage)',
        arabic: 'حِفْظُ الزَّيْتِ فِي جِرَارِ الفَخَّارِ بَعِيدًا عَنِ الضَّوْءِ وَالحَرَارَةِ',
        german: 'Lagerung des Öls in traditionellen Tonkrügen vor Licht und Wärme geschützt.',
        english: 'Storing oil in traditional earthenware crocks away from light and heat.',
        ethicalGuideline: 'حماية نقاوة الغذاء من التأكسد دون مواد حافظة صناعية.',
      ),
    ];
  }
}
