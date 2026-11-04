class ProhibitiveRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ProhibitiveRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ProhibitiveAdviceComparator {
  static List<ProhibitiveRuleGuide> getRules() {
    return const [
      ProhibitiveRuleGuide(
        categoryTitle: 'النهي الجازم الصريح (Strict Prohibition: لا الناهية / darf nicht)',
        arConstruction: 'لَا النَّاهِيَةُ الجَازِمَةُ + الفِعْلُ المُضَارِعُ المَجْزُومُ بِالسُّكُونِ أَوْ حَذْفِ النُّونِ/العِلَّةِ',
        deConstruction: 'Modalverb "dürfen" verneint (du darfst nicht / man darf nicht)',
        enConstruction: 'Must not / do not + base form (imperative prohibition)',
        exampleAr: 'لَا تُسْرِفْ فِي المَاءِ وَلَوْ كُنْتَ عَلَى نَهْرٍ جَارٍ',
        exampleDe: 'Du darfst kein Wasser verschwenden, selbst an einem strömenden Fluss.',
        exampleEn: 'You must not waste water, even if you are by a flowing river.',
      ),
      ProhibitiveRuleGuide(
        categoryTitle: 'النصح الوقائي اللطيف (Gentle Negative Advice: ينبغي ألا / solltest nicht)',
        arConstruction: 'يَنْبَغِي / يَحْسُنُ + أَلَّا (أَنْ المَصْدَرِيَّةُ النَّاصِبَةُ + لَا النَّافِيَةُ) + المُضَارِعُ المَنْصُوبُ',
        deConstruction: 'Konjunktiv II von sollen: "du solltest lieber nicht..."',
        enConstruction: 'You should not / had better not + base form',
        exampleAr: 'يَنْبَغِي أَلَّا نَحْبِسَ المَاءَ عَنْ بَسَاتِينِ الجِيرَانِ',
        exampleDe: 'Wir sollten das Wasser nicht vor den Gärten der Nachbarn zurückhalten.',
        exampleEn: 'We should not withhold the water from our neighbors\' orchards.',
      ),
    ];
  }
}
