// Task #525: Concessive Adverbials and Diligence Comparator
class ConcessiveDiligenceEntry {
  final String arabicConcessive;
  final String germanConcessive;
  final String englishConcessive;
  final String craftsmanshipContext;
  const ConcessiveDiligenceEntry({
    required this.arabicConcessive,
    required this.germanConcessive,
    required this.englishConcessive,
    required this.craftsmanshipContext,
  });
}

class ConcessiveDiligenceComparator {
  static const List<ConcessiveDiligenceEntry> comparisons = [
    ConcessiveDiligenceEntry(
      arabicConcessive: 'رَغْمَ صَلَابَةِ حَجَرِ البَازِلْتِ، نَقَشَ الحِرَفِيُّ أَخَادِيدَ الرَّحَى بِدِقَّةٍ',
      germanConcessive: 'Ungeachtet der Härte des Basaltsteins meißelte der Handwerker die Rillen präzise',
      englishConcessive: 'Notwithstanding the hardness of the basalt stone, the artisan grooved the quern with precision',
      craftsmanshipContext: 'Persistence through challenging stone-dressing labor',
    ),
    ConcessiveDiligenceEntry(
      arabicConcessive: 'مَعَ أَنَّ التَّحْبِيلَ يَسْتَغْرِقُ سَاعَاتٍ، غَيْرَ أَنَّهُ يَضْمَنُ طَحِينًا نَقِيًّا',
      germanConcessive: 'Obwohl das Nachschärfen Stunden beansprucht, gewährleistet es dennoch reines Mehl',
      englishConcessive: 'Although redressing the stone takes hours, it nevertheless guarantees pure flour',
      craftsmanshipContext: 'Balancing time expenditure with uncompromising food quality',
    ),
  ];
}
