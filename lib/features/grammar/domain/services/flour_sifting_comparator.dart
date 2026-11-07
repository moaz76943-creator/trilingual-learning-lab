// Task #849: Sieve Mesh Refinement and Particle Fractionation Comparator
class FlourSiftingEntry {
  final String arabicSifting;
  final String germanSifting;
  final String englishSifting;
  final String mechanicalDynamics;
  const FlourSiftingEntry({
    required this.arabicSifting,
    required this.germanSifting,
    required this.englishSifting,
    required this.mechanicalDynamics,
  });
}

class FlourSiftingComparator {
  static const List<FlourSiftingEntry> fractions = [
    FlourSiftingEntry(
      arabicSifting: 'يَتَصَافَى الدَّقِيقُ النَّاعِمُ قِيَاسًا عَلَى ضِيقِ فُرَجِ نَسِيجِ المُنْخُلِ لِيَخْرُجَ هَبَاءً نَقِيًّا',
      germanSifting: 'Das feine Mehl scheidet sich im Verhältnis zur Enge der Siebmaschen ab und fällt als reiner Staub herab',
      englishSifting: 'Fine flour clarifies in proportion to the narrowness of the sieve weave, descending as pure flour dust',
      mechanicalDynamics: 'Particle size classification through calibrated silk bolting cloth apertures',
    ),
    FlourSiftingEntry(
      arabicSifting: 'كُلَّمَا رُجَّ الإِطَارُ الخَشَبِيُّ بِحَرَكَةٍ دَائِرِيَّةٍ، انْفَصَلَتِ النُّخَالَةُ الخَشِنَةُ عَنِ اللُّبَابِ الأَبْيَضِ',
      germanSifting: 'Je gleichmäßiger der Holzrahmen kreisend geschüttelt wird, desto sauberer trennt sich die Kleie vom weißen Kern',
      englishSifting: 'The more steadily the wooden hoop is shaken in circular rhythm, the more cleanly coarse bran separates from the white core',
      mechanicalDynamics: 'Centrifugal stratification and gravity separation of grain bran fluffs',
    ),
  ];
}
