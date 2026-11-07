// Task #651: Conditional Prerequisite and Foundational Requirement Comparator
class ConditionalPrerequisiteEntry {
  final String arabicCondition;
  final String germanCondition;
  final String englishCondition;
  final String technicalDependency;
  const ConditionalPrerequisiteEntry({
    required this.arabicCondition,
    required this.germanCondition,
    required this.englishCondition,
    required this.technicalDependency,
  });
}

class ConditionalPrerequisiteComparator {
  static const List<ConditionalPrerequisiteEntry> requirements = [
    ConditionalPrerequisiteEntry(
      arabicCondition: 'شَرِيطَةَ أَنْ يُجَفَّفَ قَشُّ البَرْدِيِّ فِي الظِّلِّ، يَكْتَسِبُ لُيُونَةً تَمْنَعُ انْكِسَارَهُ',
      germanCondition: 'Unter der Bedingung, dass das Papyrusstroh im Schatten trocknet, erlangt es bruchfeste Geschmeidigkeit',
      englishCondition: 'On condition that the papyrus reed dries in shade, it attains pliable resilience against snapping',
      technicalDependency: 'Essential prerequisite curing phase for botanical reed fiber preparation',
    ),
    ConditionalPrerequisiteEntry(
      arabicCondition: 'مَا لَمْ يُرَصَّ السَّطْحُ بِمِدَقَّةِ الخَشَبِ، لَا تَلْتَحِمُ شَرَائِحُ القِرْطَاسِ تَحْتَ المِكْبَسِ',
      germanCondition: 'Sofern die Oberfläche nicht mit dem Holzschlegel verdichtet wird, verbinden sich die Streifen nicht',
      englishCondition: 'Unless the surface is compacted with the wooden mallet, the reed strips will not bond under the press',
      technicalDependency: 'Mechanical fiber interlock dependency preceding hydraulic pressing',
    ),
  ];
}
