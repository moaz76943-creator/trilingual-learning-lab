// Task #777: Passive Ventilation and Thermal Buoyancy Comparator
class PassiveVentilationEntry {
  final String arabicVentilation;
  final String germanVentilation;
  final String englishVentilation;
  final String thermodynamicPrinciple;
  const PassiveVentilationEntry({
    required this.arabicVentilation,
    required this.germanVentilation,
    required this.englishVentilation,
    required this.thermodynamicPrinciple,
  });
}

class PassiveVentilationComparator {
  static const List<PassiveVentilationEntry> aerodynamics = [
    PassiveVentilationEntry(
      arabicVentilation: 'يَنْسَابُ النَّسِيمُ العَلِيلُ هَابِطًا عَبْرَ مَلْقَفِ الهَوَاءِ كُلَّمَا ارْتَفَعَتْ حَرَارَةُ السَّطْحِ الخَارِجِيِّ',
      germanVentilation: 'Die kühle Brise strömt durch den Windturm herab, sobald die äußere Dachtemperatur ansteigt',
      englishVentilation: 'The cool breeze descends through the windcatcher shaft as the outer roof temperature rises',
      thermodynamicPrinciple: 'Thermal stack effect and negative pressure differential in passive windcatcher cooling',
    ),
    PassiveVentilationEntry(
      arabicVentilation: 'حَيْثُمَا مُرِّرَ الهَوَاءُ فَوْقَ جِرَارِ المَاءِ فِي دِهْلِيزِ البَادْجِيرِ، بَرَدَتِ الغُرَفُ بِلَا طَاقَةٍ اصْطِنَاعِيَّةٍ',
      germanVentilation: 'Wo immer der Luftstrom über feuchte Tonkrüge im Schacht streicht, kühlen die Räume ohne künstliche Energie',
      englishVentilation: 'Wheresoever the airstream passes over moist clay jars in the shaft corridor, rooms cool without artificial energy',
      thermodynamicPrinciple: 'Evaporative cooling synergy within vernacular desert windcatcher conduits',
    ),
  ];
}
