import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/verbs/domain/services/verb_conjugation_engine.dart';
import 'package:trilingual_learning_lab/features/verbs/presentation/controllers/verb_conjugation_controller.dart';

void main() {
  group('VerbConjugationController Interactive Studio State', () {
    late TrilingualVerbParadigm testParadigm;
    late VerbConjugationController controller;

    setUp(() {
      testParadigm = TrilingualVerbParadigm.magnify();
      controller = VerbConjugationController(paradigm: testParadigm);
    });

    test('Initializes with past tense tab and correct root', () {
      expect(controller.activeTab, equals(VerbTenseTab.past));
      expect(controller.rootAr, equals('ك - ب - ر'));
      expect(controller.activeArabicForm, equals('كَبَّرَ'));
      expect(controller.activeGermanForm, equals('vergrößerte'));
      expect(controller.activeEnglishForm, equals('magnified'));
      expect(controller.isBookmarked, isFalse);
    });

    test('Switches tense tabs and resolves corresponding forms', () {
      // 1. Present
      controller.selectTab(VerbTenseTab.present);
      expect(controller.activeTab, equals(VerbTenseTab.present));
      expect(controller.activeArabicForm, equals('يُكَبِّرُ'));

      // 2. Imperative
      controller.selectTab(VerbTenseTab.imperative);
      expect(controller.activeTab, equals(VerbTenseTab.imperative));
      expect(controller.activeArabicForm, equals('كَبِّرْ'));

      // 3. Verbal Noun (Masdar)
      controller.selectTab(VerbTenseTab.verbalNoun);
      expect(controller.activeTab, equals(VerbTenseTab.verbalNoun));
      expect(controller.activeArabicForm, equals('تَكْبِيرٌ'));
    });

    test('Generates complete trilingual pronoun declension rows', () {
      final rows = controller.declensionRows;
      expect(rows.length, equals(4));

      final anaRow = rows.firstWhere((r) => r['key'] == 'ana');
      expect(anaRow['pronounAr'], equals('أَنَا'));
      expect(anaRow['formAr'], equals('كَبَّرْتُ'));
      expect(anaRow['pronounDe'], equals('ich'));
    });

    test('Toggles bookmark status', () {
      expect(controller.isBookmarked, isFalse);
      controller.toggleBookmark();
      expect(controller.isBookmarked, isTrue);
      controller.toggleBookmark();
      expect(controller.isBookmarked, isFalse);
    });
  });
}
