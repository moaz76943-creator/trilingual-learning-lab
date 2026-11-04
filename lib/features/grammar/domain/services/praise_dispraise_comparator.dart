class PraiseRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const PraiseRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class PraiseDispraiseComparator {
  static List<PraiseRuleGuide> getRules() {
    return const [
      PraiseRuleGuide(
        categoryTitle: 'أسلوب المدح العام (General Praise: نِعْمَ / lobenswert)',
        arConstruction: 'نِعْمَ (فعل ماض جامد لإنشاء المدح) + الفاعل المعرف + المخصوص بالمدح المرفوع',
        deConstruction: 'Lobende Prädikation: "Lobenswert ist..." / "Vorbildlich ist..."',
        enConstruction: 'Commendable is + subject / "What an excellent ... is!"',
        exampleAr: 'نِعْمَ الخُلُقُ الأَمَانَةُ فِي صِيَاغَةِ المَعَادِنِ',
        exampleDe: 'Lobenswert ist die Tugend der Ehrlichkeit beim Silberschmieden.',
        exampleEn: 'Commendable is the virtue of honesty in silversmithing.',
      ),
      PraiseRuleGuide(
        categoryTitle: 'المدح المقترن بالإشارة (Specific Praise: حَبَّذَا / wie trefflich)',
        arConstruction: 'حَبَّ (فعل ماض للمدح) + ذَا (اسم إشارة فاعل) + المخصوص بالمدح',
        deConstruction: 'Bekräftigendes Lob: "Wie trefflich ist..." / "Hochzuschätzen ist..."',
        enConstruction: 'Splendid indeed is + subject / "How wonderful is..."',
        exampleAr: 'حَبَّذَا الإِتْقَانُ فِي نَقْشِ الفِضَّةِ',
        exampleDe: 'Wie trefflich ist die Meisterschaft beim Gravieren des Silbers!',
        exampleEn: 'Splendid indeed is mastery in silver engraving!',
      ),
    ];
  }
}
