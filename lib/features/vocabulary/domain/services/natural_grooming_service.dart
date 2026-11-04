class GroomingValueTerm {
  final String virtueName;
  final String arabic;
  final String german;
  final String english;
  final String holisticBenefit;

  const GroomingValueTerm({
    required this.virtueName,
    required this.arabic,
    required this.german,
    required this.english,
    required this.holisticBenefit,
  });
}

class NaturalGroomingService {
  static List<GroomingValueTerm> getTerms() {
    return const [
      GroomingValueTerm(
        virtueName: 'طهارة العين ونقاء النظر (Clarity and Purity of Sight)',
        arabic: 'صَوْنُ البَصَرِ بِالمَوَادِّ المَعْدِنِيَّةِ الطَّبِيعِيَّةِ الخَالِصَةِ',
        german: 'Pflege der Sehkraft mit reinen traditionellen Naturmineralien.',
        english: 'Caring for eyesight with pure traditional natural minerals.',
        holisticBenefit: 'استعمال الحجر الطبيعي النقي يحد البصر ويصونه من الغبار دون شوائب ضارة.',
      ),
      GroomingValueTerm(
        virtueName: 'جمال السمت وحسن الهيئة (Dignified Natural Appearance)',
        arabic: 'حُسْنُ الهَيْئَةِ وَالنَّظَافَةُ الشَّخْصِيَّةُ مِنْ غَيْرِ تَكَلُّفٍ',
        german: 'Gepflegtes Auftreten und persönliche Reinheit ohne eitle Künstlichkeit.',
        english: 'Dignified appearance and personal cleanliness without artificial pretense.',
        holisticBenefit: 'العناية بالهيئة مظهر من مظاهر شكر نعمة الجمال والاعتدال الفطري.',
      ),
    ];
  }
}
