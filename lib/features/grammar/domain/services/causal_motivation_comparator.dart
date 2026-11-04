class MotivationRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const MotivationRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class CausalMotivationComparator {
  static List<MotivationRuleGuide> getRules() {
    return const [
      MotivationRuleGuide(
        categoryTitle: 'المفعول لأجله الدال على النية الباطنة (Internal Motivation: رغبةً / aus)',
        arConstruction: 'مصدر قلبي نكرة منصوب يبين علة وقوع الفعل وسببه (طَلَبًا، ابْتِغَاءً، رَغْبَةً)',
        deConstruction: 'Kausale Präposition "aus (+ Dativ)" für innere Beweggründe (aus Liebe, aus Überzeugung)',
        enConstruction: 'Out of / for the sake of + noun (out of love, for the purpose of)',
        exampleAr: 'صَنَعَ الخَزَّافُ القِنِّينَةَ عَاتِمَةً حِفْظًا لِجَوْدَةِ الزَّيْتِ',
        exampleDe: 'Der Glaser fertigte die Flasche dunkel aus Sorge um die Ölqualität.',
        exampleEn: 'The glassmaker crafted the bottle dark out of care for oil quality.',
      ),
      MotivationRuleGuide(
        categoryTitle: 'الباعث الخارجي المانع (Involuntary Cause: خوفًا من / vor)',
        arConstruction: 'المفعول لأجله المقترن بمعنى التحرز والاحتياط (خَوْفًا مِنْ / حَذَرًا مِنْ)',
        deConstruction: 'Kausale Präposition "vor (+ Dativ)" für äußere Reize und Furcht (vor der Hitze)',
        enConstruction: 'For fear of / lest + clause',
        exampleAr: 'حَفِظْنَا الزَّيْتَ فِي الظِّلِّ خَوْفًا مِنَ التَّلَفِ',
        exampleDe: 'Wir lagerten das Öl im Schatten vor der Sonnenwärme geschützt.',
        exampleEn: 'We stored the oil in the shade for fear of heat damage.',
      ),
    ];
  }
}
