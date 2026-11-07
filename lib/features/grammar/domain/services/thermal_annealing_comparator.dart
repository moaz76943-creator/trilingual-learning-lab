// Task #753: Thermal Annealing and Stress Relief Comparator
class ThermalAnnealingEntry {
  final String arabicAnnealing;
  final String germanAnnealing;
  final String englishAnnealing;
  final String metallurgicalDynamics;
  const ThermalAnnealingEntry({
    required this.arabicAnnealing,
    required this.germanAnnealing,
    required this.englishAnnealing,
    required this.metallurgicalDynamics,
  });
}

class ThermalAnnealingComparator {
  static const List<ThermalAnnealingEntry> processes = [
    ThermalAnnealingEntry(
      arabicAnnealing: 'تَلِينُ صَفِيحَةُ النُّحَاسِ تَدْرِيجًا مَعَ بُرُودَةِ المَعْدِنِ رَيْثَمَا تَسْتَقِرَّ بِنْيَتُهُ الدَّاخِلِيَّةُ',
      germanAnnealing: 'Das Kupferblech erweicht stufenweise beim Erkalten, während sich sein inneres Gefüge beruhigt',
      englishAnnealing: 'The copper plate softens gradually as the metal cools, whilst its internal grain structure settles',
      metallurgicalDynamics: 'Thermal recrystallization relieving work-hardening lattice strain in hammered copper',
    ),
    ThermalAnnealingEntry(
      arabicAnnealing: 'نُحَمِّرُ جَوْفَ القِدْرِ عَلَى الجَمْرِ تَفَادِيًا لِتَقَصُّفِ الجِدَارِ تَحْتَ ضَرَبَاتِ المِطْرَقَةِ',
      germanAnnealing: 'Wir glühen den Topfboden über der Glut aus, um das Brechen der Wandung unter Hammerschlägen abzuwenden',
      englishAnnealing: 'We anneal the cauldron base over embers to forestall wall fracture beneath planishing hammer blows',
      metallurgicalDynamics: 'Preventive thermal softening enabling seamless cold-hammering and deep bowl raising',
    ),
  ];
}
