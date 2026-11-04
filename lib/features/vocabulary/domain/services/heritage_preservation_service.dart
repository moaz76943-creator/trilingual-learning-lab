class HeritageValueItem {
  final String domain;
  final String arabic;
  final String german;
  final String english;
  final String culturalRole;

  const HeritageValueItem({
    required this.domain,
    required this.arabic,
    required this.german,
    required this.english,
    required this.culturalRole,
  });
}

class HeritagePreservationService {
  static List<HeritageValueItem> getHeritageValues() {
    return const [
      HeritageValueItem(
        domain: 'صون التراث العلمي المكتوب (Preserving Written Heritage)',
        arabic: 'صَوْنُ المَخْطُوطَاتِ النَّفِيسَةِ فِي أَوْعِيَةٍ طَبِيعِيَّةٍ آمِنَةٍ',
        german: 'Die behutsame Verwahrung kostbarer Handschriften in sicheren Naturbehältern.',
        english: 'Careful preservation of precious manuscripts in secure natural containers.',
        culturalRole: 'حفظ ذاكرة الأمة وتوثيق العلوم النافعة للأجيال القادمة.',
      ),
      HeritageValueItem(
        domain: 'الحماية الطبيعية دون كيماويات (Eco-Friendly Protection)',
        arabic: 'طَرْدُ حَشَرَاتِ الكُتُبِ بِرَائِحَةِ خَشَبِ الأَرْزِ وَأَوْرَاقِ الغَارِ',
        german: 'Natürlicher Insektenschutz durch den Duft von Zedernholz und Lorbeerblättern.',
        english: 'Natural pest deterrence through the aroma of cedar wood and bay laurel.',
        culturalRole: 'الاستغناء عن المبيدات الضارة واستعمال أسرار الطبيعة في الحفظ الوقائي.',
      ),
    ];
  }
}
