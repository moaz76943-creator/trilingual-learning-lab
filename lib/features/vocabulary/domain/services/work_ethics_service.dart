class WorkEthicsTerm {
  final String conceptTheme;
  final String arabic;
  final String german;
  final String english;
  final String practicalApplication;

  const WorkEthicsTerm({
    required this.conceptTheme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.practicalApplication,
  });
}

class WorkEthicsService {
  static List<WorkEthicsTerm> getWorkEthics() {
    return const [
      WorkEthicsTerm(
        conceptTheme: 'الإتقان والإحسان (Mastery and Excellence)',
        arabic: 'إِتْقَانُ الصَّنْعَةِ وَإِحْكَامُ البِنَاءِ',
        german: 'meisterhafte Gewissenhaftigkeit und solide Verarbeitung',
        english: 'masterful excellence and sturdy execution',
        practicalApplication: 'أن يحب العامل إذا عمل عملاً أن يتقنه ويؤديه على أكمل وجه.',
      ),
      WorkEthicsTerm(
        conceptTheme: 'صدق المعاملة والنصح (Honesty and Integrity)',
        arabic: 'أَدَاءُ الأَمَانَةِ وَالنُّصْحُ فِي التَّعَامُلِ',
        german: 'treue Pflichterfüllung und aufrichtige Zuverlässigkeit',
        english: 'fulfillment of trust and sincere reliability',
        practicalApplication: 'بيان صفات السلعة بصدق دون غش أو مواربة.',
      ),
    ];
  }
}
