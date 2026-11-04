class PlantConservationValue {
  final String domain;
  final String arabic;
  final String german;
  final String english;
  final String environmentalGoal;

  const PlantConservationValue({
    required this.domain,
    required this.arabic,
    required this.german,
    required this.english,
    required this.environmentalGoal,
  });
}

class PlantConservationEthicsService {
  static List<PlantConservationValue> getConservationValues() {
    return const [
      PlantConservationValue(
        domain: 'صون النباتات النادرة (Protecting Rare Flora)',
        arabic: 'صَوْنُ الأُصُولِ النَّبَاتِيَّةِ البَرِّيَّةِ مِنَ الرَّعْيِ الجَائِرِ',
        german: 'Schutz der wilden Pflanzenbestände vor übermäßiger Beweidung.',
        english: 'Protecting wild botanical populations from overgrazing and depletion.',
        environmentalGoal: 'ضمان استمرار السلالات البرية الأصيلة في بيئاتها الجبلية الطبيعية.',
      ),
      PlantConservationValue(
        domain: 'نشر الغراس النافعة (Propagating Beneficial Flora)',
        arabic: 'إِكْثَارُ شَتَلَاتِ الأَعْشَابِ العِطْرِيَّةِ وَإِعَادَةُ زَرْعِهَا',
        german: 'Vermehrung und Wiederansiedlung nützlicher Duftpflanzen.',
        english: 'Propagating and re-planting beneficial aromatic plants.',
        environmentalGoal: 'إغناء البيئة المحلية بالنباتات الرحيقية التي تجذب النحل وتثبت التربة.',
      ),
    ];
  }
}
