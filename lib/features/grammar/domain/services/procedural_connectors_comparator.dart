// Task #549: Procedural Sequential Connectors Comparator
class ProceduralSequenceEntry {
  final String arabicConnector;
  final String germanConnector;
  final String englishConnector;
  final String sequentialPhase;
  const ProceduralSequenceEntry({
    required this.arabicConnector,
    required this.germanConnector,
    required this.englishConnector,
    required this.sequentialPhase,
  });
}

class ProceduralConnectorsComparator {
  static const List<ProceduralSequenceEntry> sequenceRules = [
    ProceduralSequenceEntry(
      arabicConnector: 'بَادِئَ ذِي بَدْءٍ، نَبْسُطُ مِلَاطَ الجِيرِ المُنَقَّى عَلَى الجِدَارِ',
      germanConnector: 'Zunächst einmal tragen wir den gereinigten Kalkmörtel auf die Wand auf',
      englishConnector: 'In the first instance, we spread the purified lime plaster over the wall',
      sequentialPhase: 'Initial baseline phase in traditional masonry finish',
    ),
    ProceduralSequenceEntry(
      arabicConnector: 'فِي أَعْقَابِ ذَلِكَ، نَدْلُكُ السَّطْحَ بِالصَّابُونِ وَحَجَرِ النَّهْرِ الأَمْلَسِ',
      germanConnector: 'Infolgedessen polieren wir die Fläche mit Seife und dem glatten Flusskiesel',
      englishConnector: 'Subsequent to that, we burnish the surface with soap and the smooth river pebble',
      sequentialPhase: 'Hydrophobic burnishing phase creating breathability and water resistance',
    ),
  ];
}
