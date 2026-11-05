// Task #519: Ergonomic Proportion and Correlative Comparator
class ProportionEntry {
  final String arabicCorrelative;
  final String germanCorrelative;
  final String englishCorrelative;
  final String linguisticAnalysis;
  const ProportionEntry({
    required this.arabicCorrelative,
    required this.germanCorrelative,
    required this.englishCorrelative,
    required this.linguisticAnalysis,
  });
}

class ErgonomicProportionComparator {
  static const List<ProportionEntry> correlatives = [
    ProportionEntry(
      arabicCorrelative: 'كُلَّمَا خَفَّ مَحْمِلُ القُفَّةِ، سَهُلَ حَمْلُ الثِّمَارِ',
      germanCorrelative: 'Je leichter der Korb ist, desto einfacher ist das Tragen der Früchte',
      englishCorrelative: 'The lighter the basket is, the easier it is to carry the fruit',
      linguisticAnalysis: 'Proportional consequence expressing craftsmanship efficiency',
    ),
    ProportionEntry(
      arabicCorrelative: 'بِمِقْدَارِ مَا يُحْكَمُ جَدْلُ الخُوصِ، بِمِقْدَارِ مَا تَدُومُ مَتَانَتُهُ',
      germanCorrelative: 'Je fester die Palmblätter geflochten werden, umso langlebiger wird das Geflecht',
      englishCorrelative: 'In proportion as the fronds are tightly plaited, the weave endures longer',
      linguisticAnalysis: 'Quantitative correlative structure denoting manual precision',
    ),
  ];
}
