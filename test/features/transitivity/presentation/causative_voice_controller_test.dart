import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/transitivity/presentation/controllers/causative_voice_controller.dart';

void main() {
  group('CausativeVoiceController Tests', () {
    late CausativeVoiceController controller;

    setUp(() {
      controller = CausativeVoiceController();
    });

    test('Initializes with default transitivity catalogue', () {
      final state = controller.state;
      expect(state.pairs.isNotEmpty, isTrue);
      expect(state.selectedPattern, equals(TransitivityPattern.causativeDerivation));
      expect(state.currentPair, isNotNull);
      expect(state.currentPair?.causativeOrDerivedAr, contains('أَنْزَلَ'));
    });

    test('Transitions smoothly across transitivity patterns', () {
      controller.selectPattern(TransitivityPattern.inchoativeAnticausative);
      expect(controller.state.selectedPattern, equals(TransitivityPattern.inchoativeAnticausative));
      expect(controller.state.currentPair?.pattern, equals(TransitivityPattern.inchoativeAnticausative));
      expect(controller.state.currentPair?.causativeOrDerivedAr, contains('انْكَسَرَ'));
    });

    test('Toggles valency analysis and morphological derivation views', () {
      controller.toggleValencyAnalysis();
      expect(controller.state.showValencyAnalysis, isFalse);

      controller.toggleMorphologicalDerivation();
      expect(controller.state.showMorphologicalDerivation, isFalse);
    });
  });
}
