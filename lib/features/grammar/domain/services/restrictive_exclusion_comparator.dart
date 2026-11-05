// Task #567: Restrictive Focusing and Essential Exclusion Comparator
class RestrictiveExclusionEntry {
  final String arabicStructure;
  final String germanStructure;
  final String englishStructure;
  final String navigationalContext;
  const RestrictiveExclusionEntry({
    required this.arabicStructure,
    required this.germanStructure,
    required this.englishStructure,
    required this.navigationalContext,
  });
}

class RestrictiveExclusionComparator {
  static const List<RestrictiveExclusionEntry> rules = [
    RestrictiveExclusionEntry(
      arabicStructure: 'لَا سَبِيلَ إِلَى مَعْرِفَةِ القِبْلَةِ لَيْلًا إِلَّا بِرَصْدِ النَّجْمِ القُطْبِيِّ',
      germanStructure: 'Es gibt keinen Weg zur nächtlichen Orientierung, es sei denn durch die Peilung des Polarsterns',
      englishStructure: 'There is no means to ascertain direction at night save through sighting the Pole Star',
      navigationalContext: 'Absolute astronomical reference point for desert route orientation',
    ),
    RestrictiveExclusionEntry(
      arabicStructure: 'إِنَّمَا يَقُومُ انْضِبَاطُ الإِسْطِرْلَابِ عَلَى دِقَّةِ تَثْقِيبِ العَنْكَبُوتِ دُونَ سِوَاهُ',
      germanStructure: 'Die Genauigkeit des Astrolabiums beruht einzig und allein auf dem präzisen Durchbruch der Rete',
      englishStructure: 'The precision of the astrolabe depends solely and exclusively upon the pierced accuracy of the rete',
      navigationalContext: 'Singular dependency on meticulous hand craftsmanship for astronomical calculation',
    ),
  ];
}
