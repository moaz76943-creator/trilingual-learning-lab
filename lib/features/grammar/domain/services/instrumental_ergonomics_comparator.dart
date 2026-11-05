// Task #543: Instrumental Ergonomics and Tool Agency Comparator
class InstrumentalAgencyEntry {
  final String arabicInstrumental;
  final String germanInstrumental;
  final String englishInstrumental;
  final String ergonomicUtility;
  const InstrumentalAgencyEntry({
    required this.arabicInstrumental,
    required this.germanInstrumental,
    required this.englishInstrumental,
    required this.ergonomicUtility,
  });
}

class InstrumentalErgonomicsComparator {
  static const List<InstrumentalAgencyEntry> entries = [
    InstrumentalAgencyEntry(
      arabicInstrumental: 'بِوَاسِطَةِ دُولَابِ الخَزَفِيِّ يَتَسَنَّى تَدْوِيرُ الطِّينِ بِانْتِظَامٍ',
      germanInstrumental: 'Mittels der Töpferscheibe lässt sich der Ton gleichmäßig zentrieren',
      englishInstrumental: 'By means of the potter wheel one is enabled to center clay uniformly',
      ergonomicUtility: 'Kinetic coordination between foot pedal cadence and hand pressure',
    ),
    InstrumentalAgencyEntry(
      arabicInstrumental: 'عَبْرَ اسْتِعْمَالِ مِسْوَاةِ الخَشَبِ يَتَيَسَّرُ صَقْلُ جِدَارِ الجَرَّةِ',
      germanInstrumental: 'Anhand der Holzrippe lässt sich die Wandung des Kruges mühelos glätten',
      englishInstrumental: 'With the aid of the wooden rib smoothing the jar wall is facilitated',
      ergonomicUtility: 'Manual instrument extending finger reach for structural wall uniformity',
    ),
  ];
}
