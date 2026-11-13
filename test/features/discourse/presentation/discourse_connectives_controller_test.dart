import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/discourse/presentation/controllers/discourse_connectives_controller.dart';

void main() {
  group('DiscourseConnectivesController - Academic Discourse & Connective Tests', () {
    late DiscourseConnectivesController controller;

    setUp(() {
      controller = DiscourseConnectivesController();
    });

    test('Initial state configures Arabic concession connective (bayda anna)', () {
      final state = controller.state;
      expect(state.selectedLanguage, DiscourseLanguage.arabic);
      expect(state.selectedRelation, RhetoricalRelation.concessionContrast);
      expect(state.selectedConnective.id, 'ar_bayda_anna');
      expect(state.selectedConnective.connectiveText, 'بَيْدَ أَنَّ');
    });

    test('Relation switching updates active connective appropriately', () {
      controller.selectRelation(RhetoricalRelation.causationDeduction);
      expect(controller.state.selectedRelation, RhetoricalRelation.causationDeduction);
      expect(controller.state.selectedConnective.id, 'ar_wa_min_thamma');
    });

    test('Language switching updates catalog to target language connectives', () {
      controller.setLanguage(DiscourseLanguage.german);
      expect(controller.state.selectedLanguage, DiscourseLanguage.german);
      expect(controller.state.selectedConnective.language, DiscourseLanguage.german);

      controller.setLanguage(DiscourseLanguage.english);
      expect(controller.state.selectedLanguage, DiscourseLanguage.english);
      expect(controller.state.selectedConnective.language, DiscourseLanguage.english);
    });

    test('Slot choice evaluation validates correct academic connective', () {
      controller.toggleSlotChallenge();
      expect(controller.state.isInteractiveSlotChallenge, isTrue);

      // Active is 'بَيْدَ أَنَّ'
      final correct = controller.evaluateSlotChoice('بَيْدَ أَنَّ');
      expect(correct, isTrue);
      expect(controller.state.isSlotChallengeCorrect, isTrue);

      final wrong = controller.evaluateSlotChoice('غَيْرَ أَنَّ');
      expect(wrong, isFalse);
      expect(controller.state.isSlotChallengeCorrect, isFalse);
    });

    test('Reset restores pristine state', () {
      controller.setLanguage(DiscourseLanguage.german);
      controller.reset();

      expect(controller.state.selectedLanguage, DiscourseLanguage.arabic);
      expect(controller.state.selectedConnective.id, 'ar_bayda_anna');
    });
  });
}
