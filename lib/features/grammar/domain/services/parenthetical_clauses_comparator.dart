class ParentheticalRuleGuide {
  final String categoryTitle;
  final String arPattern;
  final String dePattern;
  final String enPattern;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ParentheticalRuleGuide({
    required this.categoryTitle,
    required this.arPattern,
    required this.dePattern,
    required this.enPattern,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ParentheticalClausesComparator {
  static List<ParentheticalRuleGuide> getRules() {
    return const [
      ParentheticalRuleGuide(
        categoryTitle: 'الجملة الدعائية الاعتراضية (Interjected Blessing)',
        arPattern: 'جملة فعلية أو اسمية تفيد الدعاء لا محل لها من الإعراب وتوضع بين شرطتين',
        dePattern: 'Eingeschobener Schaltsatz / Segenswunsch durch Gedankenstriche getrennt',
        enPattern: 'Parenthetical blessing set off by em-dashes or commas',
        exampleAr: 'الصَّانِعُ الخَبِيرُ — بَارَكَ اللهُ فِي عَمَلِهِ — أَتْقَنَ بِنَاءَ المَخَاضَةِ',
        exampleDe: 'Der erfahrene Handwerker – möge Gott sein Werk segnen – baute das Butterfass meisterhaft.',
        exampleEn: 'The experienced craftsman — may God bless his work — crafted the butter churn masterfully.',
      ),
      ParentheticalRuleGuide(
        categoryTitle: 'الجملة التوضيحية المقحمة (Clarifying Parenthesis)',
        arPattern: 'جملة لتأكيد السياق أو نفي اللبس دون أن تؤثر في إعراب ما قبلها أو بعدها',
        dePattern: 'Parenthese zur Erläuterung ohne Einfluss auf die Satzstruktur',
        enPattern: 'Parenthetical explanatory clause without affecting core syntax',
        exampleAr: 'اللَّبَنُ الرَّائِبُ — وَهُوَ غِذَاءٌ نَافِعٌ — كَانَ صَافِيًا لَذِيذًا',
        exampleDe: 'Die reine Sauermilch – eine wohltuende Nahrung – war herrlich frisch.',
        exampleEn: 'The cultured milk — which is wholesome nourishment — was delightfully fresh.',
      ),
    ];
  }
}
