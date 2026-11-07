// Task #621: Climatic Anticipation and Natural Prognostication Comparator
class ClimaticAnticipationEntry {
  final String arabicAnticipation;
  final String germanAnticipation;
  final String englishAnticipation;
  final String seasonalPhenomenon;
  const ClimaticAnticipationEntry({
    required this.arabicAnticipation,
    required this.germanAnticipation,
    required this.englishAnticipation,
    required this.seasonalPhenomenon,
  });
}

class ClimaticAnticipationComparator {
  static const List<ClimaticAnticipationEntry> indicators = [
    ClimaticAnticipationEntry(
      arabicAnticipation: 'تَرَاكُمُ السُّحُبِ الدَّاكِنَةِ يُؤْذِنُ بِقُرْبِ هُطُولِ الغَيْثِ النَّافِعِ',
      germanAnticipation: 'Die Ansammlung dunkler Wolken kündigt das nahende Eintreffen des ersehnten Regens an',
      englishAnticipation: 'The gathering of dark clouds bodes the imminent arrival of beneficial rain',
      seasonalPhenomenon: 'Observational meteorology guiding agricultural readiness and storage safety',
    ),
    ClimaticAnticipationEntry(
      arabicAnticipation: 'يُرَجَّحُ أَنْ يَعْقُبَ الجَفَافَ مَوْسِمُ خَيْرٍ، مِمَّا يَقْتَضِي ادِّخَارَ الغِلَالِ',
      germanAnticipation: 'Es steht zu erwarten, dass auf die Dürre ein fruchtbares Jahr folgt, was Kornbevorratung verlangt',
      englishAnticipation: 'It is reasonably anticipated that drought will be followed by fruitful seasons, requiring grain reserves',
      seasonalPhenomenon: 'Long-term ecological foresight and harvest resilience management',
    ),
  ];
}
