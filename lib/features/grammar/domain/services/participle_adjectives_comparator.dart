class ParticipleAdjectiveRule {
  final String participleType;
  final String arConcept;
  final String deConcept;
  final String enConcept;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const ParticipleAdjectiveRule({
    required this.participleType,
    required this.arConcept,
    required this.deConcept,
    required this.enConcept,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ParticipleAdjectivesComparator {
  static List<ParticipleAdjectiveRule> getParticipleRules() {
    return const [
      ParticipleAdjectiveRule(
        participleType: 'اسم الفاعل الوصفي (Active Participle / Partizip I)',
        arConcept: 'اسم الفاعل المشتق للدلالة على من قام بالفعل بصفة جارية',
        deConcept: 'Partizip I (Infinitiv + d) drückt eine aktive, gleichzeitige Handlung aus',
        enConcept: 'Present Participle (-ing) acting as an attributive adjective',
        exampleAr: 'المَاءُ الجَارِي العَذْبُ',
        exampleDe: 'das fließende, frische Wasser',
        exampleEn: 'the flowing, fresh water',
      ),
      ParticipleAdjectiveRule(
        participleType: 'اسم المفعول الوصفي (Passive Participle / Partizip II)',
        arConcept: 'اسم المفعول المشتق للدلالة على ما وقع عليه الفعل واستقر',
        deConcept: 'Partizip II (ge-...-t / ge-...-en) beschreibt einen vollendeten Zustand',
        enConcept: 'Past Participle (-ed / 3rd form) functioning as an adjective',
        exampleAr: 'الإِبْرِيقُ المَصْقُولُ بِعِنَايَةٍ',
        exampleDe: 'die sorgfältig polierte Kanne',
        exampleEn: 'the carefully polished pitcher',
      ),
    ];
  }
}
