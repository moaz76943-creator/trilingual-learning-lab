import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/calligraphic_equity_ethics_service.dart';

void main() {
  group('CalligraphicEquityEthicsService Tests', () {
    test('Ensures visual justice and calligraphic equity canon', () {
      final canon = CalligraphicEquityEthicsService.equityCanon();
      expect(canon.verifyEthicalCompliance(), isTrue);
      expect(canon.ethicalImperatives.length, greaterThanOrEqualTo(4));
      expect(canon.coreTenetAr, contains('إِقَامَةُ العَدْلِ البَصَرِيِّ'));
    });
  });
}
