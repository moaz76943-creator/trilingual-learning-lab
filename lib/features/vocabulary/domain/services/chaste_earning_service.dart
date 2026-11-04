class ChasteEarningTerm {
  final String virtueName;
  final String arabic;
  final String german;
  final String english;
  final String moralGuideline;

  const ChasteEarningTerm({
    required this.virtueName,
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralGuideline,
  });
}

class ChasteEarningService {
  static List<ChasteEarningTerm> getTerms() {
    return const [
      ChasteEarningTerm(
        virtueName: 'عفة اليد ونقاء المكسب (Chaste Lawful Earning)',
        arabic: 'عِفَّةُ اليَدِ وَطَهَارَةُ المَكْسَبِ عَنِ الشُّبُهَاتِ',
        german: 'Lauterkeit der Hand und Reinheit des Erwerbs frei von jedem Zweifel.',
        english: 'Chaste integrity of the hand and purity of earning free from all doubt.',
        moralGuideline: 'البركة الحقيقية في المال القليل الحلال الصافي من كل غش.',
      ),
      ChasteEarningTerm(
        virtueName: 'حفظ العيار والأمانة (Precision and Trust in Metals)',
        arabic: 'صِدْقُ العِيَارِ وَأَدَاءُ الوَزْنِ بِالقِسْطِ العَادِلِ',
        german: 'Ehrliche Feingehaltsbestimmung und gerechte Wägung nach bestem Gewissen.',
        english: 'Truthful alloy grading and precise weight delivery with just measure.',
        moralGuideline: 'الالتزام التام بوزن الفضة دون بخس أو تلاعب يورث ثقة الخلق ورضا الخالق.',
      ),
    ];
  }
}
