// Task #807: Hydraulic Gradient and Subterranean Flow Comparator
class HydraulicGradientEntry {
  final String arabicGradient;
  final String germanGradient;
  final String englishGradient;
  final String hydrologicalContext;
  const HydraulicGradientEntry({
    required this.arabicGradient,
    required this.germanGradient,
    required this.englishGradient,
    required this.hydrologicalContext,
  });
}

class HydraulicGradientComparator {
  static const List<HydraulicGradientEntry> channels = [
    HydraulicGradientEntry(
      arabicGradient: 'بِنِسْبَةِ انْحِدَارِ مَسَارِ القَنَاةِ الجَوْفِيَّةِ، يَنْسَابُ المَاءُ العَذْبُ دُونَ انْجِرَافٍ فِي التُّرْبَةِ',
      germanGradient: 'Im Verhältnis zum Gefälle des unterirdischen Qanat-Stollens fließt das Quellwasser ohne Bodenerosion',
      englishGradient: 'In proportion to the gradient of the subterranean qanat gallery, sweet water flows without soil erosion',
      hydrologicalContext: 'Precision gradient leveling in gravity-fed subterranean aflaj channels',
    ),
    HydraulicGradientEntry(
      arabicGradient: 'كُلَّمَا رَقَّقْنَا قَاعَ الفَلَجِ بِالمِلَاطِ الصَّلْدِ، قَلَّ تَسَرُّبُ المِيَاهِ عَبْرَ الصُّخُورِ المَسَامِيَّةِ',
      germanGradient: 'Je glatter die Sohle des Aflaj-Kanals mit wasserfestem Mörtel verkleidet wird, desto weniger Sickerverlust entsteht',
      englishGradient: 'The smoother the bed of the aflaj channel is lined with impervious plaster, the less seepage occurs through porous rock',
      hydrologicalContext: 'Hydrodynamic efficiency and seepage minimization in arid irrigation conduits',
    ),
  ];
}
