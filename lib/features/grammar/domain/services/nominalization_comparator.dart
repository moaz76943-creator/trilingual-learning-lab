class NominalizationRule {
  final String categoryTitle;
  final String arPattern;
  final String dePattern;
  final String enPattern;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const NominalizationRule({
    required this.categoryTitle,
    required this.arPattern,
    required this.dePattern,
    required this.enPattern,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class NominalizationComparator {
  static List<NominalizationRule> getRules() {
    return const [
      NominalizationRule(
        categoryTitle: 'تحويل الصفة إلى اسم مجرد محايد (Abstract Neuter Noun)',
        arPattern: 'تعريف الصفة بأل للدلالة على المعنى المطلق (الخَيْرُ، الحَقُّ، النَّافِعُ)',
        dePattern: 'das + Adjektiv großgeschrieben mit nominaler Endung (das Gute, das Wahre)',
        enPattern: 'the + adjective (the good, the true, the beautiful)',
        exampleAr: 'يَسْعَى الصَّانِعُ دَائِمًا إِلَى الخَيْرِ وَالإِتْقَانِ',
        exampleDe: 'Der Handwerker strebt stets nach dem Guten und der Vollkommenheit.',
        exampleEn: 'The artisan always strives for the good and for perfection.',
      ),
      NominalizationRule(
        categoryTitle: 'تحويل الصفة إلى اسم دال على الفاعل الموصوف (Personal Agent Noun)',
        arPattern: 'الصفة المشبهة أو اسم الفاعل المعرف (المُجْتَهِدُ، الصَّادِقُ)',
        dePattern: 'der/die/das + Adjektivstamm großgeschrieben (der Fleißige, die Geduldige)',
        enPattern: 'the + adjective plural (the diligent, the patient)',
        exampleAr: 'يَنَالُ المُجْتَهِدُ ثَمَرَةَ صَبْرِهِ',
        exampleDe: 'Der Fleißige erntet die Frucht seiner Geduld.',
        exampleEn: 'The diligent reaps the fruit of his patience.',
      ),
    ];
  }
}
