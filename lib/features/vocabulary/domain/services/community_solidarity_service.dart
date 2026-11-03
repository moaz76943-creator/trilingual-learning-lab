class SolidarityExpression {
  final String context;
  final String arabic;
  final String german;
  final String english;
  final String moralValue;

  const SolidarityExpression({
    required this.context,
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralValue,
  });
}

class CommunitySolidarityService {
  static List<SolidarityExpression> getCoreExpressions() {
    return const [
      SolidarityExpression(
        context: 'التعاون في مواسم الحصاد والبناء (Communal Aid)',
        arabic: 'العَوْنَةُ المُبَارَكَةُ وَتَظَافُرُ السَّوَاعِدِ',
        german: 'die segensreiche gemeinschaftliche Nachbarschaftshilfe',
        english: 'blessed community mutual aid and united efforts',
        moralValue: 'التعاضد بين أفراد الحي لإنجاز الأعمال الشاقة في روح المحبة.',
      ),
      SolidarityExpression(
        context: 'وحدة الصف ودعم المحتاج (Mutual Support)',
        arabic: 'يَدُ اللهِ مَعَ الجَمَاعَةِ، وَالتَّعَاوُنُ أَسَاسُ البَرَكَةِ',
        german: 'Eintracht bringt Segen, und Einigkeit macht stark.',
        english: 'Harmony brings blessing, and mutual cooperation builds enduring strength.',
        moralValue: 'الاجتماع على البر والتقوى يحفظ الأوطان وينمي الخير.',
      ),
    ];
  }
}
