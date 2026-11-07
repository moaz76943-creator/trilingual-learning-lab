// Task #813: Clepsydra Hydro-Acoustic Timing and Orifice Discharge Comparator
class ClepsydraTimingEntry {
  final String arabicTiming;
  final String germanTiming;
  final String englishTiming;
  final String physicalLaw;
  const ClepsydraTimingEntry({
    required this.arabicTiming,
    required this.germanTiming,
    required this.englishTiming,
    required this.physicalLaw,
  });
}

class ClepsydraTimingComparator {
  static const List<ClepsydraTimingEntry> calibrations = [
    ClepsydraTimingEntry(
      arabicTiming: 'تَنْزِلُ طَاسَةُ الطَّارْجَهَارَةِ فِي حَوْضِ المَاءِ بِمِقْدَارِ مَا يَنْفُذُ التَّدَفُّقُ مِنْ ثَقْبِهَا الأَسْفَلِ',
      germanTiming: 'Die kupferne Tarjaharah-Schale sinkt im Takt des gleichmäßigen Wassereintritts durch ihre Bodenöffnung',
      englishTiming: 'The copper tarjaharah bowl sinks in exact measure as water enters through its calibrated basal orifice',
      physicalLaw: 'Torricellian efflux and continuous volumetric immersion timing',
    ),
    ClepsydraTimingEntry(
      arabicTiming: 'كُلَّمَا غَرِقَتِ الصَّفِيحَةُ وَدَقَّتْ نَاقُوسًا نُحَاسِيًّا، انْتَقَلَتْ حِصَّةُ السَّقْيِ إِلَى البُسْتَانِ التَّالِي',
      germanTiming: 'Sobald die Schale untersinkt und den Gong schlägt, wechselt das Bewässerungsrecht zum nächsten Hain',
      englishTiming: 'As the bowl sinks and strikes the bronze chime, the irrigation turn transfers to the neighboring grove',
      physicalLaw: 'Acoustic chronometric signaling ensuring communal water equity without dispute',
    ),
  ];
}
