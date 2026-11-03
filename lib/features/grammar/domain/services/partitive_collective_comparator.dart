class PartitiveRuleGuide {
  final String categoryTitle;
  final String arRule;
  final String deRule;
  final String enRule;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const PartitiveRuleGuide({
    required this.categoryTitle,
    required this.arRule,
    required this.deRule,
    required this.enRule,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class PartitiveCollectiveComparator {
  static List<PartitiveRuleGuide> getRules() {
    return const [
      PartitiveRuleGuide(
        categoryTitle: 'اسم الجنس الجمعي والإفرادي (Collective vs Unit Noun)',
        arRule: 'يُميز بين الجمع والمفرد بتاء التأنيث المربوطة غالباً (تِينٌ: جمع جنس / تِينَةٌ: مفرد)',
        deRule: 'Kollektivum im Singular (das Obst, die Feige/Feigen als Zählnomen)',
        enRule: 'Mass / collective noun vs countable unit (figs as fruit / a single fig)',
        exampleAr: 'نَضِجَ التِّينُ فِي البُسْتَانِ | قَطَفْتُ تِينَةً حُلْوَةً',
        exampleDe: 'Die Feigen sind reif | Ich pflückte eine süße Feige.',
        exampleEn: 'The figs are ripe | I picked a sweet fig.',
      ),
      PartitiveRuleGuide(
        categoryTitle: 'تراكيب المقادير والتبعيض (Partitive Quantity Constructions)',
        arRule: 'اسم المقدار مضافاً إلى المادة أو متبوعاً بتمييز ملحوظ (سَلَّةُ تِينٍ / قَفَصٌ تِينًا)',
        deRule: 'Mengenangabe + Substantiv im gleichen Kasus ohne Präposition (ein Korb reife Feigen)',
        enRule: 'Container / measure + "of" + noun (a basket of ripe figs)',
        exampleAr: 'جَنَيْنَا سَلَّةً مِنَ التِّينِ الطَّازَجِ',
        exampleDe: 'Wir ernteten einen Korb frische Feigen.',
        exampleEn: 'We harvested a basket of fresh figs.',
      ),
    ];
  }
}
