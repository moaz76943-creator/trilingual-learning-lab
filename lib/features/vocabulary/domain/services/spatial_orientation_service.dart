class SpatialExpression {
  final String domain;
  final String arabic;
  final String german;
  final String english;
  final String contextExample;

  const SpatialExpression({
    required this.domain,
    required this.arabic,
    required this.german,
    required this.english,
    required this.contextExample,
  });
}

class SpatialOrientationService {
  static List<SpatialExpression> getCoreSpatialOrientations() {
    return const [
      SpatialExpression(
        domain: 'الاتجاه النسبي (Relative Direction)',
        arabic: 'يَمْنَةً وَيَسْرَةً / ذَاتَ اليَمِينِ وَذَاتَ الشِّمَالِ',
        german: 'zur rechten und zur linken Hand',
        english: 'to the right and to the left',
        contextExample: 'انْتَشَرَتِ القَنَادِيلُ يَمْنَةً وَيَسْرَةً',
      ),
      SpatialExpression(
        domain: 'المحاذاة والتقابل (Alignment)',
        arabic: 'قُبَالَةَ المَعْلَمِ / حِذَاءَ المَدْخَلِ',
        german: 'gegenüber dem Eingang / unweit des Tors',
        english: 'opposite the entrance / facing the gateway',
        contextExample: 'يَقَعُ مَشْغَلُ الزُّجَاجِ قُبَالَةَ البَابِ الكَبِيرِ',
      ),
    ];
  }
}
