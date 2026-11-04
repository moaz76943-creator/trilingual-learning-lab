class NutrimentEthicPrinciple {
  final String ethicalTheme;
  final String arabic;
  final String german;
  final String english;
  final String consumerBenefit;

  const NutrimentEthicPrinciple({
    required this.ethicalTheme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.consumerBenefit,
  });
}

class PureNutrimentEthicsService {
  static List<NutrimentEthicPrinciple> getPrinciples() {
    return const [
      NutrimentEthicPrinciple(
        ethicalTheme: 'خلو الغذاء من الغش والخلط (Purity without Adulteration)',
        arabic: 'النَّقَاءُ الخَالِصُ دُونَ خَلْطٍ أَوْ تَمْوِيهٍ فِي الزُّيُوتِ',
        german: 'Reine Unverfälschtheit ohne Beimischung minderwertiger Öle.',
        english: 'Absolute purity without blending or disguising with inferior oils.',
        consumerBenefit: 'حماية صحة المستهلك وضمان الحصول على القيمة الغذائية الصافية.',
      ),
      NutrimentEthicPrinciple(
        ethicalTheme: 'البركة في الصدق والبيان (Blessing in Truthful Disclosure)',
        arabic: 'البَيَانُ الصَّادِقُ لِمَصْدَرِ الحُبُوبِ وَطَرِيقَةِ العَصْرِ',
        german: 'Wahrhaftige Auskunft über Saatenherkunft und traditionelle Pressung.',
        english: 'Truthful disclosure of seed origin and traditional milling methods.',
        consumerBenefit: 'ترسيخ مبدأ الثقة المتبادلة بين المنتج والمستهلك لوجه الله.',
      ),
    ];
  }
}
