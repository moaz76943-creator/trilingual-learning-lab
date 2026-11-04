class EpistemicRuleGuide {
  final String degreeOfCertainty;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const EpistemicRuleGuide({
    required this.degreeOfCertainty,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class EpistemicProbabilityComparator {
  static List<EpistemicRuleGuide> getRules() {
    return const [
      EpistemicRuleGuide(
        degreeOfCertainty: 'الاحتمال والترجيح المقارب (High Probability)',
        arConstruction: 'قَدْ + الفِعْلُ المُضَارِعُ (لِلتَّقْلِيلِ أَوِ التَّرْجِيحِ) / يَغْلِبُ عَلَى الظَّنِّ',
        deConstruction: 'dürfte + Infinitiv (drückt begründete Vermutung aus)',
        enConstruction: 'should / is likely to + base form',
        exampleAr: 'قَدْ يَصْفُو الزَّيْتُ العِطْرِيُّ بَعْدَ سَاعَةٍ مِنَ التَّكْثِيفِ',
        exampleDe: 'Das ätherische Öl dürfte sich nach einer Stunde Klären abscheiden.',
        exampleEn: 'The essential oil should separate after an hour of condensation.',
      ),
      EpistemicRuleGuide(
        degreeOfCertainty: 'اليقين والتحقق الجازم (Epistemic Certainty)',
        arConstruction: 'قَدْ + الفِعْلُ المَاضِي (لِلتَّحْقِيقِ) / لَا رَيْبَ / مِنَ المُؤَكَّدِ',
        deConstruction: 'muss (wohl) + Infinitiv / zweifellos',
        enConstruction: 'must + base form / undoubtedly',
        exampleAr: 'قَدْ نَضِجَتْ أَوْرَاقُ إِكْلِيلِ الجَبَلِ وَفَاحَ شَذَاهَا',
        exampleDe: 'Die Rosmarinblätter müssen voll ausgereift sein, so duften sie.',
        exampleEn: 'The rosemary leaves must be fully mature, judging by their rich aroma.',
      ),
    ];
  }
}
