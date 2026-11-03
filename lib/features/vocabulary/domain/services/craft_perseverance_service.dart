class PerseveranceTerm {
  final String virtueName;
  final String arabic;
  final String german;
  final String english;
  final String behavioralApplication;

  const PerseveranceTerm({
    required this.virtueName,
    required this.arabic,
    required this.german,
    required this.english,
    required this.behavioralApplication,
  });
}

class CraftPerseveranceService {
  static List<PerseveranceTerm> getCoreVirtues() {
    return const [
      PerseveranceTerm(
        virtueName: 'الصبر على التدقيق الدقيق (Patience in Detail)',
        arabic: 'الصَّبْرُ مِفْتَاحُ الإِتْقَانِ وَبَابُ الفَلَاحِ',
        german: 'Geduld ist der Schlüssel zur Vollendung und Meisterschaft.',
        english: 'Patience is the key to perfection and enduring success.',
        behavioralApplication: 'إعادة ضبط القطع الميكانيكية مراراً حتى تعمل بأعلى درجات الانسيابية.',
      ),
      PerseveranceTerm(
        virtueName: 'دوام الاستقامة والإخلاص (Steadfast Dedication)',
        arabic: 'الثَّبَاتُ عَلَى الجَوْدَةِ مَهْمَا طَالَ الزَّمَانُ',
        german: 'Unbeirrbares Festhalten an höchster Qualität über die Zeit.',
        english: 'Steadfast commitment to quality regardless of time.',
        behavioralApplication: 'عدم التنازل عن معايير الإحسان في أي مرحلة من مراحل العمل.',
      ),
    ];
  }
}
