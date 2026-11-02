class PronominalRule {
  final String entityType;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const PronominalRule({
    required this.entityType,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class PronominalAdverbsComparator {
  static List<PronominalRule> getRules() {
    return const [
      PronominalRule(
        entityType: 'الإشارة إلى الأشياء غير العاقلة (Inanimate Objects)',
        arConstruction: 'حرف الجر + الضمير المتصل العائد (فِيهِ، عَلَيْهِ، بِهِ)',
        deConstruction: 'da(r)- + Präposition (damit, darauf, davon)',
        enConstruction: 'Preposition + it / pronominal adverb (therewith, thereon)',
        exampleAr: 'هَذَا الحَجَرُ الصَّلْدُ بَنَيْتُ بِهِ الجِدَارَ',
        exampleDe: 'Hier ist der Naturstein; damit baute ich die Mauer.',
        exampleEn: 'Here is the natural stone; with it, I built the wall.',
      ),
      PronominalRule(
        entityType: 'الإشارة إلى الأشخاص والعقلاء (Persons)',
        arConstruction: 'حرف الجر + ضمير الغائب العاقل (مَعَهُ، إِلَيْهِ)',
        deConstruction: 'Präposition + Personalpronomen im Dativ/Akkusativ (mit ihm, an sie)',
        enConstruction: 'Preposition + objective pronoun (with him, to her)',
        exampleAr: 'تَعَلَّمْتُ مِنَ البَنَّاءِ الخَبِيرِ وَعَمِلْتُ مَعَهُ',
        exampleDe: 'Ich lernte vom Baumeister und arbeitete mit ihm.',
        exampleEn: 'I learned from the master builder and worked with him.',
      ),
    ];
  }
}
