class ComparisonDegreeRule {
  final String language;
  final String comparativePattern;
  final String superlativePattern;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ComparisonDegreeRule({
    required this.language,
    required this.comparativePattern,
    required this.superlativePattern,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ComparisonDegreeComparator {
  static List<ComparisonDegreeRule> getComparisonRules() {
    return const [
      ComparisonDegreeRule(
        language: 'ar',
        comparativePattern: 'اسم التفضيل على وزن (أَفْعَلُ مِنْ)',
        superlativePattern: 'المعرف بأل (الأَفْعَلُ) أو المضاف (أَفْعَلُ القَوْمِ)',
        exampleAr: 'العِلْمُ أَنْفَعُ مِنَ المَالِ | هَذَا هُوَ العَمَلُ الأَنْفَعُ',
        exampleDe: 'Wissen ist nützlicher als Geld | Das ist das nützlichste Werk',
        exampleEn: 'Knowledge is more useful than wealth | This is the most useful deed',
      ),
      ComparisonDegreeRule(
        language: 'de',
        comparativePattern: 'Adjektivstamm + -er (als)',
        superlativePattern: 'am + Adjektivstamm + -(e)sten / der, die, das + -ste',
        exampleAr: 'الصَّانِعُ أَمْهَرُ | الصَّانِعُ الأَمْهَرُ',
        exampleDe: 'Der Handwerker ist geschickter | der geschickteste Handwerker',
        exampleEn: 'The artisan is more skilled | the most skilled artisan',
      ),
      ComparisonDegreeRule(
        language: 'en',
        comparativePattern: '-er than (short) / more ... than (long)',
        superlativePattern: 'the -est (short) / the most ... (long)',
        exampleAr: 'أَقْوَى مِنْ | الأَقْوَى',
        exampleDe: 'stärker als | der stärkste',
        exampleEn: 'stronger than | the strongest',
      ),
    ];
  }
}
