class NaturalPurityTerm {
  final String domain;
  final String arabic;
  final String german;
  final String english;
  final String ethicalReflection;

  const NaturalPurityTerm({
    required this.domain,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ethicalReflection,
  });
}

class NaturalPurityService {
  static List<NaturalPurityTerm> getPurityTerms() {
    return const [
      NaturalPurityTerm(
        domain: 'الطهارة والنقاء الطبيعي (Natural Cleanliness)',
        arabic: 'الطَّهَارَةُ النَّقِيَّةُ بِالمَوَادِّ الطَّبِيعِيَّةِ الصَّافِيَةِ',
        german: 'Reine und wohltuende Sauberkeit durch natürliche Essenzen.',
        english: 'Pure, wholesome cleanliness achieved through natural elements.',
        ethicalReflection: 'النظافة عنوان الإيمان ومظهر الوقار والسكينة في حياة الإنسان.',
      ),
      NaturalPurityTerm(
        domain: 'الرائحة الطيبة والاعتدال (Wholesome Scent)',
        arabic: 'طِيبُ الرَّائِحَةِ وَحُسْنُ المَظْهَرِ دُونَ تَكَلُّفٍ',
        german: 'Wohltuender Wohlgeruch und gepflegtes Auftreten in natürlicher Bescheidenheit.',
        english: 'Pleasant aroma and dignified presentation in modest balance.',
        ethicalReflection: 'الرائحة الطيبة تشرح الصدر وتجلب راحة البال ومحبة الجليس.',
      ),
    ];
  }
}
