import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/rhetoric/presentation/controllers/rhetorical_figures_controller.dart';

void main() {
  group('RhetoricalFiguresController Tests', () {
    late RhetoricalFiguresController controller;

    setUp(() {
      controller = RhetoricalFiguresController();
    });

    test('Initializes with default catalogue across rhetoric domains', () {
      final state = controller.state;
      expect(state.examples.isNotEmpty, isTrue);
      expect(state.selectedDomain, equals(RhetoricalDomain.metaphor));
      expect(state.currentExample, isNotNull);
      expect(state.currentExample?.deviceNameAr, contains('الاسْتِعَارَةُ'));
    });

    test('Transitions smoothly across rhetorical domains', () {
      controller.selectDomain(RhetoricalDomain.chiasmusAntithesis);
      expect(controller.state.selectedDomain, equals(RhetoricalDomain.chiasmusAntithesis));
      expect(controller.state.currentExample?.domain, equals(RhetoricalDomain.chiasmusAntithesis));
      expect(controller.state.currentExample?.salientKeywordsAr.contains('اللَّيْلِ'), isTrue);
    });

    test('Toggles deconstruction and stylistic impact score', () {
      controller.adjustStylisticImpact(0.95);
      expect(controller.state.stylisticImpactScore, equals(0.95));

      controller.toggleDeconstruction();
      expect(controller.state.showDeconstruction, isFalse);

      controller.toggleTrilingualComparison();
      expect(controller.state.showTrilingualComparison, isFalse);
    });
  });
}
