class MannerComparisonRule {
  final String comparisonType;
  final String arPattern;
  final String dePattern;
  final String enPattern;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const MannerComparisonRule({
    required this.comparisonType,
    required this.arPattern,
    required this.dePattern,
    required this.enPattern,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class MannerSimilarityComparator {
  static List<MannerComparisonRule> getRules() {
    return const [
      MannerComparisonRule(
        comparisonType: 'التشبيه الواقعي المطابق (Real Comparison: كَمَا / wie)',
        arPattern: 'كَـ (حرف جر وتشبيه) / كَمَا + الجُمْلَةُ الفِعْلِيَّةُ',
        dePattern: 'wie + Hauptsatz / Nebensatz ohne Modusänderung',
        enPattern: 'as / just as + clause',
        exampleAr: 'تَدُورُ التُّرُوسُ كَمَا قَدَّرَهَا الصَّانِعُ',
        exampleDe: 'Die Zahnräder drehen sich, wie der Meister es plante.',
        exampleEn: 'The gears turn just as the master planned.',
      ),
      MannerComparisonRule(
        comparisonType: 'التشبيه الافتراضي والظن (Hypothetical: كَأَنَّ / als ob)',
        arPattern: 'كَأَنَّ (حرف ناسخ يفيد التشبيه وينصب الاسم)',
        dePattern: 'als ob / als wenn + Konjunktiv II (Verb am Satzende)',
        enPattern: 'as if / as though + subjunctive/past tense',
        exampleAr: 'يَتَأَرْجَحُ البَنَدُولُ كَأَنَّهُ يَنْبِضُ بِالحَيَاةِ',
        exampleDe: 'Das Pendel schwingt, als ob es lebendig pulsiere.',
        exampleEn: 'The pendulum swings as if it were pulsing with life.',
      ),
    ];
  }
}
