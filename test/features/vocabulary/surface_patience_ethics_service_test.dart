import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/surface_patience_ethics_service.dart';

void main() {
  group('SurfacePatienceEthicsService Tests', () {
    test('Ensures groundwork patience and surface preparation ethics canon', () {
      final canon = SurfacePatienceEthicsService.groundworkCanon();
      expect(canon.verifyEthicalCompliance(), isTrue);
      expect(canon.ethicalImperatives.length, greaterThanOrEqualTo(4));
      expect(canon.coreTenetAr, contains('إِحْكَامُ التَّهْيِئَةِ الخَفِيَّةِ'));
    });
  });
}
