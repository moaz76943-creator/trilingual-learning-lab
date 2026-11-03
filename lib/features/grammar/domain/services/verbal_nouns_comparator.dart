class VerbalNounRule {
  final String category;
  final String arFormation;
  final String deFormation;
  final String enFormation;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const VerbalNounRule({
    required this.category,
    required this.arFormation,
    required this.deFormation,
    required this.enFormation,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class VerbalNounsComparator {
  static List<VerbalNounRule> getRules() {
    return const [
      VerbalNounRule(
        category: 'المصدر الصريح الدال على الحدث المجرد (Event Noun)',
        arFormation: 'المصدر الأصلي (فِعَالَةٌ لِلْمِهْنَةِ، تَفْعِيلٌ، إِفْعَالٌ)',
        deFormation: 'das + substantivierter Infinitiv großgeschrieben (das Pflanzen, das Lernen)',
        enFormation: 'Gerund with -ing ending (planting, learning, building)',
        exampleAr: 'إِتْقَانُ الغَرْسِ يُثْمِرُ خَيْرًا',
        exampleDe: 'Das sorgfältige Pflanzen bringt reiche Frucht hervor.',
        exampleEn: 'Careful planting yields abundant fruit.',
      ),
      VerbalNounRule(
        category: 'إضافة المصدر إلى فاعله أو مفعوله (Genitive / Object Construction)',
        arFormation: 'إضافة المصدر إلى مفعوله (غَرْسُ الأَشْجَارِ) مع بقاء دلالة الفعل',
        deFormation: 'Substantiviertes Verb mit Genitivattribut (das Pflanzen der Bäume)',
        enFormation: 'Gerund followed by object / "of" phrase (the planting of trees)',
        exampleAr: 'يَسُرُّنِي سَمَاعُ خَرِيرِ المِيَاهِ',
        exampleDe: 'Das Hören des Wasserplätscherns erfreut mich.',
        exampleEn: 'Hearing the murmur of water pleases me.',
      ),
    ];
  }
}
