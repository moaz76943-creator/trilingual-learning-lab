// Task #861: Porous Filtration and Silt Deposition Comparator
class PorousFiltrationEntry {
  final String arabicFiltration;
  final String germanFiltration;
  final String englishFiltration;
  final String physicalPrinciple;
  const PorousFiltrationEntry({
    required this.arabicFiltration,
    required this.germanFiltration,
    required this.englishFiltration,
    required this.physicalPrinciple,
  });
}

class PorousFiltrationComparator {
  static const List<PorousFiltrationEntry> stages = [
    PorousFiltrationEntry(
      arabicFiltration: 'يَتَسَلَّلُ مَاءُ السَّيْلِ عَبْرَ حَبَّاتِ الرَّمْلِ وَالفَحْمِ لِيَنْفَصِلَ الطَّمْيُ رُوَيْدًا رُوَيْدًا عَنِ المَعِينِ الصَّافِي',
      germanFiltration: 'Das Flutwasser sickert durch Sand- und Kohleschichten, sodass sich Schlammteilchen allmählich vom reinen Quell trennen',
      englishFiltration: 'The flood runoff filters through sand and charcoal grains, so silt gradually separates from the pristine stream',
      physicalPrinciple: 'Gravity-driven deep-bed granular mechanical filtration and adsorption',
    ),
    PorousFiltrationEntry(
      arabicFiltration: 'كُلَّمَا تَكَاثَفَتْ رَقَائِقُ حَجَرِ الكِلْسِ المَسَامِيِّ، تَقَاطَرَ المَاءُ كَالزُّلَالِ دُونَ حَاجَةٍ إِلَى مَوَادَّ اصْطِنَاعِيَّةٍ',
      germanFiltration: 'Je dichter die Lagen porösen Kalksteins geschichtet sind, desto perlenreiner tropft das Wasser ohne künstliche Zusätze',
      englishFiltration: 'The denser the layers of porous limestone are stratified, the more crystal-clear water trickles without synthetic chemicals',
      physicalPrinciple: 'Microporous natural mineral membrane permeation and turbidity clarification',
    ),
  ];
}
