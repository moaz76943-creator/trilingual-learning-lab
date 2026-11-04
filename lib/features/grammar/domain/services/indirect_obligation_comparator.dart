// Task #513: Trilingual Indirect Obligation Comparator
class IndirectObligationEntry {
  final String arabicExpression;
  final String germanStructure;
  final String englishStructure;
  final String contextualUsage;
  const IndirectObligationEntry({
    required this.arabicExpression,
    required this.germanStructure,
    required this.englishStructure,
    required this.contextualUsage,
  });
}

class IndirectObligationComparator {
  static const List<IndirectObligationEntry> rules = [
    IndirectObligationEntry(
      arabicExpression: 'يَجْدُرُ بِنَا أَنْ نَصْقُلَ الخَشَبَ',
      germanStructure: 'Es gilt, das Holz sorgfältig zu schleifen',
      englishStructure: 'It behoves us to polish the wood carefully',
      contextualUsage: 'Moral and vocational imperative of thorough preparation',
    ),
    IndirectObligationEntry(
      arabicExpression: 'عَلَى المَرْءِ أَنْ يَحْرِصَ عَلَى انْسِيَابِ الخُيُوطِ',
      germanStructure: 'Es ziemt sich, auf den reibungslosen Fadenlauf zu achten',
      englishStructure: 'It is incumbent upon one to ensure smooth thread flow',
      contextualUsage: 'Professional ethical duty towards the weaver',
    ),
  ];
}
