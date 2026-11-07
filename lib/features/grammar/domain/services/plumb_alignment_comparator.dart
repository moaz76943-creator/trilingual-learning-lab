// Task #717: Plumb Line Alignment and Gravitational Perpendicularity Comparator
class PlumbAlignmentEntry {
  final String arabicAlignment;
  final String germanAlignment;
  final String englishAlignment;
  final String architecturalContext;
  const PlumbAlignmentEntry({
    required this.arabicAlignment,
    required this.germanAlignment,
    required this.englishAlignment,
    required this.architecturalContext,
  });
}

class PlumbAlignmentComparator {
  static const List<PlumbAlignmentEntry> alignments = [
    PlumbAlignmentEntry(
      arabicAlignment: 'يَسْتَقِيمُ الجِدَارُ قِيَاسًا عَلَى خَيْطِ المِطْمَارِ دُونَ مَيَلَانٍ نَحْوَ أَيِّ جَانِبٍ',
      germanAlignment: 'Die Wand richtet sich exakt nach der Lotschnur aus, ohne Neigung nach einer Seite',
      englishAlignment: 'The wall aligns perpendicularly with the plumb line without leaning toward any side',
      architecturalContext: 'Gravitational perpendicularity verification in ashlar load-bearing masonry',
    ),
    PlumbAlignmentEntry(
      arabicAlignment: 'حَيْثُمَا اسْتَقَرَّتْ ثِقَالَةُ الرَّصَاصِ سَاكِنَةً، ثَبَتَ تَوَازِي المَدَامِيكِ الصَّخْرِيَّةِ',
      germanAlignment: 'Sobald das Bleilot regungslos ruht, steht die Parallelität der Quaderschichten fest',
      englishAlignment: 'Wheresoever the lead bob settles motionlessly, the parallelism of stone courses is verified',
      architecturalContext: 'Static equilibrium assessment ensuring uniform building load distribution',
    ),
  ];
}
