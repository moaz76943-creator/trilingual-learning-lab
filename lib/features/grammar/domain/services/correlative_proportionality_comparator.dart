// Task #699: Correlative Proportionality and Geometrical Harmony Comparator
class CorrelativeProportionalityEntry {
  final String arabicCorrelative;
  final String germanCorrelative;
  final String englishCorrelative;
  final String architecturalContext;
  const CorrelativeProportionalityEntry({
    required this.arabicCorrelative,
    required this.germanCorrelative,
    required this.englishCorrelative,
    required this.architecturalContext,
  });
}

class CorrelativeProportionalityComparator {
  static const List<CorrelativeProportionalityEntry> rules = [
    CorrelativeProportionalityEntry(
      arabicCorrelative: 'كُلَّمَا اتَّسَعَ مَدَى القَوْسِ، تَطَلَّبَ رَفْعَ حَجَرِ العَقْدِ دِقَّةً أَعْلَى فِي النَّحْتِ',
      germanCorrelative: 'Je weiter der Bogen gespannt ist, desto präzisere Meißelarbeit verlangt der Schlussstein',
      englishCorrelative: 'The wider the span of the arch, the greater the precision required in dressing the keystone',
      architecturalContext: 'Masonry correlation between structural arch span and keystone wedge geometry',
    ),
    CorrelativeProportionalityEntry(
      arabicCorrelative: 'بِمِقْدَارِ مَا يُحْكَمُ رَصُّ المِدْمَاكِ، بِمِقْدَارِ مَا تَثْبُتُ القِنْطَرَةُ فِي وَجْهِ السُّيُولِ',
      germanCorrelative: 'In dem Maße, wie die Steinlage gefestigt wird, widersteht die Brücke den Fluten',
      englishCorrelative: 'In proportion as the stone course is firmly bonded, the viaduct endures against torrential floods',
      architecturalContext: 'Direct causal proportionality between ashlar joint bonding and hydraulic bridge resilience',
    ),
  ];
}
