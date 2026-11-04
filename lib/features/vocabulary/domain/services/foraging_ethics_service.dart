class ForagingEthicItem {
  final String category;
  final String arabic;
  final String german;
  final String english;
  final String ecologicalRule;

  const ForagingEthicItem({
    required this.category,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ecologicalRule,
  });
}

class ForagingEthicsService {
  static List<ForagingEthicItem> getEthicPrinciples() {
    return const [
      ForagingEthicItem(
        category: 'القطاف الرفيق دون قلع الجذور (Sustainable Harvesting)',
        arabic: 'القِطَافُ الرَّفِيقُ مَعَ تَرْكِ أُصُولِ النَّبَاتِ لِتَتَجَدَّدَ',
        german: 'Schonendes Sammeln unter Bewahrung der Wurzeln zur natürlichen Verjüngung.',
        english: 'Gentle foraging while preserving roots for natural replenishment.',
        ecologicalRule: 'عدم اجتثاث النبات البري ليواصل نموه ويحمي المنحدر من انجراف التربة.',
      ),
      ForagingEthicItem(
        category: 'صون حصة الكائنات والنحل (Sharing with Pollinators)',
        arabic: 'إِبْقَاءُ شَطْرٍ مِنَ الأَزْهَارِ مَرْعًى لِلنَّحْلِ وَالطَّيْرِ',
        german: 'Einen Teil der Blüten den Bienen und Vögeln als lebenswichtige Nahrung überlassen.',
        english: 'Leaving a portion of blossoms for bees and birds as vital sustenance.',
        ecologicalRule: 'مراعاة التوازن البيئي وشكر نعم الأرض باحترام دور الكائنات الحية.',
      ),
    ];
  }
}
