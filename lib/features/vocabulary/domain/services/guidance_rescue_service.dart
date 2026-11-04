class GuidanceVirtueTerm {
  final String virtueName;
  final String arabic;
  final String german;
  final String english;
  final String humanitarianPillar;

  const GuidanceVirtueTerm({
    required this.virtueName,
    required this.arabic,
    required this.german,
    required this.english,
    required this.humanitarianPillar,
  });
}

class GuidanceRescueService {
  static List<GuidanceVirtueTerm> getTerms() {
    return const [
      GuidanceVirtueTerm(
        virtueName: 'إغاثة الملهوف وإعانة المحتاج (Rescuing the Distressed)',
        arabic: 'إِغَاثَةُ المَلْهُوفِ وَنَصْرُ الضَّعِيفِ وَإِرْشَادُ الضَّالِّ فِي الطَّرِيقِ',
        german: 'Den Notleidenden beistehen und dem Suchenden auf dem Weg die Richtung weisen.',
        english: 'Relieving the distressed, aiding the weak, and guiding the lost wayfarer.',
        humanitarianPillar: 'حق إنساني وواجب إيماني متجذر في فطرة مكارم الأخلاق.',
      ),
      GuidanceVirtueTerm(
        virtueName: 'بذل النصح والهداية بالرفق (Gentle Sincere Guidance)',
        arabic: 'بَذْلُ النُّصْحِ وَالدَّلَالَةُ عَلَى الخَيْرِ بِلُطْفٍ وَحِكْمَةٍ',
        german: 'Aufrichtiger Rat und liebevolle Wegweisung mit Besonnenheit und Güte.',
        english: 'Offering sincere counsel and pointing towards good with gentleness and wisdom.',
        humanitarianPillar: 'الدال على الخير كفاعله، ونور الهداية يضيء دروب المجتمع.',
      ),
    ];
  }
}
