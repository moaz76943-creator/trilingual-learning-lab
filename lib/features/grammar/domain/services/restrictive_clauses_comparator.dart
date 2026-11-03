class RestrictiveRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const RestrictiveRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class RestrictiveClausesComparator {
  static List<RestrictiveRuleGuide> getRules() {
    return const [
      RestrictiveRuleGuide(
        categoryTitle: 'القصر بأداة الحصر (Exclusive Restriction: إنما / nur)',
        arConstruction: 'إِنَّمَا (كافة ومكفوفة تفيد حصر المبتدأ في الخبر أو الفعل في الفاعل)',
        deConstruction: 'Fokuspartikel "nur" / "lediglich" vor dem betonten Satzglied',
        enConstruction: 'only / solely + emphasized element',
        exampleAr: 'إِنَّمَا يَنْفَعُ المَاءُ الصَّافِي عِنْدَ الصَّوْنِ',
        exampleDe: 'Nur das reine Wasser nützt, wenn man es sorgsam bewahrt.',
        exampleEn: 'Only pure water benefits when it is mindfully preserved.',
      ),
      RestrictiveRuleGuide(
        categoryTitle: 'الحصر بالنفي والاستثناء (Limitation by Negation: ما ... إلا)',
        arConstruction: 'مَا / لَا (نافية) + ... + إِلَّا (أداة حصر ملغاة في الإعراب حسب موقعها)',
        deConstruction: 'nichts / niemand ... außer / als (Negation mit Ausnahmebestimmung)',
        enConstruction: 'nothing / no one ... except / but',
        exampleAr: 'مَا الصِّهْرِيجُ إِلَّا خَزَّانُ خَيْرٍ وَعَافِيَةٍ',
        exampleDe: 'Die Zisterne ist nichts als ein Speicher des Segens und Wohls.',
        exampleEn: 'The cistern is nothing but a reservoir of blessing and wellness.',
      ),
    ];
  }
}
