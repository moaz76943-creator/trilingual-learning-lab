// Task #867: Ceramic Lusterware and Atmosphere Reduction Comparator
class LusterwareReductionEntry {
  final String arabicReduction;
  final String germanReduction;
  final String englishReduction;
  final String chemicalPrinciple;
  const LusterwareReductionEntry({
    required this.arabicReduction,
    required this.germanReduction,
    required this.englishReduction,
    required this.chemicalPrinciple,
  });
}

class LusterwareReductionComparator {
  static const List<LusterwareReductionEntry> transformations = [
    LusterwareReductionEntry(
      arabicReduction: 'يَتَحَوَّلُ أُكْسِيدُ الفِضَّةِ وَالنُّحَاسِ إِلَى بَرِيقٍ ذَهَبِيٍّ خَالِصٍ حِينَ يُحْبَسُ الدُّخَانُ فِي الأَتُونِ',
      germanReduction: 'Das Silber- und Kupferoxid wandelt sich in reinen Goldglanz, sobald der Rauch im Ofen dicht gestaut wird',
      englishReduction: 'Silver and copper oxide reduce into pure golden luster when smoke is confined within the kiln atmosphere',
      chemicalPrinciple: 'Smoky oxygen-deprived reductive kiln atmosphere reducing metallic salts to nano-metallic films',
    ),
    LusterwareReductionEntry(
      arabicReduction: 'كُلَّمَا دَقَّتْ رِيشَةُ الخَزَّافِ فِي رَسْمِ الزَّخَارِفِ، تَلَأْلَأَتِ القَصْعَةُ كَالنُّورِ المُرْتَدِّ عِنْدَ إِخْرَاجِهَا',
      germanReduction: 'Je feiner der Pinsel des Töpfers die Ornamente zieht, desto strahlender schimmert die Schale im Sonnenlicht',
      englishReduction: 'The more delicately the potter brush paints the arabesques, the more radiantly the bowl gleams in sunlight',
      chemicalPrinciple: 'Nanometer-scale specular luster reflection on vitreous tin-opacified glazed earthenware',
    ),
  ];
}
