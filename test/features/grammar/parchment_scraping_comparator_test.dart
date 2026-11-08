import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/grammar/domain/services/parchment_scraping_comparator.dart';

void main() {
  group('ParchmentScrapingComparator Tests', () {
    test('Validates trilingual parchment scraping alignment', () {
      final model = ParchmentScrapingComparator.parchmentModel();
      expect(model.validateTrilingualAlignment(), isTrue);
      expect(model.parchmentStructures['ar'], contains('سِكِّينُ الهِلاَلِ'));
      expect(model.parchmentStructures['de'], contains('Schabemesser'));
      expect(model.parchmentStructures['en'], contains('semi-lunar knife'));
    });
  });
}
