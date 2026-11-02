class RelativeClauseGuide {
  final String language;
  final String relativePronounSummary;
  final String wordOrderRule;
  final String example;

  const RelativeClauseGuide({
    required this.language,
    required this.relativePronounSummary,
    required this.wordOrderRule,
    required this.example,
  });
}

class RelativeClauseComparator {
  static List<RelativeClauseGuide> compareRelativeStructures() {
    return const [
      RelativeClauseGuide(
        language: 'ar',
        relativePronounSummary: 'الأسماء الموصولة (الَّذِي، الَّتِي، الَّذِينَ...) تتبع المنعوت في الجنس والعدد.',
        wordOrderRule: 'جملة الصلة تأتي بعد الاسم الموصول وتحتوي على ضمير عائد (رابط) غالباً.',
        example: 'هَذَا هُوَ المُزَارِعُ الَّذِي جَنَى الزَّيْتُونَ.',
      ),
      RelativeClauseGuide(
        language: 'de',
        relativePronounSummary: 'Relativpronomen (der, die, das, welcher...) richten sich nach Genus und Kasus.',
        wordOrderRule: 'Im Relativsatz steht das finite konjugierte Verb zwingend am Satzende (Verb-Ende).',
        example: 'Das ist der Bauer, der die Oliven geerntet hat.',
      ),
      RelativeClauseGuide(
        language: 'en',
        relativePronounSummary: 'Relative pronouns (who for people, which for things, that for both).',
        wordOrderRule: 'The relative clause follows standard SVO order immediately after the antecedent.',
        example: 'This is the farmer who harvested the olives.',
      ),
    ];
  }
}
