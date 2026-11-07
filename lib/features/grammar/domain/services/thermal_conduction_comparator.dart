// Task #729: Thermal Conduction and Refractory Insulation Comparator
class ThermalConductionEntry {
  final String arabicConduction;
  final String germanConduction;
  final String englishConduction;
  final String metallurgicalContext;
  const ThermalConductionEntry({
    required this.arabicConduction,
    required this.germanConduction,
    required this.englishConduction,
    required this.metallurgicalContext,
  });
}

class ThermalConductionComparator {
  static const List<ThermalConductionEntry> properties = [
    ThermalConductionEntry(
      arabicConduction: 'تَحْتَفِظُ بُوتَقَةُ الغِرَافِيتِ بِالحَرَارَةِ الشَّدِيدَةِ دُونَ أَنْ تَتَصَدَّعَ أَمَامَ لَهَبِ الكُورِ',
      germanConduction: 'Der Graphittiegel speichert die glühende Hitze, ohne vor der lodernden Flamme der Esse zu bersten',
      englishConduction: 'The graphite crucible retains intense heat without fracturing before the blazing furnace flame',
      metallurgicalContext: 'Refractory thermal resistance during high-temperature copper and bronze smelting',
    ),
    ThermalConductionEntry(
      arabicConduction: 'كُلَّمَا زَادَتْ كَثَافَةُ الطِّينِ الحَرَارِيِّ، قَلَّ تَسَرُّبُ الدِّفْءِ إِلَى جِدَارِ الفُرْنِ الخَارِجِيِّ',
      germanConduction: 'Je dichter der feuerfeste Ton gestampft ist, desto weniger Hitze entweicht durch die Außenwand',
      englishConduction: 'The denser the refractory clay is compacted, the less heat escapes through the outer furnace wall',
      metallurgicalContext: 'Thermal barrier insulation minimizing fuel consumption and maintaining melt fluidity',
    ),
  ];
}
