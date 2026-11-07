// Task #741: Boundary Specification and Restrictive Tolerance Comparator
class BoundarySpecificationEntry {
  final String arabicBoundary;
  final String germanBoundary;
  final String englishBoundary;
  final String joineryContext;
  const BoundarySpecificationEntry({
    required this.arabicBoundary,
    required this.germanBoundary,
    required this.englishBoundary,
    required this.joineryContext,
  });
}

class BoundarySpecificationComparator {
  static const List<BoundarySpecificationEntry> parameters = [
    BoundarySpecificationEntry(
      arabicBoundary: 'لَا يَسْتَقِيمُ تَعْشِيقُ الخَشَبِ إِلَّا بِإِسْفِينِ البَلُّوطِ دُونَ سِوَاهُ لِشِدَّةِ صَلَابَتِهِ',
      germanBoundary: 'Die Holzverzahnung hält einzig und allein mit dem Eichenkeil dank seiner außergewöhnlichen Festigkeit',
      englishBoundary: 'The timber joint holds solely and exclusively with the oak wedge by virtue of its extreme hardness',
      joineryContext: 'Exclusive reliance on durable hardwood dowels in traditional non-metallic timber framing',
    ),
    BoundarySpecificationEntry(
      arabicBoundary: 'مَا كَانَ لِلصُّنْدُوقِ أَنْ يَتَمَاسَكَ مَا خَلَا زَوَايَا التَّعْشِيقِ المَحْكَمَةِ بِالغِرَاءِ الحَيَوَانِيِّ',
      germanBoundary: 'Die Truhe fände keinen dauerhaften Halt, ausgenommen durch die mit Heißleim gefügten Eckzinken',
      englishBoundary: 'The chest would find no lasting cohesion, save through the corner dovetails bonded with animal hide glue',
      joineryContext: 'Restrictive structural integrity dependent upon animal protein adhesives in fine joinery',
    ),
  ];
}
