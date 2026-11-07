// Task #681: Voyage Completion and Safe Harbor Comparator
class VoyageCompletionEntry {
  final String arabicExpression;
  final String germanExpression;
  final String englishExpression;
  final String harborSignificance;
  const VoyageCompletionEntry({
    required this.arabicExpression,
    required this.germanExpression,
    required this.englishExpression,
    required this.harborSignificance,
  });
}

class VoyageCompletionComparator {
  static const List<VoyageCompletionEntry> benchmarks = [
    VoyageCompletionEntry(
      arabicExpression: 'حَطَّتِ السَّفِينَةُ مَرَاسِيَهَا فِي المَرْفَأِ بَعْدَ طُولِ لُجَجِ البِحَارِ',
      germanExpression: 'Das Schiff warf im sicheren Hafen Anker nach langer Fahrt durch die Wogen',
      englishExpression: 'The vessel dropped its anchors in safe harbor after enduring open ocean depths',
      harborSignificance: 'Safe anchorage attained through navigational fidelity and sound shipwright craft',
    ),
    VoyageCompletionEntry(
      arabicExpression: 'الحَمْدُ لِلَّهِ الَّذِي بَلَّغَ السَّالِكِينَ مَأْمَنَهُمْ سَالِمِينَ غَانِمِينَ',
      germanExpression: 'Lob sei dem Schöpfer, der die Reisenden wohlbehalten an ihr Ziel geleitete',
      englishExpression: 'Praise be to the Creator who guided the voyagers peacefully to their sanctuary',
      harborSignificance: 'Communal thanksgiving upon completing long maritime and desert trade routes',
    ),
  ];
}
