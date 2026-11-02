class TrilingualProverb {
  final String arabic;
  final String german;
  final String english;
  final String moralTheme;

  const TrilingualProverb({
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralTheme,
  });
}

class TrilingualProverbService {
  static List<TrilingualProverb> getEthicalProverbs() {
    return const [
      TrilingualProverb(
        arabic: 'مَنْ جَدَّ وَجَدَ، وَمَنْ زَرَعَ حَصَدَ.',
        german: 'Wer suchet, der findet; und Fleiß bringt Preis.',
        english: 'Where there is a will, there is a way.',
        moralTheme: 'الاجتهاد والمثابرة',
      ),
      TrilingualProverb(
        arabic: 'الصَّبْرُ مِفْتَاحُ الفَرَجِ.',
        german: 'Geduld bringt Rosen.',
        english: 'Patience is the key to relief.',
        moralTheme: 'الصبر والتحمل',
      ),
      TrilingualProverb(
        arabic: 'الوِقَايَةُ خَيْرٌ مِنَ العِلَاجِ.',
        german: 'Vorsorge ist besser als Nachsorge.',
        english: 'Prevention is better than cure.',
        moralTheme: 'الحكمة وحسن التدبير',
      ),
    ];
  }
}
