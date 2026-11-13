import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/curriculum/presentation/controllers/adaptive_mastery_controller.dart';

void main() {
  group('AdaptiveMasteryController - CEFR & Bayesian Knowledge Tracing Tests', () {
    late AdaptiveMasteryController controller;

    setUp(() {
      controller = AdaptiveMasteryController();
    });

    test('Initial state configures 4 skill domains for all 3 languages', () {
      final state = controller.state;
      expect(state.activeLanguage, AppLanguage.arabic);
      expect(state.competencyNodes.length, AppLanguage.values.length * SkillDomain.values.length);
      expect(state.activeLanguageOverallScore, greaterThan(0.40));
    });

    test('CEFR level conversion properly maps scores to bands', () {
      expect(CefrLevel.fromScore(0.15), CefrLevel.a1);
      expect(CefrLevel.fromScore(0.35), CefrLevel.a2);
      expect(CefrLevel.fromScore(0.55), CefrLevel.b1);
      expect(CefrLevel.fromScore(0.75), CefrLevel.b2);
      expect(CefrLevel.fromScore(0.88), CefrLevel.c1);
      expect(CefrLevel.fromScore(0.96), CefrLevel.c2);
    });

    test('Bayesian Knowledge Tracing (BKT): Correct answer increases mastery probability', () {
      final key = 'ar_${SkillDomain.grammar.name}';
      final initialScore = controller.state.competencyNodes[key]!.probabilityMastery;

      controller.recordAssessmentResult(domain: SkillDomain.grammar, isCorrect: true);

      final newScore = controller.state.competencyNodes[key]!.probabilityMastery;
      expect(newScore, greaterThan(initialScore));
    });

    test('Bayesian Knowledge Tracing (BKT): Incorrect answer decreases posterior mastery', () {
      final key = 'ar_${SkillDomain.reading.name}';
      final initialScore = controller.state.competencyNodes[key]!.probabilityMastery;

      controller.recordAssessmentResult(domain: SkillDomain.reading, isCorrect: false);

      final newScore = controller.state.competencyNodes[key]!.probabilityMastery;
      expect(newScore, lessThan(initialScore));
    });

    test('Identifies the weakest competency node for targeted remedial routing', () {
      // Force grammar to be very low
      controller.recordAssessmentResult(domain: SkillDomain.grammar, isCorrect: false);
      controller.recordAssessmentResult(domain: SkillDomain.grammar, isCorrect: false);

      final weakest = controller.state.weakestCompetencyNode;
      expect(weakest.domain, SkillDomain.grammar);
    });

    test('Language switching updates active context correctly', () {
      controller.setActiveLanguage(AppLanguage.german);
      expect(controller.state.activeLanguage, AppLanguage.german);

      controller.setActiveLanguage(AppLanguage.english);
      expect(controller.state.activeLanguage, AppLanguage.english);
    });

    test('Reset restores pristine state', () {
      controller.setActiveLanguage(AppLanguage.german);
      controller.recordAssessmentResult(domain: SkillDomain.reading, isCorrect: true);
      controller.resetDefaults();

      expect(controller.state.activeLanguage, AppLanguage.arabic);
    });
  });
}
