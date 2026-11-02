class ScrambledSentenceChallenge {
  final String originalSentence;
  final List<String> scrambledTokens;
  final String translationDe;
  final String translationEn;

  const ScrambledSentenceChallenge({
    required this.originalSentence,
    required this.scrambledTokens,
    required this.translationDe,
    required this.translationEn,
  });
}

class SentenceReconstructionService {
  static ScrambledSentenceChallenge createChallenge({
    required String arabicSentence,
    required String translationDe,
    required String translationEn,
  }) {
    final tokens = arabicSentence.trim().split(RegExp(r'\s+'));
    final scrambled = List<String>.from(tokens)..shuffle();

    return ScrambledSentenceChallenge(
      originalSentence: arabicSentence,
      scrambledTokens: scrambled,
      translationDe: translationDe,
      translationEn: translationEn,
    );
  }

  static bool evaluateAnswer(List<String> userOrderedTokens, String originalSentence) {
    return userOrderedTokens.join(' ').trim() == originalSentence.trim();
  }
}
