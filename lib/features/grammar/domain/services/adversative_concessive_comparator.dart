class ContrastRuleGuide {
  final String contrastType;
  final String arConnector;
  final String deConnector;
  final String enConnector;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ContrastRuleGuide({
    required this.contrastType,
    required this.arConnector,
    required this.deConnector,
    required this.enConnector,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class AdversativeConcessiveComparator {
  static List<ContrastRuleGuide> getRules() {
    return const [
      ContrastRuleGuide(
        contrastType: 'المقابلة التناقضية في جملة تابعة (Subordinate Contrast: بينما / während)',
        arConnector: 'بَيْنَمَا / فِي حِينِ أَنَّ (تفيد المقابلة بين أمرين متزامنين)',
        deConnector: 'während / wohingegen (Subjunktion: Verb zwingend am Satzende)',
        enConnector: 'whereas / while + Subject + Verb',
        exampleAr: 'يَصْنَعُ النَّجَّارُ الإِطَارَ الخَشَبِيَّ بَيْنَمَا يَغْزِلُ الآخَرُ الصُّوفَ',
        exampleDe: 'Der Tischler fertigt den Rahmen, während der andere die Wolle spinnt.',
        exampleEn: 'The carpenter makes the frame, whereas the other spins the wool.',
      ),
      ContrastRuleGuide(
        contrastType: 'الاستدراك والتباين في جملة رئيسية (Main Clause Contrast: أَمَّا / dagegen)',
        arConnector: 'أَمَّا ... فَـ / وَبِالمُقَابِلِ (ظرف يفيد التمييز)',
        deConnector: 'dagegen / jedoch / hingegen (Adverb: Inversion auf Position 1 oder im Satzinneren)',
        enConnector: 'on the other hand / in contrast / however',
        exampleAr: 'الأَحْجَارُ صَلْبَةٌ، وَبِالمُقَابِلِ يَكُونُ الصُّوفُ لَيِّنًا',
        exampleDe: 'Steine sind fest; Wolle hingegen ist wunderbar weich.',
        exampleEn: 'Stones are solid; wool, on the other hand, is wonderfully soft.',
      ),
    ];
  }
}
