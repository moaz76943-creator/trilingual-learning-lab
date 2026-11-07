// Task #609: Dynamic Gradation and Incremental Progression Comparator
class DynamicGradationEntry {
  final String arabicGradation;
  final String germanGradation;
  final String englishGradation;
  final String processAnalysis;
  const DynamicGradationEntry({
    required this.arabicGradation,
    required this.germanGradation,
    required this.englishGradation,
    required this.processAnalysis,
  });
}

class DynamicGradationComparator {
  static const List<DynamicGradationEntry> gradations = [
    DynamicGradationEntry(
      arabicGradation: 'يَنْصَبُّ الزَّيْتُ الذَّهَبِيُّ شَيْئًا فَشَيْئًا مَعَ زِيَادَةِ ثِقَلِ العَارِضَةِ',
      germanGradation: 'Das goldene Öl fließt Schritt für Schritt mit zunehmendem Gewicht des Pressbalkens',
      englishGradation: 'The golden oil flows little by little as the weight of the press beam increases',
      processAnalysis: 'Sequential mechanical extraction through incremental gravity pressure',
    ),
    DynamicGradationEntry(
      arabicGradation: 'يَتَصَافَى السَّائِلُ دَرَجَةً فَدَرَجَةً حَتَّى يَنْفَصِلَ المَاءُ عَنِ الزَّيْتِ النَّقِيِّ',
      germanGradation: 'Die Flüssigkeit klärt sich allmählich, bis sich das Fruchtwasser vom reinen Öl scheidet',
      englishGradation: 'The liquid clarifies by graduated degrees until the fruit water separates from pure oil',
      processAnalysis: 'Continuous gravity-based natural decanting of virgin olive oil',
    ),
  ];
}
