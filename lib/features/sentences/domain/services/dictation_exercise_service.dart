import '../../../../core/utils/arabic_text_shaper.dart';

class DictationEvaluation {
  final bool isExactMatch;
  final bool isNormalizedMatch;
  final double similarityScore;

  const DictationEvaluation({
    required this.isExactMatch,
    required this.isNormalizedMatch,
    required this.similarityScore,
  });
}

class DictationExerciseService {
  static DictationEvaluation evaluateInput({
    required String userInput,
    required String expectedArabic,
  }) {
    final cleanUser = userInput.trim();
    final cleanExpected = expectedArabic.trim();

    final isExact = cleanUser == cleanExpected;
    final userNormalized = ArabicTextShaper.normalize(cleanUser);
    final expectedNormalized = ArabicTextShaper.normalize(cleanExpected);
    final isNorm = userNormalized == expectedNormalized;

    double score = 0.0;
    if (isExact) {
      score = 1.0;
    } else if (isNorm) {
      score = 0.9;
    } else {
      final matches = cleanUser.split(' ').where((w) => cleanExpected.contains(w)).length;
      final total = cleanExpected.split(' ').length;
      score = total == 0 ? 0.0 : (matches / total).clamp(0.0, 1.0);
    }

    return DictationEvaluation(
      isExactMatch: isExact,
      isNormalizedMatch: isNorm,
      similarityScore: double.parse(score.toStringAsFixed(2)),
    );
  }
}
