class AppositiveRuleGuide {
  final String relationName;
  final String arGrammarRule;
  final String deGrammarRule;
  final String enGrammarRule;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const AppositiveRuleGuide({
    required this.relationName,
    required this.arGrammarRule,
    required this.deGrammarRule,
    required this.enGrammarRule,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class AppositiveClausesComparator {
  static List<AppositiveRuleGuide> getAppositiveRules() {
    return const [
      AppositiveRuleGuide(
        relationName: 'البدل المطابق التوضيحي (Explanatory Apposition)',
        arGrammarRule: 'البدل يتبع المبدل منه في إعرابه (رفعاً ونصباً وجراً) لإيضاحه',
        deGrammarRule: 'Die Apposition steht im gleichen Kasus wie das Bezugswort (Kongruenz)',
        enGrammarRule: 'Appositives rename the preceding noun and are framed with commas',
        exampleAr: 'زُرْتُ العَطَّارَ زَيْدًا فِي دُكَّانِهِ',
        exampleDe: 'Ich besuchte den Kräuterkundigen Zaid in seinem Laden.',
        exampleEn: 'I visited the herbalist Zaid in his shop.',
      ),
      AppositiveRuleGuide(
        relationName: 'بدل الاشتمال أو الجزء (Partitive / Inclusive Apposition)',
        arGrammarRule: 'بدل البعض أو الاشتمال يتصل به ضمير يعود على المبدل منه',
        deGrammarRule: 'Teil- oder Inhaltsbestimmung durch nachgestellte Präzisierungen',
        enGrammarRule: 'Partitive appositives clarifying a component or quality',
        exampleAr: 'أَعْجَبَنِي النَّبَاتُ رَائِحَتُهُ الزَّكِيَّةُ',
        exampleDe: 'Die Pflanze gefiel mir, ihr herrlicher Duft.',
        exampleEn: 'The plant delighted me, its fragrant aroma.',
      ),
    ];
  }
}
