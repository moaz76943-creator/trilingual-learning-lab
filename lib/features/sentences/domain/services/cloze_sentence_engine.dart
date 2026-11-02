class ClozeChallenge {
  final String sentenceWithBlank;
  final String correctWord;
  final List<String> options;
  final String translationDe;
  final String translationEn;

  const ClozeChallenge({
    required this.sentenceWithBlank,
    required this.correctWord,
    required this.options,
    required this.translationDe,
    required this.translationEn,
  });
}

class ClozeSentenceEngine {
  static ClozeChallenge createBlank({
    required String fullArabicSentence,
    required String targetWord,
    required List<String> distractors,
    required String translationDe,
    required String translationEn,
  }) {
    final blanked = fullArabicSentence.replaceAll(targetWord, '______');
    final allOptions = [targetWord, ...distractors]..shuffle();

    return ClozeChallenge(
      sentenceWithBlank: blanked,
      correctWord: targetWord,
      options: allOptions,
      translationDe: translationDe,
      translationEn: translationEn,
    );
  }
}
