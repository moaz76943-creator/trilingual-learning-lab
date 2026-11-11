import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/etymological_cognate_tracker.dart';
import 'package:trilingual_learning_lab/features/vocabulary/presentation/controllers/cognates_studio_controller.dart';

void main() {
  group('CognatesStudioController Transmission Lookups', () {
    late CognatesStudioController controller;

    setUp(() {
      controller = CognatesStudioController();
    });

    test('Initializes with full cognate catalog and available eras', () {
      expect(controller.totalCognates, greaterThanOrEqualTo(5));
      expect(controller.filteredCount, equals(controller.totalCognates));
      expect(controller.searchQuery, isEmpty);
      expect(controller.selectedEraFilter, isNull);
      expect(controller.availableEras.isNotEmpty, isTrue);
    });

    test('Filters cognates by query matching Arabic root or English word', () {
      controller.filterCognates(query: 'عضادة');
      expect(controller.filteredCount, equals(1));
      expect(controller.cognates.first.id, equals('cognate_alidade'));

      controller.filterCognates(query: 'zenith');
      expect(controller.filteredCount, equals(1));
      expect(controller.cognates.first.id, equals('cognate_zenith'));
    });

    test('Filters cognates by historical era', () {
      final era = controller.availableEras.first;
      controller.filterCognates(era: era);
      expect(controller.filteredCount, greaterThan(0));
      for (final c in controller.cognates) {
        expect(c.historicalEra.contains(era), isTrue);
      }
    });

    test('Toggles bookmark status and clears filters', () {
      expect(controller.isBookmarked('cognate_alidade'), isFalse);
      controller.toggleBookmark('cognate_alidade');
      expect(controller.isBookmarked('cognate_alidade'), isTrue);

      controller.filterCognates(query: 'test');
      controller.clearFilters();
      expect(controller.searchQuery, isEmpty);
      expect(controller.selectedEraFilter, isNull);
      expect(controller.filteredCount, equals(controller.totalCognates));
    });
  });
}
