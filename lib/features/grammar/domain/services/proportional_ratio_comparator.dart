// Task #639: Proportional Ratio and Material Formulation Comparator
class ProportionalRatioEntry {
  final String arabicRatio;
  final String germanRatio;
  final String englishRatio;
  final String formulationContext;
  const ProportionalRatioEntry({
    required this.arabicRatio,
    required this.germanRatio,
    required this.englishRatio,
    required this.formulationContext,
  });
}

class ProportionalRatioComparator {
  static const List<ProportionalRatioEntry> rules = [
    ProportionalRatioEntry(
      arabicRatio: 'نَخْلِطُ مِكْيَالًا مِنَ الرَّمْلِ السِّيلِيكِيِّ مُقَابِلَ ثَلَاثَةِ مَكَايِيلَ مِنَ القِلْيِ النَّبَاتِيِّ',
      germanRatio: 'Wir mischen ein Maß Quarzsand auf drei Maße Pflanzenasche',
      englishRatio: 'We mix one measure of silica sand to three measures of plant ash',
      formulationContext: 'Precise chemical proportioning for transparent blown glass batch',
    ),
    ProportionalRatioEntry(
      arabicRatio: 'بِنِسْبَةِ مَا يُضْبَطُ لَهِيبُ الفُرْنِ، تَنْصَهِرُ كُتْلَةُ الزُّجَاجِ بِلَا فُقَاعَاتٍ',
      germanRatio: 'Im Verhältnis zur Regulierung der Ofenglut schmilzt die Glasmasse blasenfrei',
      englishRatio: 'In proportion as the furnace flame is regulated, the glass melts without bubbles',
      formulationContext: 'Thermal balancing ensuring flawless optical transparency',
    ),
  ];
}
