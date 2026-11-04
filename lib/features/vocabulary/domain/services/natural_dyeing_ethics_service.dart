class DyeingEthicValue {
  final String domain;
  final String arabic;
  final String german;
  final String english;
  final String ecoPrinciple;

  const DyeingEthicValue({
    required this.domain,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ecoPrinciple,
  });
}

class NaturalDyeingEthicsService {
  static List<DyeingEthicValue> getEthicValues() {
    return const [
      DyeingEthicValue(
        domain: 'الصباغة الخالية من السموم (Non-Toxic Dyeing)',
        arabic: 'الأَصْبَاغُ النَّبَاتِيَّةُ الخَالِيَةُ مِنَ الكِيمَاوِيَّاتِ الضَّارَّةِ',
        german: 'Reine Pflanzenfarben ohne schädliche chemische Zusätze.',
        english: 'Pure plant dyes free from harmful synthetic chemicals.',
        ecoPrinciple: 'الحفاظ على سلامة الحرفي والمستهلك ونقاء المياه الجوفية والسطحية.',
      ),
      DyeingEthicValue(
        domain: 'التثبيت بالمعادن الطبيعية (Natural Mineral Fixing)',
        arabic: 'تَثْبِيتُ اللَّوْنِ بِالشَّبَّةِ المَعْدِنِيَّةِ البَلَدِيَّةِ',
        german: 'Schonende Farbfixierung mit natürlichem Alaungestein.',
        english: 'Gentle color mordanting with natural earth alum mineral.',
        ecoPrinciple: 'استعمال العناصر الترابية الصديقة للبيئة لضمان ثبات اللون دون تلوث.',
      ),
    ];
  }
}
