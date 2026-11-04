class RestrictionRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const RestrictionRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class ExclusiveRestrictionComparator {
  static List<RestrictionRuleGuide> getRules() {
    return const [
      RestrictionRuleGuide(
        categoryTitle: 'الاستثناء التام بغير وسوى (Genitive Exception: غير / سوى)',
        arConstruction: 'غَيْرُ / سِوَى (تأخذ إعراب المستثنى بإلا وما بعدها مضاف إليه مجرور)',
        deConstruction: 'Präposition "außer" (+ Dativ) / "ausgenommen" (+ Akkusativ)',
        enConstruction: 'Except / other than / apart from + noun phrase',
        exampleAr: 'لَا يَسْتَخْدِمُ الصَّانِعُ سِوَى حُبُوبِ السِّمْسِمِ البَلَدِيِّ النَّقِيِّ',
        exampleDe: 'Der Müller verwendet außer reinem Sesamsamen nichts.',
        exampleEn: 'The miller uses nothing other than pure local sesame seeds.',
      ),
      RestrictionRuleGuide(
        categoryTitle: 'الاستدراك المقيد في جملة تابعة (Subordinate Restriction: غير أن / außer dass)',
        arConstruction: 'غَيْرَ أَنَّ / بَيْدَ أَنَّ + الجُمْلَةُ الِاسْمِيَّةُ أَوِ الفِعْلِيَّةُ',
        deConstruction: 'Subjunktion "außer dass" (Nebensatz: Verb zwingend am Ende)',
        enConstruction: 'Except that / save that + clause',
        exampleAr: 'العَصْرُ بَارِدٌ بَطِيءٌ، غَيْرَ أَنَّهُ يَحْفَظُ جَوْدَةَ الزَّيْتِ',
        exampleDe: 'Die Pressung ist langsam, außer dass sie die Ölqualität vollendet wahrt.',
        exampleEn: 'The pressing is slow, except that it perfectly preserves oil quality.',
      ),
    ];
  }
}
