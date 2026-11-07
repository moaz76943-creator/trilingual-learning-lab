// Task #903: Thermal Invariance and Gridiron Pendulum Compensation Comparator
class PendulumInvarianceEntry {
  final String arabicInvariance;
  final String germanInvariance;
  final String englishInvariance;
  final String horologicalLaw;
  const PendulumInvarianceEntry({
    required this.arabicInvariance,
    required this.germanInvariance,
    required this.englishInvariance,
    required this.horologicalLaw,
  });
}

class PendulumInvarianceComparator {
  static const List<PendulumInvarianceEntry> laws = [
    PendulumInvarianceEntry(
      arabicInvariance: 'يَتَعَادَلُ تَمَدُّدُ قُضْبَانِ النُّحَاسِ مَعَ تَمَدُّدِ قُضْبَانِ الفُولَاذِ لِيَبْقَى مَرْكَزُ ثِقَلِ الرَّقَّاصِ ثَابِتًا مَهْمَا تَغَيَّرَ حَرُّ الصَّيْفِ',
      germanInvariance: 'Die Ausdehnung der Messingstäbe gleicht die der Stahlstäbe aus, sodass der Schwerpunkt des Pendels im Sommer stabil bleibt',
      englishInvariance: 'The thermal expansion of brass rods offsets that of steel rods so the pendulum center of gravity remains invariant in summer heat',
      horologicalLaw: 'Differential thermal expansion compensation in gridiron clock pendulums preserving constant isochronous period',
    ),
    PendulumInvarianceEntry(
      arabicInvariance: 'كُلَّمَا اسْتَقَرَّ طُولُ نَوَّاسِ السَّاعَةِ دُونَ تَأَثُّرٍ بِالبُرُودَةِ، دَقَّتِ الثَّوَانِي بِانْتِظَامٍ فَلَكِيٍّ مُحْكَمٍ',
      germanInvariance: 'Je temperaturstabiler die wirksame Pendellänge bei Kälte bleibt, desto astronomisch präziser ticken die Sekunden',
      englishInvariance: 'The more stable the effective pendulum length remains under winter cold, the more astronomically precise the seconds tick',
      horologicalLaw: 'Isochronism invariance ensuring uninterrupted precision in astronomical observatory regulators',
    ),
  ];
}
