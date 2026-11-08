import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/irrigation_relief_ethics_service.dart';

void main() {
  group('IrrigationReliefEthicsService Tests', () {
    test('Ensures irrigation relief ethics canon is upheld', () {
      final canon = IrrigationReliefEthicsService.reliefCanon();
      expect(canon.verifyEthicalCompliance(), isTrue);
      expect(canon.ethicalImperatives.length, greaterThanOrEqualTo(4));
      expect(canon.coreTenetAr, contains('تَسْخِيرُ قُوَّةِ المَاءِ'));
    });
  });
}
