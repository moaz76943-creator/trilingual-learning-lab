// Task #831: Coastal Beacon Guidance and Navigational Assurance Comparator
class CoastalBeaconEntry {
  final String arabicBeacon;
  final String germanBeacon;
  final String englishBeacon;
  final String maritimeContext;
  const CoastalBeaconEntry({
    required this.arabicBeacon,
    required this.germanBeacon,
    required this.englishBeacon,
    required this.maritimeContext,
  });
}

class CoastalBeaconComparator {
  static const List<CoastalBeaconEntry> guidance = [
    CoastalBeaconEntry(
      arabicBeacon: 'يَسْتَدِلُّ الرَّبَّانُ بِضَوْءِ المَنَارَةِ لِيَتَفَادَى الشِّعَابَ المَرْجَانِيَّةَ تَحْتَ جُنْحِ الظَّلَامِ',
      germanBeacon: 'Der Kapitän orientiert sich am Leuchtfeuer, um Korallenriffe im Schutze der Dunkelheit zu meiden',
      englishBeacon: 'The captain navigates by the lighthouse beam to circumvent shallow coral reefs under cover of darkness',
      maritimeContext: 'Visual coastal alignment guiding nighttime navigational landfall',
    ),
    CoastalBeaconEntry(
      arabicBeacon: 'كُلَّمَا لَاحَ لَهِيبُ الزَّيْتِ فِي بُرْجِ المِينَاءِ، اطْمَأَنَّتْ قُلُوبُ البَحَّارَةِ إِلَى قُرْبِ المَأْمَنِ',
      germanBeacon: 'Sobald das Ölfeuer auf dem Hafenturm aufleuchtet, schöpfen die Seeleute Zuversicht auf sichere Heimkehr',
      englishBeacon: 'As the oil flame flares atop the harbor tower, sailors take heart in the near approach of safe haven',
      maritimeContext: 'Acoustic and luminous beacon signaling ensuring maritime peace of mind',
    ),
  ];
}
