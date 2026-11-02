class OrganicAgriConcept {
  final String domain;
  final String arabic;
  final String german;
  final String english;
  final String ecologicalRole;

  const OrganicAgriConcept({
    required this.domain,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ecologicalRole,
  });
}

class OrganicAgricultureService {
  static List<OrganicAgriConcept> getCoreConcepts() {
    return const [
      OrganicAgriConcept(
        domain: 'تغذية التربة (Soil Enrichment)',
        arabic: 'السَّمَادُ العُضْوِيُّ النَّافِعُ المُتَخَمِّرُ',
        german: 'der nahrhafte reife Kompost',
        english: 'nutritious mature organic compost',
        ecologicalRole: 'إعادة تدوير المخلفات النباتية لتغذية ديدان الأرض والميكروبات المفيدة.',
      ),
      OrganicAgriConcept(
        domain: 'البذور الأصيلة (Seed Sovereignty)',
        arabic: 'البَذْرَةُ المُتَأَصِّلَةُ النَّقِيَّةُ غَيْرُ المُعَدَّلَةِ',
        german: 'das samenfeste, unveränderte Biosaatgut',
        english: 'pure, non-modified heirloom seed',
        ecologicalRole: 'حفظ السلالات الزراعية الطبيعية القادرة على التكاثر الذاتي عاماً بعد عام.',
      ),
    ];
  }
}
