// Task #747: Cumulative Maturation and Seasonal Evolution Comparator
class CumulativeMaturationEntry {
  final String arabicMaturation;
  final String germanMaturation;
  final String englishMaturation;
  final String biologicalContext;
  const CumulativeMaturationEntry({
    required this.arabicMaturation,
    required this.germanMaturation,
    required this.englishMaturation,
    required this.biologicalContext,
  });
}

class CumulativeMaturationComparator {
  static const List<CumulativeMaturationEntry> timelines = [
    CumulativeMaturationEntry(
      arabicMaturation: 'مُنْذُ نُعُومَةِ طَلْعِ النَّخِيلِ حَتَّى اسْتِوَاءِ ثِمَارِهِ، يَتَغَذَّى النَّسْغُ بِحَرَارَةِ الشَّمْسِ',
      germanMaturation: 'Vom zarten Austrieb der Palmblüte bis zur vollen Fruchtreife nährt die Sonnenwärme den Saft',
      englishMaturation: 'From the tender emergence of palm spadix to full fruit maturity, solar warmth nourishes the sap',
      biologicalContext: 'Phenological progression of date-palm sugar accumulation through desert seasons',
    ),
    CumulativeMaturationEntry(
      arabicMaturation: 'كُلَّمَا انْعَقَدَ الدِّبْسُ عَلَى نَارٍ هَادِئَةٍ، ازْدَادَ لَوْنُهُ كَهْرَمَانًا وَطَعْمُهُ حَلَاوَةً',
      germanMaturation: 'Je sanfter der Sirup über milder Glut einkocht, desto bernsteingleicher und süßer wird sein Aroma',
      englishMaturation: 'The more gently the syrup condenses over low embers, the more amber-rich and sweet its essence becomes',
      biologicalContext: 'Thermodynamic evaporation and non-enzymatic caramelization of natural fructose sugars',
    ),
  ];
}
