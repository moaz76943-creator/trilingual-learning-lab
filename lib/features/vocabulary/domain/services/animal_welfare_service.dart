class WelfarePrinciple {
  final String theme;
  final String arabic;
  final String german;
  final String english;
  final String ethicalGrounding;

  const WelfarePrinciple({
    required this.theme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ethicalGrounding,
  });
}

class AnimalWelfareService {
  static List<WelfarePrinciple> getPrinciples() {
    return const [
      WelfarePrinciple(
        theme: 'الرفق بالحيوان وتخفيف الحمل (Compassion and Lightening Burden)',
        arabic: 'الرِّفْقُ بِالدَّوَابِّ وَتَخْفِيفُ الأَحْمَالِ عَنْهَا',
        german: 'Güte gegenüber Tieren und das Erleichtern ihrer Lasten.',
        english: 'Kindness to animals and lightening their burdens.',
        ethicalGrounding: 'في كل كبد رطبة أجر، وإرهاق الحيوان محظور أخلاقياً وشرعياً.',
      ),
      WelfarePrinciple(
        theme: 'الإطعام والإرواء والسقيا (Nourishing and Watering)',
        arabic: 'حُسْنُ الرِّعَايَةِ وَتَوْفِيرُ الكَلَإِ الطَّيِّبِ وَالمَاءِ العَذْبِ',
        german: 'Fürsorgliche Pflege durch gutes Futter und stets frisches Wasser.',
        english: 'Benevolent care by providing wholesome fodder and fresh water.',
        ethicalGrounding: 'إكرام مخلوقات الله وتقدير دورها في عمارة الأرض.',
      ),
    ];
  }
}
