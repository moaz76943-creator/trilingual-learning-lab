// Task #897: Cobalt Blue Pigmentation and High-Fire Vitrification Comparator
class CobaltPigmentationEntry {
  final String arabicPigmentation;
  final String germanPigmentation;
  final String englishPigmentation;
  final String chemicalPrinciple;
  const CobaltPigmentationEntry({
    required this.arabicPigmentation,
    required this.germanPigmentation,
    required this.englishPigmentation,
    required this.chemicalPrinciple,
  });
}

class CobaltPigmentationComparator {
  static const List<CobaltPigmentationEntry> colorations = [
    CobaltPigmentationEntry(
      arabicPigmentation: 'يَتَغَلْغَلُ أَزْرَقُ الكُوبَالْتِ فِي لُبِّ الطِّلَاءِ الزُّجَاجِيِّ لِيُعْطِيَ زُرْقَةً لَازَوَرْدِيَّةً لَا تَبْهَتُ عَلَى مَرِّ الدُّهُورِ',
      germanPigmentation: 'Das Kobaltblau dringt tief in die Glasur ein und verleiht ihr ein lapisblaues Leuchten, das nie verblasst',
      englishPigmentation: 'Cobalt blue permeates deep into the glaze matrix, bestowing an azure radiance that never fades over centuries',
      chemicalPrinciple: 'High-temperature aluminosilicate dissolution creating stable tetrahedral cobalt blue complexes',
    ),
    CobaltPigmentationEntry(
      arabicPigmentation: 'كُلَّمَا دَقَّ الخَزَّافُ رَسْمَ الأَزْهَارِ بِمَاءِ الكُوبَالْتِ، ارْتَسَمَتِ الزَّخَارِفُ حَادَّةً تَحْتَ قِشْرَةِ الزُّجَاجِ الشَّفَّافَةِ',
      germanPigmentation: 'Je feiner der Töpfer die Blüten mit Kobaltsud zieht, desto schärfer stehen die Muster unter der Transparentglasur',
      englishPigmentation: 'The more delicately the potter paints blossoms with cobalt liquor, the sharper the patterns stand beneath the clear glaze',
      chemicalPrinciple: 'Underglaze pigment retention without thermal bleeding during high-fire alkaline maturation',
    ),
  ];
}
