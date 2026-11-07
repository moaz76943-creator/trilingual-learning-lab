// Task #597: Spatial Orientation and Landmark Guidance Comparator
class SpatialOrientationEntry {
  final String arabicSpatial;
  final String germanSpatial;
  final String englishSpatial;
  final String navigationalScope;
  const SpatialOrientationEntry({
    required this.arabicSpatial,
    required this.germanSpatial,
    required this.englishSpatial,
    required this.navigationalScope,
  });
}

class SpatialOrientationComparator {
  static const List<SpatialOrientationEntry> landmarks = [
    SpatialOrientationEntry(
      arabicSpatial: 'تَقُومُ الصُّوَّةُ قُبَالَةَ ثَنِيَّةِ الجَبَلِ لِتَدُلَّ عَلَى مَمَرِّ القَافِلَةِ',
      germanSpatial: 'Das Steinmännchen steht vis-à-vis des Bergpasses, um den Karawanenpfad anzuzeigen',
      englishSpatial: 'The stone cairn stands facing the mountain pass to mark the caravan trail',
      navigationalScope: 'Topographical alignment with high-visibility geographic features',
    ),
    SpatialOrientationEntry(
      arabicSpatial: 'حَيْثُمَا يَنْحَدِرُ مَسِيلُ الوَادِي، نَبْنِي رُجُومًا حَجَرِيَّةً لَا تَطْمِسُهَا الرِّيَاحُ',
      germanSpatial: 'Wo immer das Flussbett abfällt, schichten wir Steinmale auf, die der Wind nicht verweht',
      englishSpatial: 'Wheresoever the wadi channel slopes, we erect stone cairns that the wind cannot erase',
      navigationalScope: 'Hydrological and elevation-based desert trail marking',
    ),
  ];
}
