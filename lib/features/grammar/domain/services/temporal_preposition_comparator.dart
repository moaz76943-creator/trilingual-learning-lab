class TemporalPrepositionRule {
  final String timeRelation;
  final String arPreposition;
  final String dePreposition;
  final String deGrammarCase;
  final String enPreposition;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const TemporalPrepositionRule({
    required this.timeRelation,
    required this.arPreposition,
    required this.dePreposition,
    required this.deGrammarCase,
    required this.enPreposition,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class TemporalPrepositionComparator {
  static List<TemporalPrepositionRule> getTemporalRules() {
    return const [
      TemporalPrepositionRule(
        timeRelation: 'نقطة البداية المستمرة في الزمان (Starting Point: Seit)',
        arPreposition: 'مُنْذُ (تجر الاسم أو تضاف للجملة)',
        dePreposition: 'seit (+ Dativ)',
        deGrammarCase: 'تُستعمل مع المضارع للدلالة على حدث بدأ في الماضي ومستمر',
        enPreposition: 'since / for (+ Perfect Tense)',
        exampleAr: 'أَعْمَلُ فِي الغَرْسِ مُنْذُ الصَّبَاحِ',
        exampleDe: 'Ich arbeite seit dem Morgen an der Pflanzung.',
        exampleEn: 'I have been planting since the morning.',
      ),
      TemporalPrepositionRule(
        timeRelation: 'الترتيب الزماني والتعاقب (Sequence: Vor / Nach)',
        arPreposition: 'قَبْلَ / بَعْدَ (ظروف زمان مضافة)',
        dePreposition: 'vor / nach (+ Dativ)',
        deGrammarCase: 'تتطلب حالة المجرور (Dativ) دائماً في الاستعمال الزمني',
        enPreposition: 'before / after',
        exampleAr: 'نَبْدَأُ الجَنْيَ قَبْلَ غُرُوبِ الشَّمْسِ',
        exampleDe: 'Wir beginnen die Ernte vor dem Sonnenuntergang.',
        exampleEn: 'We begin the harvest before sunset.',
      ),
    ];
  }
}
