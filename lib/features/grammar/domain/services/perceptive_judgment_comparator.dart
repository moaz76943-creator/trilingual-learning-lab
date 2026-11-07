// Task #585: Perceptive Judgment and Visual Discernment Comparator
class PerceptiveJudgmentEntry {
  final String arabicPerception;
  final String germanPerception;
  final String englishPerception;
  final String discernmentContext;
  const PerceptiveJudgmentEntry({
    required this.arabicPerception,
    required this.germanPerception,
    required this.englishPerception,
    required this.discernmentContext,
  });
}

class PerceptiveJudgmentComparator {
  static const List<PerceptiveJudgmentEntry> entries = [
    PerceptiveJudgmentEntry(
      arabicPerception: 'يَسْتَبِينُ لِلنَّاظِرِ أَنَّ الوَرَقَ بَلَغَ صَفَاءَ الحَرِيرِ عَقِبَ الصَّقْلِ',
      germanPerception: 'Es erschließt sich dem Betrachter, dass das Papier nach dem Satinieren Seidenglätte erlangte',
      englishPerception: 'It becomes discernible to the observer that the paper attained silk-like smoothness after burnishing',
      discernmentContext: 'Visual and tactile evaluation of glazed rag manuscript paper',
    ),
    PerceptiveJudgmentEntry(
      arabicPerception: 'يَتَجَلَّى صِدْقُ الصَّانِعِ فِي عَدَمِ نُشُوفِ الحِبْرِ بَيْنَ أَلْيَافِ الصَّحِيفَةِ',
      germanPerception: 'Die Meisterschaft des Papiermachers manifestiert sich im rückstandsfreien Halten der Tinte',
      englishPerception: 'The craftsman mastery is manifested in the ink not feathering across the page fibers',
      discernmentContext: 'Empirical verification of flawless paper sizing and fiber bonding',
    ),
  ];
}
