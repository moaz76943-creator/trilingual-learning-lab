class EthicalMetaphor {
  final String traitTheme;
  final String arabicMetaphor;
  final String germanEquivalent;
  final String englishEquivalent;
  final String culturalContext;

  const EthicalMetaphor({
    required this.traitTheme,
    required this.arabicMetaphor,
    required this.germanEquivalent,
    required this.englishEquivalent,
    required this.culturalContext,
  });
}

class GenerosityMetaphorsService {
  static List<EthicalMetaphor> getEthicalMetaphors() {
    return const [
      EthicalMetaphor(
        traitTheme: 'الجود وسخاء النفس (Generosity)',
        arabicMetaphor: 'كَرِيمُ النَّفْسِ بَسِيطُ اليَدَيْنِ فِي الخَيْرِ',
        germanEquivalent: 'von edelmütigem und freigebigem Herzen',
        englishEquivalent: 'noble-hearted and open-handed in charity',
        culturalContext: 'كناية عن البذل المستمر دون منٍّ أو أذى',
      ),
      EthicalMetaphor(
        traitTheme: 'بشاشة الوجه وحسن الاستقبال (Warm Welcoming)',
        arabicMetaphor: 'طَلْقُ المُحَيَّا بَاسِمُ الثَّغْرِ',
        germanEquivalent: 'ein offenes und warmherziges Lächeln',
        englishEquivalent: 'with a bright, radiant, and welcoming countenance',
        culturalContext: 'دلالة على اللباقة ونشر الطمأنينة بين الضيوف',
      ),
    ];
  }
}
