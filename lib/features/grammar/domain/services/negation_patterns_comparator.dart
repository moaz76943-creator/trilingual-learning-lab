class NegationComparisonRule {
  final String negationCategory;
  final String arRule;
  final String deRule;
  final String enRule;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const NegationComparisonRule({
    required this.negationCategory,
    required this.arRule,
    required this.deRule,
    required this.enRule,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class NegationPatternsComparator {
  static List<NegationComparisonRule> getRules() {
    return const [
      NegationComparisonRule(
        negationCategory: 'نفي الأفعال في الماضي والمستقبل (Tense Negation)',
        arRule: 'لَمْ (تجزم المضارع لنفي الماضي) / لَنْ (تنصب المضارع لنفي المستقبل)',
        deRule: 'nicht steht nach dem finiten Verb oder am Satzende bei trennbaren Verben',
        enRule: 'did not + base form (Past) / will not + base form (Future)',
        exampleAr: 'لَمْ يَفْسُدِ الخَشَبُ | لَنْ نَتْرُكَ العَمَلَ',
        exampleDe: 'Das Holz verdarb nicht | Wir werden die Arbeit nicht verlassen.',
        exampleEn: 'The wood did not decay | We will not abandon the work.',
      ),
      NegationComparisonRule(
        negationCategory: 'نفي الأسماء والكميات (Noun & Quantity Negation)',
        arRule: 'لَا النَّافِيَةُ لِلْجِنْسِ (تنصب الاسم بغير تنوين) / لَيْسَ (فعل ناقص)',
        deRule: 'kein verneint Nomen mit unbestimmtem Artikel oder ohne Artikel (Nullartikel)',
        enRule: 'no + noun / not any + noun',
        exampleAr: 'لَا إِسْرَافَ فِي البِنَاءِ',
        exampleDe: 'Es gibt keine Verschwendung beim Bau.',
        exampleEn: 'There is no waste in the construction.',
      ),
    ];
  }
}
