// Task #627: Purposive Teleological and Intentional Craftsmanship Comparator
class PurposiveTeleologicalEntry {
  final String arabicPurpose;
  final String germanPurpose;
  final String englishPurpose;
  final String teleologicalFunction;
  const PurposiveTeleologicalEntry({
    required this.arabicPurpose,
    required this.germanPurpose,
    required this.englishPurpose,
    required this.teleologicalFunction,
  });
}

class PurposiveTeleologicalComparator {
  static const List<PurposiveTeleologicalEntry> clauses = [
    PurposiveTeleologicalEntry(
      arabicPurpose: 'نُدَعِّمُ العَتَبَةَ بِجُذُوعِ الأَرْزِ بُغْيَةَ تَحَمُّلِ ثِقَلِ السَّقْفِ الصَّخْرِيِّ',
      germanPurpose: 'Wir stützen den Sturz mit Zedernholzbohlen ab, damit er die Last der Steindecke trägt',
      englishPurpose: 'We reinforce the lintel with cedar beams in order that it sustain the stone ceiling load',
      teleologicalFunction: 'Purposive structural intention safeguarding vernacular architectural integrity',
    ),
    PurposiveTeleologicalEntry(
      arabicPurpose: 'نُنَصِّبُ مَجْرَى القَنَاةِ بِمَيَلَانٍ طَفِيفٍ لِكَيْ يَجْرِيَ المَاءُ هُوَيْنَا بِلَا انْجِرَافٍ',
      germanPurpose: 'Wir legen das Kanalbett mit sanftem Gefälle an, auf dass das Wasser ruhig und ohne Ausspülung fließt',
      englishPurpose: 'We set the channel bed with gentle gradient so that water runs placidly without soil erosion',
      teleologicalFunction: 'Hydrological teleology balancing kinetic flow with agricultural soil conservation',
    ),
  ];
}
