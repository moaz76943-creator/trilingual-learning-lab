class EnvironmentalEtiquette {
  final String category;
  final String arabic;
  final String german;
  final String english;
  final String moralValue;

  const EnvironmentalEtiquette({
    required this.category,
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralValue,
  });
}

class EnvironmentalCleanlinessService {
  static List<EnvironmentalEtiquette> getEtiquettes() {
    return const [
      EnvironmentalEtiquette(
        category: 'إماطة الأذى عن الطريق (Clearing the Way)',
        arabic: 'إِمَاطَةُ الأَذَى عَنِ الطَّرِيقِ صَدَقَةٌ',
        german: 'Das Beseitigen von Hindernissen vom Weg ist eine Wohltat.',
        english: 'Removing harmful obstacles from the road is an act of charity.',
        moralValue: 'الحرص على سلامة الناس ونظافة البيئة العامة خلق إسلامي رفيع.',
      ),
      EnvironmentalEtiquette(
        category: 'صون المياه والظلال (Protecting Waters and Shades)',
        arabic: 'صَوْنُ مَصَادِرِ المِيَاهِ وَالظِّلَالِ مِنَ التَّلْوِيثِ',
        german: 'Reinhaltung von Wasserquellen und Schattenplätzen vor jeglicher Verschmutzung.',
        english: 'Safeguarding water sources and shaded rest places from any contamination.',
        moralValue: 'احترام حق المجتمع في التمتع بموارد طبيعية طاهرة وصحية.',
      ),
    ];
  }
}
