class TimeEthicExpression {
  final String theme;
  final String arabic;
  final String german;
  final String english;
  final String moralValue;

  const TimeEthicExpression({
    required this.theme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralValue,
  });
}

class TimeValuationService {
  static List<TimeEthicExpression> getCoreExpressions() {
    return const [
      TimeEthicExpression(
        theme: 'قيمة الوقت وأمانة الساعات (Value of Time)',
        arabic: 'الوَقْتُ أَنْفَسُ مَا عُنِيتَ بِحِفْظِهِ',
        german: 'Die Zeit ist das kostbarste Gut, das man treu bewahren sollte.',
        english: 'Time is the most precious treasure one ought to safeguard.',
        moralValue: 'استثمار الساعات في العمل النافع ونشر الخير بين الناس.',
      ),
      TimeEthicExpression(
        theme: 'بركة البكور والاجتهاد الصباحي (Early Morning Productivity)',
        arabic: 'البَرَكَةُ فِي البُكُورِ وَصَفَاءِ الذِّهْنِ',
        german: 'Morgenstund hat Segen und Klarheit des Geistes im Gepäck.',
        english: 'Blessing lies in early morning hours and clarity of the mind.',
        moralValue: 'البدء مع أول النهار يمنح الطاقة والنشاط لإنجاز أعظم المهام.',
      ),
    ];
  }
}
