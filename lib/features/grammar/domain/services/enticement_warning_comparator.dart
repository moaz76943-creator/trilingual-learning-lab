class EnticementWarningRule {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const EnticementWarningRule({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class EnticementWarningComparator {
  static List<EnticementWarningRule> getRules() {
    return const [
      EnticementWarningRule(
        categoryTitle: 'أسلوب الإغراء والحث على الفضيلة (Urgent Enticement)',
        arConstruction: 'نصب الاسم المغرى به بفعل محذوف وجوباً تقديره (الْزَمْ) مع التكرار أو العطف',
        deConstruction: 'Dringlicher Aufruf: "Halte stets an ... fest!" / "Übe dich in..."',
        enConstruction: 'Direct imperative exhortation: "Adhere to..." / "Practise always..."',
        exampleAr: 'الأَمَانَةَ الأَمَانَةَ فِي حِفْظِ وَدَائِعِ النَّاسِ',
        exampleDe: 'Halte gewissenhaft an der Treue beim Bewahren von Gütern fest!',
        exampleEn: 'Hold fast to honesty when keeping people\'s trusts!',
      ),
      EnticementWarningRule(
        categoryTitle: 'أسلوب التحذير من الإهمال والتقصير (Solemn Warning: إياك و / hüte dich)',
        arConstruction: 'إِيَّاكَ + الواو + المحذر منه المنصوب بفعل محذوف تقديره (احْذَرْ)',
        deConstruction: 'Warnung mit "Hüte dich vor (+ Dativ)" / "Vermeide unbedingt..."',
        enConstruction: 'Beware of / take heed not to + base form',
        exampleAr: 'إِيَّاكَ وَالتَّفْرِيطَ فِي صِيَانَةِ أَمْتِعَةِ السَّفَرِ',
        exampleDe: 'Hüte dich vor jeder Nachlässigkeit bei der Pflege des Reisegepäcks!',
        exampleEn: 'Beware of negligence in safeguarding travel luggage!',
      ),
    ];
  }
}
