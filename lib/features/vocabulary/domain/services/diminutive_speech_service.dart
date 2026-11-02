class DiminutiveForm {
  final String baseArabic;
  final String diminutiveArabic;
  final String germanDiminutive;
  final String englishMeaning;
  final String affectiveTone;

  const DiminutiveForm({
    required this.baseArabic,
    required this.diminutiveArabic,
    required this.germanDiminutive,
    required this.englishMeaning,
    required this.affectiveTone,
  });
}

class DiminutiveSpeechService {
  static List<DiminutiveForm> getAffectionateDiminutives() {
    return const [
      DiminutiveForm(
        baseArabic: 'ابْنٌ',
        diminutiveArabic: 'بُنَيَّ',
        germanDiminutive: 'mein liebes Söhnchen / Kind',
        englishMeaning: 'my dear little son',
        affectiveTone: 'تلطف وشفقة ونصح أبوي كريم',
      ),
      DiminutiveForm(
        baseArabic: 'نَهْرٌ',
        diminutiveArabic: 'نُهَيْرٌ جَارٍ',
        germanDiminutive: 'das fließende Bächlein',
        englishMeaning: 'a gentle flowing brook',
        affectiveTone: 'وصف جمالي رقيق للطبيعة',
      ),
      DiminutiveForm(
        baseArabic: 'كِتَابٌ',
        diminutiveArabic: 'كُتَيِّبٌ نَافِعٌ',
        germanDiminutive: 'ein nützliches Büchlein',
        englishMeaning: 'a useful little booklet',
        affectiveTone: 'تيسير وتسهيل العلم للمتعلم',
      ),
    ];
  }
}
