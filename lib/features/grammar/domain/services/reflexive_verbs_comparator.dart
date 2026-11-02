class ReflexivePatternGuide {
  final String categoryTitle;
  final String arPattern;
  final String dePattern;
  final String enPattern;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ReflexivePatternGuide({
    required this.categoryTitle,
    required this.arPattern,
    required this.dePattern,
    required this.enPattern,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ReflexiveVerbsComparator {
  static List<ReflexivePatternGuide> getReflexiveGuides() {
    return const [
      ReflexivePatternGuide(
        categoryTitle: 'الأفعال الانعكاسية الذاتية (Direct Reflexive)',
        arPattern: 'أوزان المطاوعة (انْفَعَلَ / افْتَعَلَ / تَفَعَّلَ)',
        dePattern: 'Echte reflexive Verben mit "sich" im Akkusativ',
        enPattern: 'Reflexive pronouns (myself, yourself, himself)',
        exampleAr: 'اغْتَسَلَ الرَّجُلُ بِمَاءٍ طَهُورٍ',
        exampleDe: 'Der Mann wäscht sich mit reinem Wasser.',
        exampleEn: 'The man washes himself with pure water.',
      ),
      ReflexivePatternGuide(
        categoryTitle: 'أفعال المشاركة والتعاون المتبادل (Reciprocal Verbs)',
        arPattern: 'وزن التَّفَاعُلِ لِلْمُشَارَكَةِ (تَفَاعَلَ مِثْلَ: تَعَاوَنَ، تَشَاوَرَ)',
        dePattern: 'Reziproke Verben: sich (einander) gegenseitig unterstützen',
        enPattern: 'Reciprocal pronouns: each other / one another',
        exampleAr: 'تَعَاوَنَ أَهْلُ الحَيِّ فِي الخَيْرِ',
        exampleDe: 'Die Nachbarn halfen sich gegenseitig im Guten.',
        exampleEn: 'The neighbors helped each other in good deeds.',
      ),
    ];
  }
}
