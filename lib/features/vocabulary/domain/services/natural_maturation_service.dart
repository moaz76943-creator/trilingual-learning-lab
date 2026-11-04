class MaturationWisdomItem {
  final String virtue;
  final String arabic;
  final String german;
  final String english;
  final String craftsmanshipLesson;

  const MaturationWisdomItem({
    required this.virtue,
    required this.arabic,
    required this.german,
    required this.english,
    required this.craftsmanshipLesson,
  });
}

class NaturalMaturationService {
  static List<MaturationWisdomItem> getWisdomLessons() {
    return const [
      MaturationWisdomItem(
        virtue: 'الصبر على بلوغ الجودة التامة (Patience in Maturation)',
        arabic: 'النُّضْجُ الهَادِئُ بِفِعْلِ الزَّمَانِ سِرُّ الإِتْقَانِ',
        german: 'Vollendete Reife in der Ruhe der Zeit ist das Geheimnis wahrer Meisterschaft.',
        english: 'Quiet maturation in the fullness of time is the secret of genuine excellence.',
        craftsmanshipLesson: 'عدم تعجيل خروج المنتجات الحرفية قبل أوان نضجها وتماسكها الطبيعي.',
      ),
      MaturationWisdomItem(
        virtue: 'قيمة القديم الأصيل (Value of Cured Heritage)',
        arabic: 'كُلَّمَا عَتُقَ الأَصِيلُ ازْدَادَ طِيبًا وَنَفْعًا',
        german: 'Je reifer das Gediegene wird, desto reiner entfaltet sich seine Güte.',
        english: 'The more authentic a noble craft matures, the finer its goodness unfolds.',
        craftsmanshipLesson: 'المنتجات الطبيعية المصنوعة بصدق تزداد قيمة مع تقادم السنين.',
      ),
    ];
  }
}
