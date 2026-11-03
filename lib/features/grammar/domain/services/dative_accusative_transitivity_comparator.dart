class DitransitiveRuleGuide {
  final String categoryTitle;
  final String arRule;
  final String deRule;
  final String enRule;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const DitransitiveRuleGuide({
    required this.categoryTitle,
    required this.arRule,
    required this.deRule,
    required this.enRule,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class DativeAccusativeTransitivityComparator {
  static List<DitransitiveRuleGuide> getRules() {
    return const [
      DitransitiveRuleGuide(
        categoryTitle: 'أفعال المنح والعطاء بالأسماء الظاهرة (Nominal Objects)',
        arRule: 'الفعل المتعدي لمفعولين ينصب المفعولين مباشرة (المفعول الأول والثاني)',
        deRule: 'Dativ-Objekt (Person) steht vor Akkusativ-Objekt (Sache): jemandem [Dat] etwas [Akk] geben',
        enRule: 'Subject + Verb + Indirect Object + Direct Object (or: to + indirect object)',
        exampleAr: 'أَعْطَى المُعَلِّمُ الطَّالِبَ كِتَابًا نَافِعًا',
        exampleDe: 'Der Lehrer gab dem Schüler ein nützliches Buch.',
        exampleEn: 'The teacher gave the student a useful book.',
      ),
      DitransitiveRuleGuide(
        categoryTitle: 'ترتيب المفعولين عند استخدام الضمائر (Pronominal Order)',
        arRule: 'يتصل الضميران بالفعل مع تقديم ضمير المتكلم/المخاطب على الغائب',
        deRule: 'Wenn beide Objekte Pronomen sind: Akkusativ-Pronomen steht zwingend vor Dativ-Pronomen',
        enRule: 'Pronoun direct object precedes prepositional indirect object (gave it to him)',
        exampleAr: 'أَعْطَانِيهِ الصَّانِعُ بِكَرَمٍ',
        exampleDe: 'Der Handwerker gab es ihm großzügig.',
        exampleEn: 'The artisan gave it to him generously.',
      ),
    ];
  }
}
