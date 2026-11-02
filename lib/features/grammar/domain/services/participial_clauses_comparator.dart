class ParticipialClauseRule {
  final String grammaticalFunction;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ParticipialClauseRule({
    required this.grammaticalFunction,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ParticipialClausesComparator {
  static List<ParticipialClauseRule> getRules() {
    return const [
      ParticipialClauseRule(
        grammaticalFunction: 'الحال الدالة على هيئة الفاعل أثناء الفعل (Circumstantial State)',
        arConstruction: 'الحال المفردة المنصوبة أو الجملة الحالية المقترنة بواو الحال',
        deConstruction: 'Partizip I als Adverbialpartizip (ohne Endung) zur Beschreibung der Art und Weise',
        enConstruction: 'Participial phrase with -ing describing concurrent action',
        exampleAr: 'خَرَجَ الصَّانِعُ مُبْتَسِمًا يَحْمِلُ نِتَاجَ عَمَلِهِ',
        exampleDe: 'Der Handwerker ging lächelnd hinaus, sein Werk tragend.',
        exampleEn: 'The artisan walked out smiling, carrying the fruit of his labor.',
      ),
      ParticipialClauseRule(
        grammaticalFunction: 'العبارة الوصفية المختصرة عن جملة الصلة (Reduced Relative Clause)',
        arConstruction: 'النعت السببي أو شبه الجملة المعرفة بالمشتق',
        deConstruction: 'Erweitertes Partizip II vor dem Nomen anstelle eines Relativsatzes',
        enConstruction: 'Past participial phrase functioning as post-modifier',
        exampleAr: 'شَاهَدْتُ الوَرَقَ المَصْنُوعَ بِأَيْدٍ مَاهِرَةٍ',
        exampleDe: 'Ich sah das mit geschickten Händen hergestellte Papier.',
        exampleEn: 'I saw the paper crafted by skilled hands.',
      ),
    ];
  }
}
