// Task #837: Carrier Pigeon Navigation and Magnetic Homing Comparator
class CarrierPigeonEntry {
  final String arabicHoming;
  final String germanHoming;
  final String englishHoming;
  final String navigationalContext;
  const CarrierPigeonEntry({
    required this.arabicHoming,
    required this.germanHoming,
    required this.englishHoming,
    required this.navigationalContext,
  });
}

class CarrierPigeonComparator {
  static const List<CarrierPigeonEntry> instincts = [
    CarrierPigeonEntry(
      arabicHoming: 'يَهْتَدِي الحَمَامُ الزَّاجِلُ بِالمَجَالِ المِغْنَاطِيسِيِّ لِلأَرْضِ لِيَعُودَ إِلَى بُرْجِهِ مَهْمَا نَأَتْ بِهِ الدِّيَارُ',
      germanHoming: 'Die Brieftaube orientiert sich am Erdmagnetfeld, um zu ihrem Heimatschlag zurückzufinden, wie fern sie auch sei',
      englishHoming: 'The carrier pigeon navigates by the Earth magnetic field to return to its home loft, however distant the lands',
      navigationalContext: 'Geomagnetic perception and solar orientation in avian postal communication',
    ),
    CarrierPigeonEntry(
      arabicHoming: 'كُلَّمَا أُحْكِمَ رَبْطُ رُقْعَةِ الحَرِيرِ بِسَاقِ الطَّائِرِ، بَلَغَتِ الرِّسَالَةُ غَايَتَهَا بِلَا تَلَفٍ',
      germanHoming: 'Je sorgsamer die Seidenbotschaft am Beinchen befestigt wird, desto unversehrter erreicht der Brief sein Ziel',
      englishHoming: 'The more securely the silk scroll is tied to the bird leg, the more pristine the message reaches its destination',
      navigationalContext: 'Micro-weight scroll encapsulation safeguarding emergency state correspondence',
    ),
  ];
}
