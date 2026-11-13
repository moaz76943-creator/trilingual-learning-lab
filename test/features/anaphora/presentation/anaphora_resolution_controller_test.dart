import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/anaphora/presentation/controllers/anaphora_resolution_controller.dart';

void main() {
  group('AnaphoraResolutionController - Trilingual Anaphora Resolution Tests', () {
    late AnaphoraResolutionController controller;

    setUp(() {
      controller = AnaphoraResolutionController();
    });

    test('Initial state configures Arabic manuscript passage with active clitic pronoun', () {
      final state = controller.state;
      expect(state.selectedLanguage, AnaphoraLanguage.arabic);
      expect(state.selectedPassage.id, 'ar_alhaytham_manazir');
      expect(state.activeSelectedTokenIndex, 4); // 'وملأها'
      expect(state.activeToken!.isPronounOrParticiple, isTrue);
      expect(state.activeAntecedent!.wordText, 'الزُّجَاجِيَّةَ');
    });

    test('Token selection updates active token and accurately resolves antecedent index', () {
      // Select token index 2 ('أُسْطُوَانَتَهُ') whose antecedent is index 1 ('ابن الهيثم')
      controller.selectToken(2);

      expect(controller.state.activeSelectedTokenIndex, 2);
      expect(controller.state.activeToken!.wordText, 'أُسْطُوَانَتَهُ');
      expect(controller.state.activeAntecedent!.wordText, 'ابْنُ الْهَيْثَمِ');
    });

    test('German passage contains extended participial attribute and relative unfolding alternative', () {
      controller.setLanguage(AnaphoraLanguage.german);
      expect(controller.state.selectedLanguage, AnaphoraLanguage.german);
      expect(controller.state.selectedPassage.id, 'de_partizip_alhaytham');
      expect(controller.state.selectedPassage.unfoldedAlternativeText, isNotNull);

      // Toggle unfolded view
      controller.toggleUnfoldedView();
      expect(controller.state.isUnfoldedViewActive, isTrue);
    });

    test('Selecting non-pronoun token returns null antecedent', () {
      // Token index 0 ('وضع' verb) has no antecedent
      controller.selectToken(0);
      expect(controller.state.activeAntecedent, isNull);
    });

    test('Passage switching updates active passage and clears active index', () {
      final second = ComplexPassage.passages[1];
      controller.selectPassage(second);

      expect(controller.state.selectedPassage.id, 'de_partizip_alhaytham');
      expect(controller.state.activeSelectedTokenIndex, isNull);
    });

    test('Reset restores pristine state', () {
      controller.setLanguage(AnaphoraLanguage.german);
      controller.reset();

      expect(controller.state.selectedLanguage, AnaphoraLanguage.arabic);
      expect(controller.state.selectedPassage.id, 'ar_alhaytham_manazir');
    });
  });
}
