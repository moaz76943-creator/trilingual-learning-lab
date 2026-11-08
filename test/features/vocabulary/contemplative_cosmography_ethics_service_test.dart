import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/contemplative_cosmography_ethics_service.dart';

void main() {
  group('ContemplativeCosmographyEthicsService Tests', () {
    test('Ensures contemplative cosmography ethics canon is upheld', () {
      final canon = ContemplativeCosmographyEthicsService.contemplativeCanon();
      expect(canon.verifyEthicalCompliance(), isTrue);
      expect(canon.ethicalImperatives.length, greaterThanOrEqualTo(4));
      expect(canon.coreTenetAr, contains('تَحْوِيلُ أَدَوَاتِ قِيَاسِ الوَقْتِ'));
    });
  });
}
