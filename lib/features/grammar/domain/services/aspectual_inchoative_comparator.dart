// Task #657: Aspectual Inchoative and Phase Initiation Comparator
class AspectualInchoativeEntry {
  final String arabicInchoative;
  final String germanInchoative;
  final String englishInchoative;
  final String aspectualFunction;
  const AspectualInchoativeEntry({
    required this.arabicInchoative,
    required this.germanInchoative,
    required this.englishInchoative,
    required this.aspectualFunction,
  });
}

class AspectualInchoativeComparator {
  static const List<AspectualInchoativeEntry> structures = [
    AspectualInchoativeEntry(
      arabicInchoative: 'طَفِقَ الصَّائِغُ يَنْقُشُ صَفِيحَةَ الفِضَّةِ حِينَ بَلَغَتْ لَدَانَتَهَا المَطْلُوبَةَ',
      germanInchoative: 'Der Silberschmied hob an, das Silberblech zu ziselieren, als es die nötige Geschmeidigkeit erlangte',
      englishInchoative: 'The silversmith set about chasing the silver plate once it attained its requisite malleability',
      aspectualFunction: 'Inchoative aspect marking deliberate initiation of delicate ornamental craftsmanship',
    ),
    AspectualInchoativeEntry(
      arabicInchoative: 'أَخَذَتِ النَّارُ تَتَأَجَّجُ فِي البُوتَقَةِ إِيذَانًا بِبَدْءِ انْصِهَارِ السَّبِيكَةِ',
      germanInchoative: 'Das Feuer begann im Tiegel aufzulodern und kündete den Beginn der Legierungsschmelze an',
      englishInchoative: 'The flame began kindling fiercely within the crucible, heralding the onset of alloy fusion',
      aspectualFunction: 'Inchoative progressive transition in thermal metallurgy preparations',
    ),
  ];
}
