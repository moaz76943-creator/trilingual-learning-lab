class NumberGrammarRule {
  final String category;
  final String arRule;
  final String deRule;
  final String enRule;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const NumberGrammarRule({
    required this.category,
    required this.arRule,
    required this.deRule,
    required this.enRule,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class CardinalOrdinalNumbersComparator {
  static List<NumberGrammarRule> getRules() {
    return const [
      NumberGrammarRule(
        category: 'الأعداد المفردة (3 - 10) ومخالفة المعدود',
        arRule: 'تخالف الأعداد (3-10) المعدود في التذكير والتأنيث، وتمييزها جمع مجرور',
        deRule: 'Kardinalzahlen bleiben meist unverändert (drei, vier, fünf)',
        enRule: 'Cardinal numbers precede the plural noun without gender variation',
        exampleAr: 'ثَلَاثَةُ قَنَادِيلَ (قنديل مذكر) / ثَلَاثُ قِنِّينَاتٍ (قنينة مؤنث)',
        exampleDe: 'drei Laternen / drei Flakons',
        exampleEn: 'three lanterns / three flasks',
      ),
      NumberGrammarRule(
        category: 'الأعداد الترتيبية (Ordinal Numbers)',
        arRule: 'تأتي على وزن (فَاعِل) وتطابق المعدود كالنعت في التعريف والإعراب',
        deRule: 'Ordinalzahlen enden auf -te (1-19) oder -ste (ab 20) und folgen der Adjektivdeklination',
        enRule: 'Ordinal numbers use -st, -nd, -rd, or -th (first, second, third)',
        exampleAr: 'البَابُ الأَوَّلُ / الغُرْفَةُ الثَّالِثَةُ',
        exampleDe: 'die erste Tür / das dritte Zimmer',
        exampleEn: 'the first door / the third room',
      ),
    ];
  }
}
