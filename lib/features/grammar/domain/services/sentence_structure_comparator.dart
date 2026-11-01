class StructureAnalysisResult {
  final String arabicPattern;
  final String germanWordOrder;
  final String englishWordOrder;
  final String comparativeNote;

  const StructureAnalysisResult({
    required this.arabicPattern,
    required this.germanWordOrder,
    required this.englishWordOrder,
    required this.comparativeNote,
  });
}

class SentenceStructureComparator {
  static StructureAnalysisResult compareVerbalAction({
    required bool isSubordinateClause,
  }) {
    if (isSubordinateClause) {
      return const StructureAnalysisResult(
        arabicPattern: 'أَدَاةُ الشَّرْطِ / الرَّبْطِ + الفِعْلُ + الفَاعِلُ',
        germanWordOrder: 'Nebensatz: Konjunktion + Subjekt + ... + Verb am Ende (Verb-Ende)',
        englishWordOrder: 'Subordinate: Conjunction + Subject + Verb + Object (SVO)',
        comparativeNote: 'في الألمانية ينتقل الفعل المصرف إجبارياً إلى نهاية الجملة الفرعية، بينما في العربية يتقدم الفعل غالباً.',
      );
    } else {
      return const StructureAnalysisResult(
        arabicPattern: 'فِعْلٌ + فَاعِلٌ + مَفْعُولٌ بِهِ (جُمْلَةٌ فِعْلِيَّةٌ غَالِبَةٌ)',
        germanWordOrder: 'Hauptsatz: Position 2 Regel (Das konjugierte Verb steht immer an zweiter Stelle)',
        englishWordOrder: 'Main Clause: Subject + Verb + Object (Strict SVO)',
        comparativeNote: 'تلتزم الألمانية بوجود الفعل في الموقع الثاني دائماً، بينما تتيح العربية التقديم والتأخير للبلاغة.',
      );
    }
  }
}
