class PurposeClauseGuide {
  final String relationType;
  final String arFormula;
  final String deFormula;
  final String enFormula;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const PurposeClauseGuide({
    required this.relationType,
    required this.arFormula,
    required this.deFormula,
    required this.enFormula,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class InfinitiveClausesComparator {
  static List<PurposeClauseGuide> getPurposeGuides() {
    return const [
      PurposeClauseGuide(
        relationType: 'وحدة الفاعل بين الجملتين (Same Subject)',
        arFormula: 'لِـ (لامُ التَّعْلِيلِ) / كَيْ + الفِعْلُ المُضَارِعُ المَنْصُوبُ',
        deFormula: 'um ... zu + Infinitiv am Satzende',
        enFormula: 'in order to + base form',
        exampleAr: 'يَطْرُقُ الحَدَّادُ الحَدِيدَ لِيَصْنَعَ مِنْجَلًا',
        exampleDe: 'Der Schmied hämmert das Eisen, um eine Sichel herzustellen.',
        exampleEn: 'The blacksmith hammers the iron in order to make a sickle.',
      ),
      PurposeClauseGuide(
        relationType: 'اختلاف الفاعل بين الجملتين (Different Subjects)',
        arFormula: 'حَتَّى / لِكَيْ + فِعْلٌ مُضَارِعٌ (مَعَ ذِكْرِ الفَاعِلِ الجَدِيدِ)',
        deFormula: 'damit + Subjekt (Nebensatz: Verb zwingend am Ende)',
        enFormula: 'so that + Subject + can/may + verb',
        exampleAr: 'نُعِدُّ أَدَوَاتِ الزِّرَاعَةِ لِيَحْصُدَ الفَلَّاحُونَ القَمْحَ',
        exampleDe: 'Wir fertigen die Werkzeuge an, damit die Bauern den Weizen ernten können.',
        exampleEn: 'We prepare the tools so that the farmers can harvest the wheat.',
      ),
    ];
  }
}
