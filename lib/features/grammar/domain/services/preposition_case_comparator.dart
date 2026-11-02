class PrepositionRule {
  final String relationType;
  final String arPreposition;
  final String dePreposition;
  final String deCaseRule;
  final String enPreposition;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const PrepositionRule({
    required this.relationType,
    required this.arPreposition,
    required this.dePreposition,
    required this.deCaseRule,
    required this.enPreposition,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class PrepositionCaseComparator {
  static List<PrepositionRule> getPrepositionRules() {
    return const [
      PrepositionRule(
        relationType: 'المكان الثابت / السكون (Location: Wo?)',
        arPreposition: 'فِي / عَلَى (يجر الاسم بالكسرة)',
        dePreposition: 'in / auf (+ Dativ)',
        deCaseRule: 'حالة القابل (Dativ) تدل على الموقع الثابت دون انتقال',
        enPreposition: 'in / on (+ Object)',
        exampleAr: 'المَاءُ فِي البِئْرِ',
        exampleDe: 'Das Wasser ist in dem (im) Brunnen.',
        exampleEn: 'The water is in the well.',
      ),
      PrepositionRule(
        relationType: 'الحركة والاتجاه نحو الهدف (Direction: Wohin?)',
        arPreposition: 'إِلَى / نَحْوَ',
        dePreposition: 'in / auf (+ Akkusativ)',
        deCaseRule: 'حالة النصب (Akkusativ) تدل على الحركة والتغير في المكان',
        enPreposition: 'into / onto / to',
        exampleAr: 'تَدَفَّقَ المَاءُ إِلَى القَنَاةِ',
        exampleDe: 'Das Wasser fließt in den Kanal.',
        exampleEn: 'The water flows into the channel.',
      ),
    ];
  }
}
