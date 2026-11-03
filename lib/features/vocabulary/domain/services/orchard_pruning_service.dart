class PruningWisdomTerm {
  final String actionPhase;
  final String arabic;
  final String german;
  final String english;
  final String agriculturalWisdom;

  const PruningWisdomTerm({
    required this.actionPhase,
    required this.arabic,
    required this.german,
    required this.english,
    required this.agriculturalWisdom,
  });
}

class OrchardPruningService {
  static List<PruningWisdomTerm> getPruningTerms() {
    return const [
      PruningWisdomTerm(
        actionPhase: 'تقليم الأغصان وتجديد النشاط (Rejuvenating Pruning)',
        arabic: 'تَقْلِيمُ الأَغْصَانِ لِتَجْدِيدِ ثِمَارِ الشَّجَرَةِ',
        german: 'das behutsame Auslichten der Zweige zur Verjüngung des Baumes',
        english: 'careful pruning of branches to rejuvenate the tree\'s fruitfulness',
        agriculturalWisdom: 'إزالة الفروع اليابسة يتيح لنور الشمس والهواء النقي الوصول إلى قلب الشجرة.',
      ),
      PruningWisdomTerm(
        actionPhase: 'صون الجذور وترطيب التربة (Root Stewardship)',
        arabic: 'تَهْوِيَةُ التُّرْبَةِ حَوْلَ الجُذُورِ دُونَ الإِضْرَارِ بِهَا',
        german: 'schonendes Lockern des Bodens um die Wurzeln ohne Beschädigung',
        english: 'gentle aerating of the soil around roots without damaging them',
        agriculturalWisdom: 'الجذور القوية هي سر الثمار الطيبة في مواسم الحصاد.',
      ),
    ];
  }
}
