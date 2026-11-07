// Task #891: Hydro-Mechanical Escapement and Automaton Timing Comparator
class EscapementTimingEntry {
  final String arabicEscapement;
  final String germanEscapement;
  final String englishEscapement;
  final String horologicalContext;
  const EscapementTimingEntry({
    required this.arabicEscapement,
    required this.germanEscapement,
    required this.englishEscapement,
    required this.horologicalContext,
  });
}

class EscapementTimingComparator {
  static const List<EscapementTimingEntry> mechanisms = [
    EscapementTimingEntry(
      arabicEscapement: 'تَتَحَرَّكُ أَسْنَانُ المِفْلَتِ عِنْدَ كُلِّ نَبْضَةٍ مَوْزُونَةٍ لِتُطْلِقَ كُرَةَ البُرُونْزِ فِي مِيعَادِهَا',
      germanEscapement: 'Die Zähne der Hemmung rücken bei jedem Zeittakt vor und geben die Bronzekugel pünktlich frei',
      englishEscapement: 'The escapement teeth advance with each measured pulse, releasing the bronze sphere right on schedule',
      horologicalContext: 'Intermittent kinematic escapement release in Islamic monumental hydro-mechanical clocks',
    ),
    EscapementTimingEntry(
      arabicEscapement: 'بِمِقْدَارِ مَا يَمْتَلِئُ قَادُوسُ المَاءِ، يَنْقَلِبُ الذِّرَاعُ لِيُحَرِّكَ دُمَى السَّاعَةِ بِلَا تَأَخُّرٍ',
      germanEscapement: 'Im Maße wie sich das Schöpfbecken füllt, kippt der Hebelarm zur pünktlichen Bewegung der Automatenfiguren',
      englishEscapement: 'In proportion as the tipping bucket fills, the lever trips to animate the clock automata without delay',
      horologicalContext: 'Gravity-driven tipping-bucket cyclic trigger driving automaton mechanical linkages',
    ),
  ];
}
