class InstrumentalRuleGuide {
  final String categoryTitle;
  final String arRule;
  final String deRule;
  final String enRule;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const InstrumentalRuleGuide({
    required this.categoryTitle,
    required this.arRule,
    required this.deRule,
    required this.enRule,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class InstrumentalPrepositionsComparator {
  static List<InstrumentalRuleGuide> getRules() {
    return const [
      InstrumentalRuleGuide(
        categoryTitle: 'الاستعانة بالآلة المباشرة (Direct Instrument: باء الآلة / mit)',
        arRule: 'بَاءُ الاسْتِعَانَةِ تَدْخُلُ عَلَى اسْمِ الآلَةِ لِبَيَانِ وَسِيلَةِ الفِعْلِ',
        deRule: 'mit (+ Dativ) zeigt das Werkzeug oder Hilfsmittel an',
        enRule: 'with + noun indicates the physical tool used',
        exampleAr: 'قَاسَ الفَلَكِيُّ الزَّاوِيَةَ بِالمِسْطَرَةِ النُّحَاسِيَّةِ',
        exampleDe: 'Der Astronom maß den Winkel mit dem bronzenen Lineal.',
        exampleEn: 'The astronomer measured the angle with the bronze ruler.',
      ),
      InstrumentalRuleGuide(
        categoryTitle: 'الواسطة المجردة والمنهج (Abstract Means: عَنْ طَرِيقِ / mittels)',
        arRule: 'بِوَاسِطَةِ / عَنْ طَرِيقِ / مِنْ خِلَالِ (إضافة للظرفية)',
        deRule: 'mittels / anhand (+ Genitiv) für formellere Methodenangaben',
        enRule: 'by means of / through + noun',
        exampleAr: 'حَدَّدَ الوَقْتَ عَنْ طَرِيقِ حَرَكَةِ الظِّلِّ',
        exampleDe: 'Er bestimmte die Zeit mittels der Schattenbewegung.',
        exampleEn: 'He determined the time by means of the shadow movement.',
      ),
    ];
  }
}
