class SensoryAttribute {
  final String domain;
  final String arabic;
  final String german;
  final String english;
  final String contextExample;

  const SensoryAttribute({
    required this.domain,
    required this.arabic,
    required this.german,
    required this.english,
    required this.contextExample,
  });
}

class SensoryAttributesService {
  static List<SensoryAttribute> getSensoryAttributes() {
    return const [
      SensoryAttribute(
        domain: 'الملمس والنعومة (Texture)',
        arabic: 'أَمْلَسُ نَاعِمٌ طَيِّبُ المَلْمَسِ',
        german: 'glatt und seidig weich',
        english: 'smooth and soft to the touch',
        contextExample: 'سَعَفُ النَّخْلِ المَجْدُولُ نَاعِمٌ',
      ),
      SensoryAttribute(
        domain: 'المتانة والصلابة (Solidity)',
        arabic: 'صَلْدٌ مَتِينٌ غَيْرُ قَابِلٍ لِلانْكِسَارِ',
        german: 'fest, solide und widerstandsfähig',
        english: 'solid, sturdy, and durable',
        contextExample: 'جِذْعُ النَّخْلَةِ صَلْدٌ ثَابِتٌ',
      ),
      SensoryAttribute(
        domain: 'اللمعان والصفاء (Luminosity)',
        arabic: 'بَرَّاقٌ نَاصِعٌ يَعْكِسُ النُّورَ',
        german: 'glänzend und strahlend',
        english: 'radiant, glossy, and clear',
        contextExample: 'حَبَّةُ الرُّطَبِ بَرَّاقَةٌ فِي الشَّمْسِ',
      ),
    ];
  }
}
