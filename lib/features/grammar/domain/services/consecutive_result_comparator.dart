class ConsecutiveRuleGuide {
  final String relationName;
  final String arFormula;
  final String deFormula;
  final String enFormula;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ConsecutiveRuleGuide({
    required this.relationName,
    required this.arFormula,
    required this.deFormula,
    required this.enFormula,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ConsecutiveResultComparator {
  static List<ConsecutiveRuleGuide> getRules() {
    return const [
      ConsecutiveRuleGuide(
        relationName: 'الجملة التابعة الدالة على النتيجة (Subordinate Consequence)',
        arFormula: 'حَتَّى + فِعْلٌ مُضَارِعٌ مَنْصُوبٌ / فَـ (السَّبَبِيَّةُ) + جَوَابُ النَّتِيجَةِ',
        deFormula: 'sodass / so ..., dass (Nebensatz: Verb zwingend am Satzende)',
        enFormula: 'so that / so ... that + clause',
        exampleAr: 'قَلَّمَ الفَلَّاحُ الشَّجَرَ حَتَّى أَثْمَرَ خَيْرًا عَمِيمًا',
        exampleDe: 'Der Bauer schnitt die Bäume, sodass sie reichen Ertrag brachten.',
        exampleEn: 'The farmer pruned the trees so that they bore abundant fruit.',
      ),
      ConsecutiveRuleGuide(
        relationName: 'الظرف الرابط للنتيجة في جملة رئيسية (Adverbial Consequence)',
        arFormula: 'وَنَتِيجَةً لِذَلِكَ / وَمِنْ ثَمَّ / لِذَلِكَ (ظرف استنتاج)',
        deFormula: 'infolgedessen / folglich / daher (Adverb: Inversion auf Position 1)',
        enFormula: 'consequently / as a result / therefore',
        exampleAr: 'أَحْسَنَ الصَّانِعُ عَمَلَهُ، وَلِذَلِكَ نَالَ ثِقَةَ النَّاسِ',
        exampleDe: 'Der Handwerker arbeitete gewissenhaft; daher gewann er das Vertrauen.',
        exampleEn: 'The artisan worked conscientiously; therefore, he earned people\'s trust.',
      ),
    ];
  }
}
