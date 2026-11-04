class DependencyRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const DependencyRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ProportionalDependencyComparator {
  static List<DependencyRuleGuide> getRules() {
    return const [
      DependencyRuleGuide(
        categoryTitle: 'التلازم المشروط بحسب الحال (Contingent Dependency: بحسب ما / je nachdem)',
        arConstruction: 'بِحَسَبِ مَا / عَلَى قَدْرِ مَا + فِعْلٌ أَوْ اسْمٌ',
        deConstruction: 'je nachdem, ob / wie ... (Nebensatz mit abhängiger Wortstellung)',
        enConstruction: 'depending on whether / according to how ...',
        exampleAr: 'تَزْدَادُ جَوْدَةُ الصَّابُونِ بِحَسَبِ مَا تَكُونُ نَقَاوَةُ الزَّيْتِ',
        exampleDe: 'Die Seifenqualität steigt, je nachdem wie rein das Öl ist.',
        exampleEn: 'Soap quality increases depending on how pure the oil is.',
      ),
      DependencyRuleGuide(
        categoryTitle: 'التوافق الطردي في المقدار (Magnitude Proportion)',
        arConstruction: 'عَلَى قَدْرِ + اسْمٍ مَجْرُورٍ ... يَكُونُ + جَوَابٌ',
        deConstruction: 'im Verhältnis dazu, wie ... / entsprechend dem Maße',
        enConstruction: 'in proportion to + noun / according as ...',
        exampleAr: 'عَلَى قَدْرِ صَبْرِ الصَّانِعِ يَكُونُ إِتْقَانُ صَنْعَتِهِ',
        exampleDe: 'Entsprechend der Geduld des Meisters gelingt sein Werk vollendet.',
        exampleEn: 'In proportion to the artisan\'s patience, his craftsmanship excels.',
      ),
    ];
  }
}
