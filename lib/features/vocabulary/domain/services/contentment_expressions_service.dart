class ContentmentExpression {
  final String theme;
  final String arabic;
  final String german;
  final String english;
  final String philosophicalValue;

  const ContentmentExpression({
    required this.theme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.philosophicalValue,
  });
}

class ContentmentExpressionsService {
  static List<ContentmentExpression> getCoreExpressions() {
    return const [
      ContentmentExpression(
        theme: 'القناعة والرضا (Contentment)',
        arabic: 'القَنَاعَةُ كَنْزٌ لَا يَفْنَى، وَعِزٌّ لَا يَبِيدُ',
        german: 'Genügsamkeit ist ein unvergänglicher Schatz und wahrer Seelenfrieden.',
        english: 'Contentment is an inexhaustible treasure and true dignity of the soul.',
        philosophicalValue: 'الرضا بما قسم الله يملأ القلب غنى وطمأنينة ويطرد الطمع.',
      ),
      ContentmentExpression(
        theme: 'سلامة الصدر ونقاء السريرة (Purity of Heart)',
        arabic: 'طِيبُ الخَاطِرِ وَسَلَامَةُ الصَّدْرِ لِلنَّاسِ',
        german: 'Herzensgüte und ein reines, versöhnliches Gemüt gegenüber allen Menschen.',
        english: 'Goodness of heart and a serene, benevolent disposition toward all people.',
        philosophicalValue: 'خلو النفس من الغل والحسد يمنح البدن صحة وعافية.',
      ),
    ];
  }
}
