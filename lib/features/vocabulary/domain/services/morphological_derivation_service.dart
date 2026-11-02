class MorphologicalPattern {
  final String categoryName;
  final String arWeight;
  final String deAffix;
  final String enAffix;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const MorphologicalPattern({
    required this.categoryName,
    required this.arWeight,
    required this.deAffix,
    required this.enAffix,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class MorphologicalDerivationService {
  static List<MorphologicalPattern> getCorePatterns() {
    return const [
      MorphologicalPattern(
        categoryName: 'اسم الفاعل والمهنة (Nomen Agentis)',
        arWeight: 'فَاعِلٌ / صَانِعٌ',
        deAffix: 'Suffix -er (der Weber, der Maler)',
        enAffix: 'Suffix -er / -or (weaver, creator)',
        exampleAr: 'نَسَّاجٌ / خَبَّازٌ (صِيَغُ مُبَالَغَةٍ لِلْمِهَنِ)',
        exampleDe: 'der Weber / der Bäcker',
        exampleEn: 'the weaver / the baker',
      ),
      MorphologicalPattern(
        categoryName: 'المصدر الصريح والاسم المجرد (Abstract Noun)',
        arWeight: 'فِعَالَةٌ (لِلْحِرَفِ) / فُعُولٌ',
        deAffix: 'Suffix -ung / -heit (die Webung, die Reinheit)',
        enAffix: 'Suffix -tion / -ment (production, development)',
        exampleAr: 'حِيَاكَةٌ / نِجَارَةٌ / زِرَاعَةٌ',
        exampleDe: 'das Weben / die Schreinerei / die Landwirtschaft',
        exampleEn: 'weaving / carpentry / agriculture',
      ),
    ];
  }
}
