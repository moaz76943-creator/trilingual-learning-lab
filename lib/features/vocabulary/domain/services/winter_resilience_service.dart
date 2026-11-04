class WinterCarePrinciple {
  final String virtueTheme;
  final String arabic;
  final String german;
  final String english;
  final String communityValue;

  const WinterCarePrinciple({
    required this.virtueTheme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.communityValue,
  });
}

class WinterResilienceService {
  static List<WinterCarePrinciple> getPrinciples() {
    return const [
      WinterCarePrinciple(
        virtueTheme: 'تفقد الجيران في مواسم البرد (Winter Neighborly Care)',
        arabic: 'تَفَقُّدُ بُيُوتِ الفُقَرَاءِ وَالجِيرَانِ فِي شِدَّةِ الشِّتَاءِ',
        german: 'Aufmerksame Fürsorge für Nachbarn und Bedürftige in der Kälte des Winters.',
        english: 'Mindful care for neighbors and the vulnerable during harsh winter cold.',
        communityValue: 'بذل الأغطية والبسط الصوفية للمحتاجين يقي النفوس من البرد وينشر التراحم.',
      ),
      WinterCarePrinciple(
        virtueTheme: 'العزل الحراري الطبيعي دون إسراف (Eco-Insulation)',
        arabic: 'العَزْلُ الصُّوفِيُّ الطَّبِيعِيُّ لِحِفْظِ طَاقَةِ البَيْتِ',
        german: 'Natürliche Wollfilzdämmung zur Bewahrung der wohligen Raumwärme.',
        english: 'Natural wool felt insulation to conserve home warmth and energy.',
        communityValue: 'تقليل استهلاك الوقود بالحفاظ على الدفء داخل الحجرات بوسائل بيئية نظيفة.',
      ),
    ];
  }
}
