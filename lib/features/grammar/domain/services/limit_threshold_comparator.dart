// Task #669: Limit Threshold and Tolerance Boundary Comparator
class LimitThresholdEntry {
  final String arabicThreshold;
  final String germanThreshold;
  final String englishThreshold;
  final String mechanicalContext;
  const LimitThresholdEntry({
    required this.arabicThreshold,
    required this.germanThreshold,
    required this.englishThreshold,
    required this.mechanicalContext,
  });
}

class LimitThresholdComparator {
  static const List<LimitThresholdEntry> limits = [
    LimitThresholdEntry(
      arabicThreshold: 'نَضْبِطُ تَعْشِيقَ الأَسْنَانِ فِي حُدُودِ مَا لَا يَتَجَاوَزُ فُرْجَةَ قَيْدِ شَعْرَةٍ',
      germanThreshold: 'Wir justieren den Zahneingriff im Rahmen von nicht mehr als einer Haaresbreite Spiel',
      englishThreshold: 'We calibrate tooth meshing within limits not exceeding a hairsbreadth of clearance',
      mechanicalContext: 'Precision mechanical clearance tolerance preventing gear tooth binding',
    ),
    LimitThresholdEntry(
      arabicThreshold: 'تَدُورُ النَّاعُورَةُ حَسْبَمَا تَسْمَحُ بِهِ طَاقَةُ التَّحَمُّلِ لِمِحْوَرِ البَلُّوطِ',
      germanThreshold: 'Das Wasserrad dreht sich, soweit die Belastungsgrenze der Eichenachse es zulässt',
      englishThreshold: 'The waterwheel turns as far as the load capacity of the oak shaft permits',
      mechanicalContext: 'Dynamic kinetic equilibrium under varying river stream velocities',
    ),
  ];
}
