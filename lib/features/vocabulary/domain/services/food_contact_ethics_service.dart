class FoodContactValue {
  final String safetyTheme;
  final String arabic;
  final String german;
  final String english;
  final String healthPrinciple;

  const FoodContactValue({
    required this.safetyTheme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.healthPrinciple,
  });
}

class FoodContactEthicsService {
  static List<FoodContactValue> getSafetyPrinciples() {
    return const [
      FoodContactValue(
        safetyTheme: 'خلو أواني الطعام من السموم (Non-Toxic Tableware)',
        arabic: 'الأَوَانِي الخَشَبِيَّةُ الخَالِيَةُ مِنَ الطِّلَاءَاتِ الكِيمْيَائِيَّةِ',
        german: 'Unbehandelte Holzgefäße vollkommen frei von synthetischen Lacken.',
        english: 'Natural wooden vessels completely free of chemical varnishes.',
        healthPrinciple: 'الاعتماد على المواد الطبيعية يمنع تسرب السموم إلى الطعام والشراب.',
      ),
      FoodContactValue(
        safetyTheme: 'نظافة وقدسية الطعام والماء (Sanctity of Clean Sustenance)',
        arabic: 'طَهَارَةُ الإِنَاءِ عُنْوَانُ البَرَكَةِ فِي الطَّعَامِ وَالشَّرَابِ',
        german: 'Die Reinheit des Gefäßes ist das Fundament des Segens in Speise und Trank.',
        english: 'Purity of the vessel is the foundation of blessing in food and drink.',
        healthPrinciple: 'العناية بنظافة الآنية وتجفيفها بالهواء النقي يحفظ العافية ويمنع الجراثيم.',
      ),
    ];
  }
}
