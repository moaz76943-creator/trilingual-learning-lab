// Task #879: Optical Dispersion and Prism Refraction Comparator
class PrismRefractionEntry {
  final String arabicRefraction;
  final String germanRefraction;
  final String englishRefraction;
  final String opticalPrinciple;
  const PrismRefractionEntry({
    required this.arabicRefraction,
    required this.germanRefraction,
    required this.englishRefraction,
    required this.opticalPrinciple,
  });
}

class PrismRefractionComparator {
  static const List<PrismRefractionEntry> phenomena = [
    PrismRefractionEntry(
      arabicRefraction: 'يَنْفَلِقُ شُعَاعُ الضَّوْءِ الأَبْيَضِ عَبْرَ زَوَايَا المَوْشُورِ البِلَّوْرِيِّ لِيَتَبَدَّى طَيْفُ الأَلْوَانِ السَّبْعَةِ نَقِيًّا',
      germanRefraction: 'Der weiße Lichtstrahl bricht sich an den Kanten des Kristallprismas und fächert sich in das reine Siebenfarbenspektrum auf',
      englishRefraction: 'The white ray of light refracts through the angles of the crystal prism, unfolding into the pure seven-color spectrum',
      opticalPrinciple: 'Wavelength-dependent refractive dispersion through homogeneous transparent crystalline media',
    ),
    PrismRefractionEntry(
      arabicRefraction: 'كُلَّمَا أُحْكِمَ صَقْلُ أَوْجُهِ الزُّجَاجِ الثَّلَاثَةِ، خَرَجَتْ حُزَمُ الأَلْوَانِ حَادَّةَ الحَوَافِّ بِلَا كَدَرٍ',
      germanRefraction: 'Je makelloser die drei Prismenflächen poliert sind, desto schärfer und klarer treten die Farbbänder hervor',
      englishRefraction: 'The more flawlessly the three prism faces are polished, the sharper and clearer the color bands emerge',
      opticalPrinciple: 'Micro-surface planar polish eliminating scattering distortion at refractive optical interfaces',
    ),
  ];
}
