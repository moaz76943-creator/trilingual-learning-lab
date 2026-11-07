// Task #573: Optative Desideratives and Traditional Well-Wishing Comparator
class OptativeDesiderativeEntry {
  final String arabicOptative;
  final String germanOptative;
  final String englishOptative;
  final String situationalEtiquette;
  const OptativeDesiderativeEntry({
    required this.arabicOptative,
    required this.germanOptative,
    required this.englishOptative,
    required this.situationalEtiquette,
  });
}

class OptativeWishingComparator {
  static const List<OptativeDesiderativeEntry> entries = [
    OptativeDesiderativeEntry(
      arabicOptative: 'عَسَى أَنْ يَكُونَ مَسِيرُ القَافِلَةِ مَيْمُونًا آمِنًا',
      germanOptative: 'Möge der Karawane eine gesegnete und sichere Reise beschieden sein',
      englishOptative: 'May the caravan journey be auspicious and safeguarded',
      situationalEtiquette: 'Auspicious benediction offered upon caravan departure',
    ),
    OptativeDesiderativeEntry(
      arabicOptative: 'بُورِكَ لِمَنْ صَانَ وَدَائِعَ العِلْمِ فِي هَذَا الصُّنْدُوقِ',
      germanOptative: 'Gesegnet sei, wer die Schätze des Wissens in dieser Truhe bewahrt',
      englishOptative: 'Blessed be the one who preserves the treasures of knowledge within this chest',
      situationalEtiquette: 'Honorific dedication inscribed upon scholarly travel chests',
    ),
  ];
}
