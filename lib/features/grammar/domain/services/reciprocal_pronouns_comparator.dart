class ReciprocalRuleGuide {
  final String categoryTitle;
  final String arPattern;
  final String dePattern;
  final String enPattern;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ReciprocalRuleGuide({
    required this.categoryTitle,
    required this.arPattern,
    required this.dePattern,
    required this.enPattern,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ReciprocalPronounsComparator {
  static List<ReciprocalRuleGuide> getRules() {
    return const [
      ReciprocalRuleGuide(
        categoryTitle: 'التبادل المتصل بحروف الجر (Prepositional Reciprocity)',
        arPattern: 'حرف الجر مع تكرار لفظ التبعيض (بَعْضُهُمْ مَعَ بَعْضٍ / لِبَعْضِهِمْ بَعْضًا)',
        dePattern: 'Präposition + einander verschmolzen (miteinander, füreinander, voneinander)',
        enPattern: 'Preposition + each other / one another (with each other, for one another)',
        exampleAr: 'تَعَاوَنَ أَهْلُ الحَيِّ مَعَ بَعْضِهِمْ بَعْضًا فِي البِنَاءِ',
        exampleDe: 'Die Nachbarn bauten den Weg miteinander auf.',
        exampleEn: 'The neighbors built the pathway with each other.',
      ),
      ReciprocalRuleGuide(
        categoryTitle: 'التعبير عن التماسك والعمل المشترك (Unified Action)',
        arPattern: 'الحال الدالة على التآزر (يَدًا بِيَدٍ / كَتِفًا بِكَتِفٍ / صَفًّا وَاحِدًا)',
        dePattern: 'Hand in Hand / Seite an Seite (feste adverbiale Redewendungen)',
        enPattern: 'Hand in hand / shoulder to shoulder',
        exampleAr: 'يَعْمَلُ الشَّبَابُ يَدًا بِيَدٍ لِرَصْفِ المَمَرِّ',
        exampleDe: 'Die Jugend arbeitet Hand in Hand, um den Weg zu pflastern.',
        exampleEn: 'The youth work hand in hand to pave the walkway.',
      ),
    ];
  }
}
