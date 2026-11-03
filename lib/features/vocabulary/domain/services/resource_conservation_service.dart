class ConservationTerm {
  final String theme;
  final String arabic;
  final String german;
  final String english;
  final String moralValue;

  const ConservationTerm({
    required this.theme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralValue,
  });
}

class ResourceConservationService {
  static List<ConservationTerm> getCoreTerms() {
    return const [
      ConservationTerm(
        theme: 'شكر النعم بحسن الرعاية (Cherishing Blessings)',
        arabic: 'شُكْرُ النِّعَمِ بِحِفْظِهَا وَصِيَانَتِهَا عَنِ الهَدْرِ',
        german: 'Dankbarkeit für die Gaben durch schonende und achtsame Nutzung.',
        english: 'Gratitude for blessings through mindful and waste-free stewardship.',
        moralValue: 'تقدير ما أنعم الله به علينا واستعماله بحكمة واعتدال.',
      ),
      ConservationTerm(
        theme: 'الاستدامة وتجنب التبذير (Anti-Waste and Sustainability)',
        arabic: 'البَرَكَةُ فِي القَصْدِ، وَالإِسْرَافُ مَمْحَقَةٌ لِلْخَيْرِ',
        german: 'Segen liegt im maßvollen Handeln; Verschwendung zehrt das Gute auf.',
        english: 'Blessing lies in moderation; wastefulness diminishes goodness.',
        moralValue: 'ترشيد الاستهلاك وحفظ الموارد للأجيال القادمة خصلة إيمانية وإنسانية.',
      ),
    ];
  }
}
