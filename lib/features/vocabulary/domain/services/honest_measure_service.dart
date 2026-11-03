class HonestMeasurePrinciple {
  final String ethicalTheme;
  final String arabic;
  final String german;
  final String english;
  final String commercialValue;

  const HonestMeasurePrinciple({
    required this.ethicalTheme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.commercialValue,
  });
}

class HonestMeasureService {
  static List<HonestMeasurePrinciple> getPrinciples() {
    return const [
      HonestMeasurePrinciple(
        ethicalTheme: 'العدل التام في الكيل والميزان (Fair Measurement)',
        arabic: 'الكَيْلُ بِالقِسْطَاسِ المُسْتَقِيمِ دُونَ نَقْصٍ',
        german: 'Gerechtes und unverfälschtes Abwiegen nach bestem Gewissen.',
        english: 'Measuring with just, upright scales without diminution.',
        commercialValue: 'الأمانة في الميزان تجلب البركة وتورث ثقة المشتري ورضاه.',
      ),
      HonestMeasurePrinciple(
        ethicalTheme: 'عدم بخس الناس أشياءهم (Integrity of Goods)',
        arabic: 'تَبْيِينُ صِفَاتِ السِّلْعَةِ بِصِدْقٍ وَأَمَانَةٍ',
        german: 'Aufrichtige und wahrheitsgemäße Beschreibung der Wareneigenschaften.',
        english: 'Truthful and candid disclosure of product qualities.',
        commercialValue: 'النصح للمشتري وإيضاح الواقع يرفع قدر التاجر في المجتمع.',
      ),
    ];
  }
}
