class MoralWisdomExpression {
  final String theme;
  final String arabic;
  final String german;
  final String english;
  final String ethicalGuidance;

  const MoralWisdomExpression({
    required this.theme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ethicalGuidance,
  });
}

class HumilityWisdomService {
  static List<MoralWisdomExpression> getWisdomExpressions() {
    return const [
      MoralWisdomExpression(
        theme: 'التواضع عند التمكن (Intellectual Humility)',
        arabic: 'التَّوَاضُعُ زِينَةُ العَالِمِ وَتَاجُ الصَّانِعِ',
        german: 'Demut ist die Zierde des Weisen und die Krone des Handwerkers.',
        english: 'Humility is the ornament of the scholar and the crown of the artisan.',
        ethicalGuidance: 'كلما ارتقى الإنسان في المهارة ازداد لطفاً وتواضعاً للناس.',
      ),
      MoralWisdomExpression(
        theme: 'نسب الفضل لأهله (Giving Credit)',
        arabic: 'مَنْ لَا يَشْكُرِ النَّاسَ لَا يَشْكُرِ اللهَ',
        german: 'Wer den Menschen nicht dankt, dankt auch Gott nicht.',
        english: 'He who does not thank people does not thank God.',
        ethicalGuidance: 'الاعتراف بفضل المعلمين والشركاء خلق كريم أصيل.',
      ),
    ];
  }
}
