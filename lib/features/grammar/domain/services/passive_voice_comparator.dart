class PassiveVoiceRule {
  final String language;
  final String structureType;
  final String formula;
  final String activeExample;
  final String passiveExample;

  const PassiveVoiceRule({
    required this.language,
    required this.structureType,
    required this.formula,
    required this.activeExample,
    required this.passiveExample,
  });
}

class PassiveVoiceComparator {
  static List<PassiveVoiceRule> getPassiveRules() {
    return const [
      PassiveVoiceRule(
        language: 'ar',
        structureType: 'الفِعْلُ المَبْنِيُّ لِلْمَجْهُولِ + نَائِبُ الفَاعِلِ',
        formula: 'يُضَمُّ أَوَّلُهُ وَيُكْسَرُ مَا قَبْلَ آخِرِهِ فِي المَاضِي، وَيُفْتَحُ فِي المُضَارِعِ',
        activeExample: 'نَسَجَ الصَّانِعُ الثَّوْبَ',
        passiveExample: 'نُسِجَ الثَّوْبُ بِإِتْقَانٍ (الثَّوْبُ: نَائِبُ فَاعِلٍ مَرْفُوعٌ)',
      ),
      PassiveVoiceRule(
        language: 'de',
        structureType: 'Das Vorgangspassiv (Prozesspassiv)',
        formula: 'werden (konjugiert) + Partizip II am Satzende (+ von + Dativ für Agens)',
        activeExample: 'Der Weber webt den Stoff.',
        passiveExample: 'Der Stoff wird meisterhaft gewebt.',
      ),
      PassiveVoiceRule(
        language: 'en',
        structureType: 'Passive Voice',
        formula: 'Subject + form of "to be" + Past Participle (+ by agent)',
        activeExample: 'The weaver weaves the fabric.',
        passiveExample: 'The fabric is masterfully woven.',
      ),
    ];
  }
}
