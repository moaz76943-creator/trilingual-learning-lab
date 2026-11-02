class QuantifierExpression {
  final String arabic;
  final String german;
  final String english;
  final String contextNote;

  const QuantifierExpression({
    required this.arabic,
    required this.german,
    required this.english,
    required this.contextNote,
  });
}

class QuantifiersService {
  static List<QuantifierExpression> getNaturalQuantifiers() {
    return const [
      QuantifierExpression(
        arabic: 'قَطَرَاتٌ يَسِيرَةٌ مِنْ زَيْتِ الوَرْدِ',
        german: 'einige wenige Tropfen Rosenöl',
        english: 'a few gentle drops of rose oil',
        contextNote: 'للسوائل العطرية المركزة النقية',
      ),
      QuantifierExpression(
        arabic: 'قَبْضَةُ يَدٍ مِنَ الأَعْشَابِ المُجَفَّفَةِ',
        german: 'eine Handvoll getrockneter Kräuter',
        english: 'a handful of dried herbs',
        contextNote: 'للنباتات والأزهار المجففة الصافية',
      ),
      QuantifierExpression(
        arabic: 'مِقْدَارٌ مُتَوَازِنٌ مِنَ المَاءِ النَّقِيِّ',
        german: 'eine ausgewogene Menge an reinem Wasser',
        english: 'a balanced amount of pure water',
        contextNote: 'للمزج والتركيب الدقيق',
      ),
    ];
  }
}
