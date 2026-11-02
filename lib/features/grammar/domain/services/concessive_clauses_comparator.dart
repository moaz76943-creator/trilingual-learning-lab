class ConcessiveRuleGuide {
  final String relationName;
  final String arFormula;
  final String deFormula;
  final String enFormula;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ConcessiveRuleGuide({
    required this.relationName,
    required this.arFormula,
    required this.deFormula,
    required this.enFormula,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ConcessiveClausesComparator {
  static List<ConcessiveRuleGuide> getConcessiveGuides() {
    return const [
      ConcessiveRuleGuide(
        relationName: 'الجملة التنازلية التابعة (Subordinate Concession)',
        arFormula: 'رَغْمَ أَنَّ / مَعَ أَنَّ + الجُمْلَةُ الاسْمِيَّةُ أَوْ الفِعْلِيَّةُ',
        deFormula: 'obwohl / obgleich (Subjunktion: Verb zwingend am Ende)',
        enFormula: 'although / even though + Subject + Verb',
        exampleAr: 'اجْتَهَدَ الصَّانِعُ رَغْمَ صُعُوبَةِ المَهَمَّةِ',
        exampleDe: 'Der Handwerker gab sein Bestes, obwohl die Aufgabe schwer war.',
        exampleEn: 'The artisan did his best, although the task was difficult.',
      ),
      ConcessiveRuleGuide(
        relationName: 'الظرف الاستدراكي في الجملة الرئيسية (Adverbial Concession)',
        arFormula: 'وَمَعَ ذَلِكَ / عَلَى أَنَّهُ',
        deFormula: 'trotzdem / dennoch (Konstruktion mit Inversion: Verb auf Position 2)',
        enFormula: 'nevertheless / nonetheless / even so',
        exampleAr: 'المَسِيرُ طَوِيلٌ، وَمَعَ ذَلِكَ نُوَاصِلُ بِعَزْمٍ',
        exampleDe: 'Der Weg ist weit; trotzdem gehen wir mit Zuversicht voran.',
        exampleEn: 'The journey is long; nevertheless, we proceed with resolve.',
      ),
    ];
  }
}
