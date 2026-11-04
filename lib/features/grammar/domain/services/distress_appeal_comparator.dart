class DistressAppealRuleGuide {
  final String categoryTitle;
  final String arConstruction;
  final String deConstruction;
  final String enConstruction;
  final String exampleAr;
  final String exampleDe;
  final String exampleEn;

  const DistressAppealRuleGuide({
    required this.categoryTitle,
    required this.arConstruction,
    required this.deConstruction,
    required this.enConstruction,
    required this.exampleAr,
    required this.exampleDe,
    required this.exampleEn,
  });
}

class DistressAppealComparator {
  static List<DistressAppealRuleGuide> getRules() {
    return const [
      DistressAppealRuleGuide(
        categoryTitle: 'أسلوب الاستغاثة لطلب النجدة (Appeal for Relief)',
        arConstruction: 'يَا + لَـ (المَفْتُوحَةُ لِلْمُسْتَغَاثِ بِهِ) + لَـ (المَكْسُورَةُ لِلْمُسْتَغَاثِ لَهُ)',
        deConstruction: 'Dringender Hilferuf: "Zu Hilfe für..." / "Eilt herbei!"',
        enConstruction: 'Urgent call for rescue: "Come to the aid of..."',
        exampleAr: 'يَا لَلْكُرَمَاءِ لِلْمُسَافِرِ الحَائِرِ فِي الظَّلَامِ',
        exampleDe: 'Kommt herbei, ihr Edlen, zur Hilfe dem Wanderer in der Nacht!',
        exampleEn: 'Come, noble souls, to the aid of the traveler lost in the night!',
      ),
      DistressAppealRuleGuide(
        categoryTitle: 'نداء الإرشاد والتبصير (Call to Guidance)',
        arConstruction: 'يَا (للتنبيه) + المُنَادَى المُعَرَّفُ + أَمْرٌ بِالهِدَايَةِ وَالإِعَانَةِ',
        deConstruction: 'Leitender Aufruf: "O Wanderer, wende dich dem Licht zu!"',
        enConstruction: 'Guiding direction: "O wayfarer, follow the beacon light!"',
        exampleAr: 'يَا أَيُّهَا الرُّكْبَانُ، اتَّجِهُوا نَحْوَ نُورِ المَنَارَةِ الهَادِيَةِ',
        exampleDe: 'O ihr Seefahrer, richtet den Kurs nach dem Licht des Leuchtturms!',
        exampleEn: 'O seafarers, set your course toward the beacon of the lighthouse!',
      ),
    ];
  }
}
