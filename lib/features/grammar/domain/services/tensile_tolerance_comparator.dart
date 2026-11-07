// Task #765: Tensile Tolerance and Cordage Reliability Comparator
class TensileToleranceEntry {
  final String arabicTensile;
  final String germanTensile;
  final String englishTensile;
  final String mechanicalContext;
  const TensileToleranceEntry({
    required this.arabicTensile,
    required this.germanTensile,
    required this.englishTensile,
    required this.mechanicalContext,
  });
}

class TensileToleranceComparator {
  static const List<TensileToleranceEntry> thresholds = [
    TensileToleranceEntry(
      arabicTensile: 'يَتَعَيَّنُ عَلَى حَبْلِ المَسَدِ أَنْ يَحْتَمِلَ جَذْبَ السَّفِينَةِ دُونَ انْبِتَاتٍ تَحْتَ وَطْأَةِ المَدِّ',
      germanTensile: 'Das Palmfaserseil muss zwangsläufig dem Zug des Schiffes ohne Riss unter der Wucht der Flut standhalten',
      englishTensile: 'The palm-bast rope must necessarily withstand the vessel pull without snapping under the force of the tide',
      mechanicalContext: 'Tensile load threshold specification for marine mooring hawsers',
    ),
    TensileToleranceEntry(
      arabicTensile: 'لَا مَحَالَةَ أَنَّ إِحْكَامَ فَتْلِ الخُيُوطِ يُؤَمِّنُ ثَبَاتَ السَّالِكِ حِينَ ارْتِقَاءِ الجِبَالِ',
      germanTensile: 'Zweifellos verbürgt das feste Zwirnen der Stränge die Sicherheit des Wanderers beim Ersteigen der Berge',
      englishTensile: 'Undeniably the tight twisting of strands guarantees the safety of the climber ascending rocky heights',
      mechanicalContext: 'Critical safety margin in load-bearing lifeline cordage manufacture',
    ),
  ];
}
