class BotanicalMetaphorItem {
  final String growthStage;
  final String arabic;
  final String german;
  final String english;
  final String moralReflection;

  const BotanicalMetaphorItem({
    required this.growthStage,
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralReflection,
  });
}

class BotanicalGrowthService {
  static List<BotanicalMetaphorItem> getGrowthMetaphors() {
    return const [
      BotanicalMetaphorItem(
        growthStage: 'بذر النواة الصالحة (Planting the Seed)',
        arabic: 'بَذْرَةُ الخَيْرِ تَؤُولُ إِلَى شَجَرَةٍ طَيِّبَةٍ',
        german: 'Aus dem guten Samen wächst ein edler Baum hervor.',
        english: 'From a good seed grows a noble, fruitful tree.',
        moralReflection: 'البدايات النقية المخلصة تثمر نتائج مباركة.',
      ),
      BotanicalMetaphorItem(
        growthStage: 'ثبات الجذور في الأرض (Deep Rooting)',
        arabic: 'أَصْلُهَا ثَابِتٌ وَفَرْعُهَا فِي السَّمَاءِ',
        german: 'Ihre Wurzeln stehen fest, und ihre Zweige reichen empor.',
        english: 'Its root is firmly fixed and its branches reach to the sky.',
        moralReflection: 'الرسوخ في المبادئ والأخلاق هو سر الاستقامة.',
      ),
    ];
  }
}
