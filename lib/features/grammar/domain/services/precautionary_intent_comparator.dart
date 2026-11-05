// Task #555: Precautionary Intent and Deliberative Grammar Comparator
class PrecautionaryGrammarEntry {
  final String arabicStructure;
  final String germanStructure;
  final String englishStructure;
  final String intentContext;
  const PrecautionaryGrammarEntry({
    required this.arabicStructure,
    required this.germanStructure,
    required this.englishStructure,
    required this.intentContext,
  });
}

class PrecautionaryIntentComparator {
  static const List<PrecautionaryGrammarEntry> clauses = [
    PrecautionaryGrammarEntry(
      arabicStructure: 'نَقُطُّ رَأْسَ القَلَمِ بِمَهَلٍ خَشْيَةَ أَنْ يَنْشَقَّ القَصَبُ جَوْرًا',
      germanStructure: 'Wir schneiden die Rohrfeder behutsam zu, aus Sorge, dass das Schilf ungleichmäßig splittert',
      englishStructure: 'We slit the reed pen tip patiently, lest the reed split unevenly',
      intentContext: 'Careful prevention of irreparable damage to fine natural materials',
    ),
    PrecautionaryGrammarEntry(
      arabicStructure: 'نَغْمِسُ الرِّيشَةَ فِي الصُّوفِ حِيطَةً لِئَلَّا يَسِيلَ الحِبْرُ عَلَى الطِّرَاسِ',
      germanStructure: 'Wir tauchen die Feder vorsorglich in die Seidenwatte, damit keine Tinte auf das Blatt tropft',
      englishStructure: 'We dip the pen into the ink silk wad as a precaution against ink dripping on the sheet',
      intentContext: 'Preventative measure ensuring calligraphic cleanliness',
    ),
  ];
}
