class WaterEthicsTerm {
  final String domain;
  final String arabic;
  final String german;
  final String english;
  final String ethicalGrounding;

  const WaterEthicsTerm({
    required this.domain,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ethicalGrounding,
  });
}

class WaterSharingEthicsService {
  static List<WaterEthicsTerm> getEthicsTerms() {
    return const [
      WaterEthicsTerm(
        domain: 'فضل سقيا الماء (The Virtue of Water Sharing)',
        arabic: 'سُقْيَا المَاءِ مِنْ أَعْظَمِ القُرُبَاتِ وَأَفْضَلِ الصَّدَقَاتِ',
        german: 'Das Spenden von frischem Trinkwasser ist eine der edelsten Taten der Nächstenliebe.',
        english: 'Providing fresh drinking water is among the greatest charitable deeds.',
        ethicalGrounding: 'في كل كبد رطبة أجر، وإرواء العطشى يحيي النفوس ويقوي الروابط.',
      ),
      WaterEthicsTerm(
        domain: 'صيانة الموارد النقية (Purity Protection)',
        arabic: 'صَوْنُ صَهَارِيجِ المَطَرِ عَنِ الأَقْذَارِ وَالشَّوَائِبِ',
        german: 'Die gewissenhafte Reinhaltung der Regenwasserzisternen vor jeglicher Verunreinigung.',
        english: 'Conscientious protection of rainwater cisterns from any contamination.',
        ethicalGrounding: 'حفظ الصحة العامة للمجتمع أمانة ومسؤولية مشتركة.',
      ),
    ];
  }
}
