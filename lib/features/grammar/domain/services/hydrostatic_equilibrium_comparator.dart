// Task #783: Hydrostatic Equilibrium and Inverted Siphon Comparator
class HydrostaticEquilibriumEntry {
  final String arabicEquilibrium;
  final String germanEquilibrium;
  final String englishEquilibrium;
  final String hydraulicPrinciple;
  const HydrostaticEquilibriumEntry({
    required this.arabicEquilibrium,
    required this.germanEquilibrium,
    required this.englishEquilibrium,
    required this.hydraulicPrinciple,
  });
}

class HydrostaticEquilibriumComparator {
  static const List<HydrostaticEquilibriumEntry> equations = [
    HydrostaticEquilibriumEntry(
      arabicEquilibrium: 'يَرْتَفِعُ المَاءُ فِي الطَّرَفِ الآخَرِ لِلقَنَاةِ مُوَازِيًا ارْتِفَاعَ مَنْبَعِهِ فِي الجَانِبِ المُقَابِلِ',
      germanEquilibrium: 'Das Wasser steigt am jenseitigen Ende des Dükers exakt auf die Höhe seiner Quelle am Gegenhang empor',
      englishEquilibrium: 'Water rises at the far end of the inverted siphon in equilibrium with its source height on the opposing slope',
      hydraulicPrinciple: 'Communicating vessels hydrostatic balance across deep valley depressions',
    ),
    HydrostaticEquilibriumEntry(
      arabicEquilibrium: 'مَتَى أُحْكِمَ لِحَامُ قَنَاطِرِ الرَّصَاصِ، تَمَّ عُبُورُ السَّيْلِ دُونَ حَاجَةٍ إِلَى رَفْعِ جُسُورٍ شَاهِقَةٍ',
      germanEquilibrium: 'Sobald die Nähte der Bleirohre gedichtet sind, quert die Wasserader das Tal ohne meterhohe Brückenbögen',
      englishEquilibrium: 'Once the soldered seams of lead conduits are sealed tight, the stream traverses the gorge without soaring aqueduct arches',
      hydraulicPrinciple: 'Closed pressurized hydraulic transit under continuous fluid momentum',
    ),
  ];
}
