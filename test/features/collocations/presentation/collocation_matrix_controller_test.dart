import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/collocations/presentation/controllers/collocation_matrix_controller.dart';

void main() {
  group('CollocationMatrixController Tests', () {
    late CollocationMatrixController controller;

    setUp(() {
      controller = CollocationMatrixController();
    });

    test('Initializes with default collocation catalogue', () {
      final state = controller.state;
      expect(state.entries.isNotEmpty, isTrue);
      expect(state.selectedCategory, equals(CollocationCategory.adjectiveNoun));
      expect(state.currentEntry, isNotNull);
      expect(state.currentEntry?.canonicalCollocationAr, contains('مَطَرٌ غَزِيرٌ'));
    });

    test('Transitions smoothly across collocation categories', () {
      controller.selectCategory(CollocationCategory.verbNounSupport);
      expect(controller.state.selectedCategory, equals(CollocationCategory.verbNounSupport));
      expect(controller.state.currentEntry?.category, equals(CollocationCategory.verbNounSupport));
      expect(controller.state.currentEntry?.canonicalCollocationAr, contains('اتَّخَذَ قَرَاراً'));
    });

    test('Toggles negative transfer alerts and corpus concordance', () {
      controller.toggleNegativeTransferAlerts();
      expect(controller.state.showNegativeTransferAlerts, isFalse);

      controller.toggleCorpusConcordance();
      expect(controller.state.showCorpusConcordance, isFalse);
    });
  });
}
