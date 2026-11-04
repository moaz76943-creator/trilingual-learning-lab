class IntonationPatternRule {
  final String sentenceIntent;
  final String arProsody;
  final String deProsody;
  final String enProsody;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const IntonationPatternRule({
    required this.sentenceIntent,
    required this.arProsody,
    required this.deProsody,
    required this.enProsody,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ProsodyIntonationService {
  static List<IntonationPatternRule> getRules() {
    return const [
      IntonationPatternRule(
        sentenceIntent: 'الاستفهام التثبتي (Confirmation Question)',
        arProsody: 'نبر تصاعدي في نهاية الكلمة الأخيرة لإشعار السامع بطلب الإقرار',
        deProsody: 'Steigende Tonhöhe am Satzende bei Ja/Nein-Fragen',
        enProsody: 'Rising pitch at the terminal boundary of yes/no questions',
        exampleAr: 'هَلْ هَذَا الكِتَابُ المَخْطُوطُ نَافِعٌ لِلْمُتَعَلِّمِ؟',
        exampleDe: 'Ist dieses Manuskriptbuch nützlich für den Lernenden?',
        exampleEn: 'Is this manuscript book beneficial for the learner?',
      ),
      IntonationPatternRule(
        sentenceIntent: 'التقرير والبيان الهادئ (Declarative Calm Assertion)',
        arProsody: 'نبر متوازن مستقر مع وقوف على السكون في رؤوس الجمل التامة',
        deProsody: 'Fallende Tonhöhe am Satzende für Gewissheit und Klarheit',
        enProsody: 'Falling intonation at the end of confident declarative sentences',
        exampleAr: 'العِلْمُ النَّافِعُ نُورٌ يَبْعَثُ السَّكِينَةَ فِي القُلُوبِ',
        exampleDe: 'Nützliches Wissen ist ein Licht, das Ruhe ins Herz schenkt.',
        exampleEn: 'Beneficial knowledge is a light that brings peace to the heart.',
      ),
    ];
  }
}
