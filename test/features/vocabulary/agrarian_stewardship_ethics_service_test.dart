import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/agrarian_stewardship_ethics_service.dart';

void main() {
  group('AgrarianStewardshipEthicsService Tests', () {
    test('Ensures agrarian stewardship and animal compassion ethics canon', () {
      final canon = AgrarianStewardshipEthicsService.compassionCanon();
      expect(canon.verifyEthicalCompliance(), isTrue);
      expect(canon.ethicalImperatives.length, greaterThanOrEqualTo(4));
      expect(canon.coreTenetAr, contains('إِحْكَامُ نِسَبِ التُّرُوسِ'));
    });
  });
}
