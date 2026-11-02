class ImperativeFormComparison {
  final String moodContext;
  final String arFormula;
  final String deFormula;
  final String enFormula;
  final String practicalExample;

  const ImperativeFormComparison({
    required this.moodContext,
    required this.arFormula,
    required this.deFormula,
    required this.enFormula,
    required this.practicalExample,
  });
}

class ImperativeRequestComparator {
  static List<ImperativeFormComparison> comparePoliteRequests() {
    return const [
      ImperativeFormComparison(
        moodContext: 'الطلب المهذب في المعاملات اليومية',
        arFormula: 'مِنْ فَضْلِكَ + فِعْلُ الأَمْرِ / المُضَارِعُ المَسْبُوقُ بِلَامِ الرِّفْقِ',
        deFormula: 'Höfliche Bitte mit Konjunktiv II: "Würden Sie bitte..." / "Könnten Sie..."',
        enFormula: 'Polite Request: "Could you please..." / "Would you mind..."',
        practicalExample: 'مِنْ فَضْلِكَ أَغْلِقِ البَابَ | Würden Sie bitte die Tür schließen? | Could you please close the door?',
      ),
      ImperativeFormComparison(
        moodContext: 'الأمر المباشر الصريح للتعليمات',
        arFormula: 'فِعْلُ أَمْرٍ مَبْنِيٌّ عَلَى السُّكُونِ أَوْ حَذْفِ حَرْفِ العِلَّةِ',
        deFormula: 'Imperativ: Verbstamm (+ e) für "du" / Verbstamm + en für "Sie"',
        enFormula: 'Direct Imperative: Base form of the verb without subject',
        practicalExample: 'اِقْرَأْ بِتَأَنٍّ | Lies aufmerksam! | Read carefully!',
      ),
    ];
  }
}
