// Task #801: Rotational Equilibrium and Kinetic Momentum Comparator
class RotationalEquilibriumEntry {
  final String arabicEquilibrium;
  final String germanEquilibrium;
  final String englishEquilibrium;
  final String kinematicPrinciple;
  const RotationalEquilibriumEntry({
    required this.arabicEquilibrium,
    required this.germanEquilibrium,
    required this.englishEquilibrium,
    required this.kinematicPrinciple,
  });
}

class RotationalEquilibriumComparator {
  static const List<RotationalEquilibriumEntry> dynamics = [
    RotationalEquilibriumEntry(
      arabicEquilibrium: 'يَسْتَمِرُّ دَوَرَانُ دُولَابِ الخَزَفِيِّ بِفِعْلِ عَزْمِ القُصُورِ الذَّاتِيِّ لِحَجَرِ القَاعِدَةِ الثَّقِيلِ',
      germanEquilibrium: 'Die Töpferscheibe dreht sich dank des Trägheitsmoments des schweren Grundsteins gleichmäßig weiter',
      englishEquilibrium: 'The potter kick-wheel continues turning smoothly by virtue of the rotational inertia of its heavy flystone',
      kinematicPrinciple: 'Conservation of angular momentum enabling continuous hand shaping without jerky interruptions',
    ),
    RotationalEquilibriumEntry(
      arabicEquilibrium: 'حَيْثُمَا ضَبَطَ الخَزَّافُ مَرْكَزَ الطِّينِ، اسْتَقَرَّتِ الآنِيَةُ دُونَ تَرَنُّحٍ عِنْدَ ارْتِفَاعِ جِدَارِهَا',
      germanEquilibrium: 'Sobald der Töpfer den Ton zentriert hat, wächst das Gefäß ohne Taumeln empor',
      englishEquilibrium: 'Wheresoever the potter centers the clay lump, the vessel rises steadily without wobbling as walls ascend',
      kinematicPrinciple: 'Dynamic rotational centering preventing structural eccentric wall collapse',
    ),
  ];
}
