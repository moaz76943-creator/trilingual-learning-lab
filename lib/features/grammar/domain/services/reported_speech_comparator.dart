class ReportedSpeechRule {
  final String language;
  final String speechMechanism;
  final String tenseAdjustmentRule;
  final String directExample;
  final String reportedExample;

  const ReportedSpeechRule({
    required this.language,
    required this.speechMechanism,
    required this.tenseAdjustmentRule,
    required this.directExample,
    required this.reportedExample,
  });
}

class ReportedSpeechComparator {
  static List<ReportedSpeechRule> getReportedSpeechRules() {
    return const [
      ReportedSpeechRule(
        language: 'ar',
        speechMechanism: 'حكاية القول باستخدام (قَالَ إِنَّهُ...) أو (ذَكَرَ أَنَّ...)',
        tenseAdjustmentRule: 'تُكسر همزة إنَّ بعد القول، ويبقى زمن الفعل غالباً كما هو في المعنى الأصلي',
        directExample: 'قَالَ الصَّانِعُ: "أَنَا أُتْقِنُ عَمَلِي."',
        reportedExample: 'قَالَ الصَّانِعُ إِنَّهُ يُتْقِنُ عَمَلَهُ.',
      ),
      ReportedSpeechRule(
        language: 'de',
        speechMechanism: 'Indirekte Rede mit Konjunktiv I (oder Ersatzform mit "dass")',
        tenseAdjustmentRule: 'Verb steht im Konjunktiv I (z.B. er sage, er lerne) zur Wahrung der Distanz',
        directExample: 'Der Meister sagte: "Ich arbeite gewissenhaft."',
        reportedExample: 'Der Meister sagte, er arbeite gewissenhaft.',
      ),
      ReportedSpeechRule(
        language: 'en',
        speechMechanism: 'Reported Speech with reporting verb (said that, stated that)',
        tenseAdjustmentRule: 'Backshift of tenses: Present Simple becomes Past Simple',
        directExample: 'The artisan said: "I do my work carefully."',
        reportedExample: 'The artisan said that he did his work carefully.',
      ),
    ];
  }
}
