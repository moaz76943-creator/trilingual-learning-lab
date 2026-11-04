class HarmoniousUnityTerm {
  final String metaphorTheme;
  final String arabic;
  final String german;
  final String english;
  final String societalReflection;

  const HarmoniousUnityTerm({
    required this.metaphorTheme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.societalReflection,
  });
}

class HarmoniousUnityService {
  static List<HarmoniousUnityTerm> getUnityTerms() {
    return const [
      HarmoniousUnityTerm(
        metaphorTheme: 'تكامل الأفراد في البناء الواحد (Solidarity like a Wall)',
        arabic: 'المُؤْمِنُ لِلْمُؤْمِنِ كَالْبُنْيَانِ يَشُدُّ بَعْضُهُ بَعْضًا',
        german: 'Die Gemeinschaft ist wie ein festes Bauwerk: Ein Stein stützt den anderen.',
        english: 'Believers are like a solid structure: each part strengthens the other.',
        societalReflection: 'قوة المجتمع في تكاتف أعضائه وسد ثغرات الضعف بالتراحم والتكامل.',
      ),
      HarmoniousUnityTerm(
        metaphorTheme: 'التنوع المتآلف (Harmonious Diversity)',
        arabic: 'تَنَوُّعُ الأَلْوَانِ فِي اللَّوْحَةِ يُظْهِرُ بَهَاءَ الإِتْقَانِ',
        german: 'Die Vielfalt der Farben im Mosaik offenbart die Vollendung des Ganzen.',
        english: 'Diversity of colors in the mosaic reveals the perfection of the whole.',
        societalReflection: 'تنوع المهارات والمواهب بين الناس من أسرار عمران الأرض ونجاح الأمة.',
      ),
    ];
  }
}
