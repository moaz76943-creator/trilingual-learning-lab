// Task #591: Concessive Contrast and Material Resilience Comparator
class ConcessiveContrastEntry {
  final String arabicContrast;
  final String germanContrast;
  final String englishContrast;
  final String structuralFunction;
  const ConcessiveContrastEntry({
    required this.arabicContrast,
    required this.germanContrast,
    required this.englishContrast,
    required this.structuralFunction,
  });
}

class ConcessiveContrastComparator {
  static const List<ConcessiveContrastEntry> comparisons = [
    ConcessiveContrastEntry(
      arabicContrast: 'مَهْمَا اشْتَدَّتْ عَوَاصِفُ الرِّمَالِ، فَإِنَّ نَسِيجَ الشَّعْرِ يَتَمَاسَكُ بِثَبَاتٍ',
      germanContrast: 'Wie heftig die Sandstürme auch toben mögen, das Ziegenhaargewebe hält standfest zusammen',
      englishContrast: 'No matter how fierce the sandstorms rage, the woven hair fabric holds steadfastly together',
      structuralFunction: 'Expressing endurance against extreme arid climatic stress',
    ),
    ConcessiveContrastEntry(
      arabicContrast: 'لَئِنْ كَانَ المَنْسَجُ الأَرْضِيُّ بَسِيطَ البِنْيَةِ، إِلَّا أَنَّهُ يُنْتِجُ أَشَدَّ الخِيَامِ مَتَانَةً',
      germanContrast: 'Wenngleich der Bodenwebrahmen einfach gebaut ist, bringt er die widerstandsfähigsten Zelte hervor',
      englishContrast: 'Albeit simple in construction, the ground loom produces the most resilient of desert shelters',
      structuralFunction: 'Contrasting humble traditional apparatus with extraordinary functional output',
    ),
  ];
}
