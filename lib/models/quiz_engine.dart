import 'dart:math';
import 'concept.dart';

class QuizQuestion {
  final Concept targetConcept;
  final String questionText;
  final String correctAnswer;
  final List<String> options;
  final String exampleText;

  QuizQuestion({
    required this.targetConcept,
    required this.questionText,
    required this.correctAnswer,
    required this.options,
    required this.exampleText,
  });
}

class QuizEngine {
  static final Random _random = Random();

  // توليد جولة اختبار مكونة من عدد محدد من الأسئلة
  static List<QuizQuestion> generateSession({
    required List<Concept> pool,
    required String targetLang, // 'de' or 'en'
    int count = 10,
  }) {
    if (pool.isEmpty) return [];

    final List<Concept> shuffledPool = List.from(pool)..shuffle(_random);
    final int questionCount = min(count, shuffledPool.length);
    final List<QuizQuestion> session = [];

    for (int i = 0; i < questionCount; i++) {
      final target = shuffledPool[i];
      final bool isGerman = targetLang == 'de';

      // نص السؤال هو الكلمة باللغة الأجنبية
      final String qText = isGerman ? '${target.de.article}${target.de.word}' : target.en.word;
      final String correctAns = target.ar.vocalized;
      final String example = isGerman ? '${target.de.example}\n${target.ar.example}' : '${target.en.example}\n${target.ar.example}';

      // استخراج خيارات مضللة واقعية من نفس المجموعة
      final Set<String> distractors = {};
      final List<Concept> potentialDistractors = List.from(pool)..shuffle(_random);

      for (var d in potentialDistractors) {
        if (d.conceptId != target.conceptId) {
          distractors.add(d.ar.vocalized);
          if (distractors.length == 3) break;
        }
      }

      final List<String> allOptions = [correctAns, ...distractors]..shuffle(_random);

      session.add(QuizQuestion(
        targetConcept: target,
        questionText: qText,
        correctAnswer: correctAns,
        options: allOptions,
        exampleText: example,
      ));
    }

    return session;
  }
}
