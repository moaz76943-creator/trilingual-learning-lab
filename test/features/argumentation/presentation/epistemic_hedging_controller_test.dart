import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/argumentation/presentation/controllers/epistemic_hedging_controller.dart';

void main() {
  group('EpistemicHedgingController Tests', () {
    late EpistemicHedgingController controller;

    setUp(() {
      controller = EpistemicHedgingController();
    });

    test('Initializes with default argumentative catalogue', () {
      final state = controller.state;
      expect(state.units.isNotEmpty, isTrue);
      expect(state.selectedCertainty, equals(EpistemicCertaintyLevel.cautiousTentative));
      expect(state.currentUnit, isNotNull);
      expect(state.currentUnit?.scholarlyHedgingAr, contains('المُعْطَيَاتِ'));
    });

    test('Transitions smoothly across epistemic certainty levels', () {
      controller.selectCertainty(EpistemicCertaintyLevel.concessiveHypothetical);
      expect(controller.state.selectedCertainty, equals(EpistemicCertaintyLevel.concessiveHypothetical));
      expect(controller.state.currentUnit?.certaintyLevel, equals(EpistemicCertaintyLevel.concessiveHypothetical));
      expect(controller.state.currentUnit?.scholarlyHedgingAr, contains('سَلَّمْنَا جَدَلاً'));
    });

    test('Toggles Toulmin breakdown and contrastive markers', () {
      controller.toggleToulminBreakdown();
      expect(controller.state.showToulminBreakdown, isFalse);

      controller.toggleContrastiveMarkers();
      expect(controller.state.showContrastiveMarkers, isFalse);
    });
  });
}
