class RhetoricalRuleGuide {
  final String interrogationType;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String answerParticleRule;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const RhetoricalRuleGuide({
    required this.interrogationType,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.answerParticleRule,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class RhetoricalQuestionsComparator {
  static List<RhetoricalRuleGuide> getRules() {
    return const [
      RhetoricalRuleGuide(
        interrogationType: 'الاستفهام التقريري المثبت لنفي النفي (Affirmative Rhetorical: أليس / doch)',
        arConstruction: 'همزة الاستفهام + أداة النفي (أَلَيْسَ / أَلَمْ / أَلَا)',
        deConstruction: 'Verneinte Frage zur Bestätigung: "Ist es nicht so...?" / "nicht wahr?"',
        enConstruction: 'Negative question / Tag question: "Isn\'t it...?" / "Hasn\'t he...?"',
        answerParticleRule: 'يُجاب بـ (بَلَى) للإثبات ونفي النفي، وفي الألمانية يُجاب بـ (doch)',
        exampleAr: 'أَلَيْسَ الصِّبَاغُ الطَّبِيعِيُّ أَنْقَى وَأَبْقَى؟ — بَلَى!',
        exampleDe: 'Ist die Naturfarbe nicht reiner und dauerhafter? — Doch!',
        exampleEn: 'Isn\'t natural dye purer and more lasting? — Yes, indeed!',
      ),
      RhetoricalRuleGuide(
        interrogationType: 'الاستفهام المتضمن معنى النفي الجازم (Denying Interrogation: هل ... إلا)',
        arConstruction: 'هَلْ + الجُمْلَةُ + إِلَّا (تفيد أن الجواب محصور في النفي التام)',
        deConstruction: 'Rhetorische Frage mit unbestreitbarer negativer Antwort',
        enConstruction: 'Rhetorical question expecting a negative conviction',
        answerParticleRule: 'لا يحتاج إلى جواب لفظي لأن المعنى مغروس في الفطرة والعقل',
        exampleAr: 'هَلْ جَزَاءُ الإِحْسَانِ إِلَّا الإِحْسَانُ؟',
        exampleDe: 'Gibt es für das Gute einen anderen Lohn als das Gute?',
        exampleEn: 'Is the reward for goodness anything other than goodness?',
      ),
    ];
  }
}
