class DailyBreadVirtueTerm {
  final String virtueName;
  final String arabic;
  final String german;
  final String english;
  final String moralGuideline;

  const DailyBreadVirtueTerm({
    required this.virtueName,
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralGuideline,
  });
}

class DailyBreadEthicsService {
  static List<DailyBreadVirtueTerm> getTerms() {
    return const [
      DailyBreadVirtueTerm(
        virtueName: 'كسب القوت بعرق الجبين (Earning by Honest Sweat)',
        arabic: 'مَا أَكَلَ أَحَدٌ طَعَامًا قَطُّ خَيْرًا مِنْ أَنْ يَأْكُلَ مِنْ عَمَلِ يَدِهِ',
        german: 'Niemand hat je eine bessere Speise verzehrt als jene, die er durch eigener Hände Arbeit erwarb.',
        english: 'No one has ever eaten better food than that which he earned with the work of his own hands.',
        moralGuideline: 'شرف الإنسان وعزته في الاستغناء عن السؤال والاعتماد على الكد الحلال الشريف.',
      ),
      DailyBreadVirtueTerm(
        virtueName: 'بركة الرغيف الصافي (Blessing of Wholesome Bread)',
        arabic: 'البَرَكَةُ فِي الرَّغِيفِ المَصْنُوعِ بِأَمَانَةٍ وَإِخْلَاصٍ',
        german: 'Reicher Segen ruht auf dem Brot, das mit Treue und Gewissenhaftigkeit gebacken wird.',
        english: 'Abundant blessing rests upon the bread made with faithfulness and sincere devotion.',
        moralGuideline: 'طهارة الرزق تنعكس عافية في البدن وطمأنينة في الأسرة وبركة في العمر.',
      ),
    ];
  }
}
