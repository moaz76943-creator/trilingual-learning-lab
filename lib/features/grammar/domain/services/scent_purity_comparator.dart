// Task #705: Scent Purity and Olfactory Discernment Comparator
class ScentPurityEntry {
  final String arabicScent;
  final String germanScent;
  final String englishScent;
  final String aromaticEvaluation;
  const ScentPurityEntry({
    required this.arabicScent,
    required this.germanScent,
    required this.englishScent,
    required this.aromaticEvaluation,
  });
}

class ScentPurityComparator {
  static const List<ScentPurityEntry> evaluations = [
    ScentPurityEntry(
      arabicScent: 'يَسْتَدِلُّ العَطَّارُ بِعُذُوبَةِ الشَّذَا عَلَى خُلُوِّ مَاءِ الوَرْدِ مِنْ كُلِّ شَائِبَةٍ',
      germanScent: 'Der Parfümeur schließt aus der Lieblichkeit des Duftes auf die vollkommene Reinheit des Rosenwassers',
      englishScent: 'The perfumer deduces from the sweetness of the aroma that the rosewater is devoid of any impurity',
      aromaticEvaluation: 'Sensory olfactory deduction verifying unadulterated botanical distillation',
    ),
    ScentPurityEntry(
      arabicScent: 'مَا مِنْ رَيْبٍ فِي أَنَّ تَعْتِيقَ دُهْنِ العُودِ فِي قَوَارِيرِ الفَخَّارِ يُكْسِبُهُ عُمْقًا زَكِيًّا',
      germanScent: 'Es besteht kein Zweifel, dass die Reifung des Adlerholzöls in Tonflakons ihm edle Tiefe verleiht',
      englishScent: 'There is no doubt that curing agarwood essence within ceramic phials imparts rich aromatic depth',
      aromaticEvaluation: 'Empirical certainty regarding traditional porous vessel curing of resinous essences',
    ),
  ];
}
