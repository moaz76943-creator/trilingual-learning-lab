class TransformationPair {
  final String relativeClauseAr;
  final String participialAttributeAr;
  final String relativeClauseDe;
  final String extendedParticipleDe;
  final String englishEquivalent;

  const TransformationPair({
    required this.relativeClauseAr,
    required this.participialAttributeAr,
    required this.relativeClauseDe,
    required this.extendedParticipleDe,
    required this.englishEquivalent,
  });
}

class ParticipialRelativeTransformer {
  static List<TransformationPair> getCoreTransformations() {
    return const [
      TransformationPair(
        relativeClauseAr: 'المَاءُ الَّذِي يَتَدَفَّقُ بِقُوَّةٍ يُدِيرُ الرَّحَى',
        participialAttributeAr: 'المَاءُ المُتَدَفِّقُ بِقُوَّةٍ يُدِيرُ الرَّحَى',
        relativeClauseDe: 'Das Wasser, das kraftvoll strömt, treibt die Mühle an.',
        extendedParticipleDe: 'Das kraftvoll strömende Wasser treibt die Mühle an.',
        englishEquivalent: 'The water flowing powerfully drives the mill.',
      ),
      TransformationPair(
        relativeClauseAr: 'الحَجَرُ الَّذِي نُحِتَ بِدِقَّةٍ يَثْبُتُ فِي البِنَاءِ',
        participialAttributeAr: 'الحَجَرُ المَنْحُوتُ بِدِقَّةٍ يَثْبُتُ فِي البِنَاءِ',
        relativeClauseDe: 'Der Stein, der präzise behauen wurde, sitzt fest im Bau.',
        extendedParticipleDe: 'Der präzise behauene Stein sitzt fest im Bau.',
        englishEquivalent: 'The precisely chiseled stone sits firmly in the wall.',
      ),
    ];
  }
}
