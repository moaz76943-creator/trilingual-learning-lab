// Task #771: Hydraulic Head and Atmospheric Pressure Comparator
class HydraulicHeadEntry {
  final String arabicHydraulic;
  final String germanHydraulic;
  final String englishHydraulic;
  final String physicalPrinciple;
  const HydraulicHeadEntry({
    required this.arabicHydraulic,
    required this.germanHydraulic,
    required this.englishHydraulic,
    required this.physicalPrinciple,
  });
}

class HydraulicHeadComparator {
  static const List<HydraulicHeadEntry> principles = [
    HydraulicHeadEntry(
      arabicHydraulic: 'يَنْبَجِسُ مَاءُ الفَوَّارَةِ عَالِيًا بِمِقْدَارِ ارْتِفَاعِ خَزَّانِ التَّغْذِيَةِ فَوْقَ مُسْتَوَى الحَوْضِ',
      germanHydraulic: 'Das Wasser der Fontäne schießt umso höher empor, je höher der Speichertank über dem Becken liegt',
      englishHydraulic: 'The fountain water jets upward in proportion to the elevation of the header tank above the basin',
      physicalPrinciple: 'Hydrostatic pressure head conversion into vertical kinetic jet velocity',
    ),
    HydraulicHeadEntry(
      arabicHydraulic: 'حَيْثُمَا ضَاقَتْ فُوَّهَةُ النُّحَاسِ المَصْبُوبِ، اشْتَدَّ دَفْقُ المَاءِ الرَّقْرَاقِ دُونَ حَاجَةٍ إِلَى مُضَخَّةٍ',
      germanHydraulic: 'Wo immer sich die gegossene Kupferdüse verengt, verstärkt sich der Wasserstrahl ganz ohne Pumpe',
      englishHydraulic: 'Wheresoever the cast copper nozzle constricts, the water jet accelerates without need for a mechanical pump',
      physicalPrinciple: 'Continuity equation and hydrodynamic nozzle constriction in gravity fountains',
    ),
  ];
}
