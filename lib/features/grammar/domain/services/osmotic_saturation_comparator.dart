// Task #759: Osmotic Saturation and Botanical Leather Tanning Comparator
class OsmoticSaturationEntry {
  final String arabicSaturation;
  final String germanSaturation;
  final String englishSaturation;
  final String biochemicalDynamics;
  const OsmoticSaturationEntry({
    required this.arabicSaturation,
    required this.germanSaturation,
    required this.englishSaturation,
    required this.biochemicalDynamics,
  });
}

class OsmoticSaturationComparator {
  static const List<OsmoticSaturationEntry> dynamics = [
    OsmoticSaturationEntry(
      arabicSaturation: 'يَتَشَرَّبُ مَسَامُ الإِهَابِ عُصَارَةَ القَرَظِ شَيْئًا فَشَيْئًا حَتَّى تَلْتَحِمَ أَلْيَافُ الجِلْدِ بِمَتَانَةٍ',
      germanSaturation: 'Die Poren der Rohhaut nehmen den Akaziensud allmählich auf, bis sich die Lederfasern dauerhaft festigen',
      englishSaturation: 'The raw hide pores absorb the acacia tannin liquor little by little until the leather fibers bond with durability',
      biochemicalDynamics: 'Progressive vegetable tannin penetration transforming collagen into supple non-putrescible leather',
    ),
    OsmoticSaturationEntry(
      arabicSaturation: 'كُلَّمَا رَقَّقَ الدَّبَّاغُ لِحَاءَ السِّنْطِ فِي المَاءِ البَارِدِ، تَغَلْغَلَتِ العُفُوصَةُ بِلَا تَصَلُّبٍ فِي السَّطْحِ',
      germanSaturation: 'Je feiner der Gerber die Akazienrinde im kalten Wasser ansetzt, desto gleichmäßiger dringt der Gerbstoff ein',
      englishSaturation: 'The finer the tanner steeps acacia bark in cold water, the more evenly the astringent tannins permeate',
      biochemicalDynamics: 'Cold-steeped polyphenol dispersion preventing case-hardening during botanical pit tanning',
    ),
  ];
}
