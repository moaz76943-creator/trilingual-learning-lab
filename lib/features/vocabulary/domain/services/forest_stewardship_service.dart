class ForestStewardshipTerm {
  final String principleName;
  final String arabic;
  final String german;
  final String english;
  final String environmentalWisdom;

  const ForestStewardshipTerm({
    required this.principleName,
    required this.arabic,
    required this.german,
    required this.english,
    required this.environmentalWisdom,
  });
}

class ForestStewardshipService {
  static List<ForestStewardshipTerm> getTerms() {
    return const [
      ForestStewardshipTerm(
        principleName: 'التحطيب من الأغصان اليابسة فقط (Pruning Deadwood Only)',
        arabic: 'الاقْتِصَارُ عَلَى الحَطَبِ اليَابِسِ دُونَ قَطْعِ الأَشْجَارِ الحَيَّةِ',
        german: 'Ausschließliche Nutzung von Totholz ohne Fällung lebender Bäume.',
        english: 'Gathering fallen deadwood only, without felling living trees.',
        environmentalWisdom: 'صون الغطاء الشجري للأجيال القادمة وحماية مواطن الطيور والكائنات.',
      ),
      ForestStewardshipTerm(
        principleName: 'إخماد النيران بحذر تام (Safe Extinguishment)',
        arabic: 'طَمْرُ الجَمْرِ بِالتُّرَابِ وَالمَاءِ خَوْفَ انْتِشَارِ الحَرَائِقِ',
        german: 'Sorgsames Ersticken der Glut mit Erde und Wasser zum Waldbrandschutz.',
        english: 'Careful smothering of embers with earth and water to prevent wildfires.',
        environmentalWisdom: 'الحذر والمسؤولية صمام أمان لسلامة المجتمع والبيئة الطبيعية.',
      ),
    ];
  }
}
