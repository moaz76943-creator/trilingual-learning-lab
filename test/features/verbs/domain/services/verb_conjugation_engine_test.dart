import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/verbs/domain/services/verb_conjugation_engine.dart';

void main() {
  group('VerbConjugationEngine Morphological Paradigms', () {
    late TrilingualVerbParadigm magnifyVerb;

    setUp(() {
      magnifyVerb = TrilingualVerbParadigm.magnify();
    });

    test('Validates complete verb paradigm successfully', () {
      expect(VerbConjugationEngine.validate(magnifyVerb), isTrue);
      expect(magnifyVerb.rootAr, equals('ك - ب - ر'));
      expect(magnifyVerb.isComplete, isTrue);
    });

    test('Resolves Arabic tenses and pronoun conjugations with Tashkeel', () {
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'ar', tense: 'past'),
        equals('كَبَّرَ'),
      );
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'ar', tense: 'present'),
        equals('يُكَبِّرُ'),
      );
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'ar', tense: 'imperative'),
        equals('كَبِّرْ'),
      );
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'ar', tense: 'masdar'),
        equals('تَكْبِيرٌ'),
      );
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'ar', tense: 'past', person: 'ana'),
        equals('كَبَّرْتُ'),
      );
    });

    test('Resolves German tenses and person conjugations', () {
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'de', tense: 'infinitive'),
        equals('vergrößern'),
      );
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'de', tense: 'preterite'),
        equals('vergrößerte'),
      );
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'de', tense: 'participle'),
        equals('vergrößert'),
      );
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'de', tense: 'present', person: 'ich'),
        equals('vergrößere'),
      );
    });

    test('Resolves English tenses and person forms', () {
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'en', tense: 'infinitive'),
        equals('to magnify'),
      );
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'en', tense: 'past'),
        equals('magnified'),
      );
      expect(
        VerbConjugationEngine.resolveForm(magnifyVerb, language: 'en', tense: 'present_3rd'),
        equals('magnifies'),
      );
    });
  });
}
