// Task #579: Clarification Flow and Expository Connectors Comparator
class ClarificationFlowEntry {
  final String arabicMarker;
  final String germanMarker;
  final String englishMarker;
  final String pedagogicalFunction;
  const ClarificationFlowEntry({
    required this.arabicMarker,
    required this.germanMarker,
    required this.englishMarker,
    required this.pedagogicalFunction,
  });
}

class ClarificationFlowComparator {
  static const List<ClarificationFlowEntry> connectors = [
    ClarificationFlowEntry(
      arabicMarker: 'وَبِعِبَارَةٍ أَوْضَحَ، لَا يَتَحَوَّلُ اللَّوْنُ إِلَى الأَزْرَقِ إِلَّا عِنْدَ مُلَامَسَةِ الهَوَاءِ',
      germanMarker: 'Mit anderen Worten verwandelt sich der Farbton erst bei Berührung mit der Luft in Azurblau',
      englishMarker: 'In other words, the hue transforms into azure only upon contact with the open air',
      pedagogicalFunction: 'Explanatory clarification of natural chemical oxidation in dyeing',
    ),
    ClarificationFlowEntry(
      arabicMarker: 'مِمَّا يَؤُولُ إِلَى تَمَاسُكِ الصِّبْغَةِ دَاخِلَ أَلْيَافِ القُطْنِ بِثَبَاتٍ',
      germanMarker: 'Was zur Folge hat, dass sich der Farbstoff dauerhaft in den Baumwollfasern festsetzt',
      englishMarker: 'Which culminates in the dye bonding steadfastly within the cotton fibers',
      pedagogicalFunction: 'Consequential outcome connector detailing material fastness',
    ),
  ];
}
