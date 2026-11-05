// Task #537: Temporal Simultaneity and Phase Coordination Comparator
class SimultaneityEntry {
  final String arabicSimultaneity;
  final String germanSimultaneity;
  final String englishSimultaneity;
  final String grammaticalFunction;
  const SimultaneityEntry({
    required this.arabicSimultaneity,
    required this.germanSimultaneity,
    required this.englishSimultaneity,
    required this.grammaticalFunction,
  });
}

class TemporalSimultaneityComparator {
  static const List<SimultaneityEntry> coordinationRules = [
    SimultaneityEntry(
      arabicSimultaneity: 'يُطْلِقُ النَّحَّالُ دُخَانَ الأَعْشَابِ تَزَامُنًا مَعَ فَتْحِ الخَلِيَّةِ',
      germanSimultaneity: 'Der Imker bläst den Kräuterrauch zeitgleich mit dem Öffnen der Beute ein',
      englishSimultaneity: 'The beekeeper puffs herbal smoke in tandem with opening the hive',
      grammaticalFunction: 'Harmonious coordination of protective actions during apiary handling',
    ),
    SimultaneityEntry(
      arabicSimultaneity: 'بَيْنَمَا يَهْدَأُ طَنِينُ النَّحْلِ، إِذْ يَسْحَبُ القُرْصَ بِرِفْقٍ',
      germanSimultaneity: 'Während das Summen der Bienen abebbt, zieht er behutsam die Wabe hervor',
      englishSimultaneity: 'Whilst the hum of the bees subsides, he gently withdraws the honeycomb',
      grammaticalFunction: 'Temporal transition expressing calm responsive movement',
    ),
  ];
}
