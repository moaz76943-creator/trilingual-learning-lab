class CourteousSpeechExpression {
  final String occasion;
  final String arabic;
  final String german;
  final String english;

  const CourteousSpeechExpression({
    required this.occasion,
    required this.arabic,
    required this.german,
    required this.english,
  });
}

class CourteousSpeechService {
  static List<CourteousSpeechExpression> getSocialEtiquettes() {
    return const [
      CourteousSpeechExpression(
        occasion: 'التهنئة بالإنجاز النافع والنجاح',
        arabic: 'مُبَارَكٌ لَكَ هَذَا الإِنْجَازُ، نَفَعَ اللهُ بِكَ.',
        german: 'Herzlichen Glückwunsch zu diesem Erfolg! Möge es nützlich sein.',
        english: 'Congratulations on this achievement! May it bring great benefit.',
      ),
      CourteousSpeechExpression(
        occasion: 'الدعاء بالشفاء العاجل عند عيادة المريض',
        arabic: 'شَفَاكَ اللهُ وَعَافَاكَ طَهُورٌ إِنْ شَاءَ اللهُ.',
        german: 'Gute und baldige Besserung von ganzem Herzen.',
        english: 'Wishing you a full and speedy recovery with heartfelt blessings.',
      ),
      CourteousSpeechExpression(
        occasion: 'الشكر على حسن الضيافة والمعاملة الطيبة',
        arabic: 'أَكْرَمَكُمُ اللهُ وَأَحْسَنَ إِلَيْكُمْ كَمَا أَحْسَنْتُمْ إِلَيْنَا.',
        german: 'Vielen herzlichen Dank für Ihre Gastfreundschaft und Großzügigkeit.',
        english: 'May God reward your generosity and kindness towards us.',
      ),
    ];
  }
}
