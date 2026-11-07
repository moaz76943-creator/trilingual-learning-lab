// Task #711: Tensile Equilibrium and Load Balancing Comparator
class TensileEquilibriumEntry {
  final String arabicEquilibrium;
  final String germanEquilibrium;
  final String englishEquilibrium;
  final String physicalDynamics;
  const TensileEquilibriumEntry({
    required this.arabicEquilibrium,
    required this.germanEquilibrium,
    required this.englishEquilibrium,
    required this.physicalDynamics,
  });
}

class TensileEquilibriumComparator {
  static const List<TensileEquilibriumEntry> balances = [
    TensileEquilibriumEntry(
      arabicEquilibrium: 'يَتَمَاسَكُ الصُّوفُ المَلْبُودُ مُوَازَاةً بَيْنَ ضَغْطِ الأَيْدِي وَحَرَارَةِ المَاءِ الصَّابُونِيِّ',
      germanEquilibrium: 'Der gewalkte Filz bindet im Gleichgewicht zwischen Handdruck und Hitze der Seifenlauge',
      englishEquilibrium: 'The felted wool bonds in equilibrium between hand pressure and the heat of the soapy water',
      physicalDynamics: 'Thermodynamic and kinetic balance during non-woven fiber entanglement',
    ),
    TensileEquilibriumEntry(
      arabicEquilibrium: 'تَتَشَابَكُ الأَلْيَافُ بِمَا يُعَادِلُ شَدَّ النَّسِيجِ المَحْبُوكِ دُونَ الحَاجَةِ إِلَى غَزْلٍ',
      germanEquilibrium: 'Die Fasern verflechten sich entsprechend der Festigkeit gewebter Stoffe ganz ohne Spinnen',
      englishEquilibrium: 'The fibers interlock in proportion to the strength of woven cloth without need for spinning',
      physicalDynamics: 'Friction-driven mechanical cohesion forming dense waterproof felt barriers',
    ),
  ];
}
