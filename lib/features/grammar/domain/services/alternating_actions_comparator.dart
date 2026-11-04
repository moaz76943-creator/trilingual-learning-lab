class AlternatingActionGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const AlternatingActionGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class AlternatingActionsComparator {
  static List<AlternatingActionGuide> getRules() {
    return const [
      AlternatingActionGuide(
        categoryTitle: 'التناوب الزمني في أداء المهام (Temporal Alternation)',
        arConstruction: 'تَارَةً ... وَتَارَةً أُخْرَى / حِينًا ... وَحِينًا (ألفاظ تفيد تعاقب الأفعال)',
        deConstruction: 'mal ... mal ... / bald ... bald ... (Adverbien des Wechsels)',
        enConstruction: 'at times ... at other times ... / now ... now ...',
        exampleAr: 'يَعْجِنُ الصَّانِعُ الطِّينَ تَارَةً، وَيَقْلِبُ اللَّبِنَ فِي الشَّمْسِ تَارَةً أُخْرَى',
        exampleDe: 'Der Handwerker knetet mal den Lehm, mal wendet er die Ziegel an der Sonne.',
        exampleEn: 'The artisan kneads the clay at times, and turns the bricks in the sun at other times.',
      ),
      AlternatingActionGuide(
        categoryTitle: 'التوزيع التكاملي بين المشاركين (Distributed Participation)',
        arConstruction: 'بَعْضُهُمْ ... وَبَعْضُهُمْ / قِسْمٌ ... وَقِسْمٌ آخَرُ',
        deConstruction: 'teils ... teils ... / die einen ..., die anderen ...',
        enConstruction: 'partly ... partly ... / some ..., others ...',
        exampleAr: 'البَنَّاؤُونَ بَعْضُهُمْ يَخْلِطُ التِّبْنَ، وَبَعْضُهُمْ يَمْلَأُ القَوَالِبَ',
        exampleDe: 'Die einen mischen das Stroh, die anderen füllen die Ziegelformen.',
        exampleEn: 'Some mix the straw, while others fill the brick moulds.',
      ),
    ];
  }
}
