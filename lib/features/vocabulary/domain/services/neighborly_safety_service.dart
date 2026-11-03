class PathSafetyTerm {
  final String safetyTheme;
  final String arabic;
  final String german;
  final String english;
  final String communityBenefit;

  const PathSafetyTerm({
    required this.safetyTheme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.communityBenefit,
  });
}

class NeighborlySafetyService {
  static List<PathSafetyTerm> getSafetyTerms() {
    return const [
      PathSafetyTerm(
        safetyTheme: 'تسوية الممرات وتيسير السير (Smoothing Pathways)',
        arabic: 'تَسْوِيَةُ المَمَرَّاتِ لِتَيْسِيرِ حَرَكَةِ السَّابِلَةِ',
        german: 'Das Ebnen der Wege zur Erleichterung für alle Fußgänger.',
        english: 'Leveling pathways to facilitate movement for all pedestrians.',
        communityBenefit: 'منع تعثر المشاة وحماية الصغار وكبار السن من الانزلاق.',
      ),
      PathSafetyTerm(
        safetyTheme: 'التصريف المائي الطبيعي (Natural Drainage)',
        arabic: 'حُسْنُ تَصْرِيفِ مِيَاهِ الأَمْطَارِ دُونَ الإِضْرَارِ بِالدُّورِ',
        german: 'Geregelte Versickerung und Ableitung des Regenwassers zum Schutz der Häuser.',
        english: 'Proper natural drainage of rainwater without harming nearby homes.',
        communityBenefit: 'صون البيوت من تجمع المياه وتغذية التربة الزراعية المجاورة.',
      ),
    ];
  }
}
