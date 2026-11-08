import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/public_horology_ethics_service.dart';

void main() {
  group('PublicHorologyEthicsService Tests', () {
    test('Ensures public horology civic equity canon is upheld', () {
      final canon = PublicHorologyEthicsService.civicEquityCanon();
      expect(canon.verifyEthicalCompliance(), isTrue);
      expect(canon.ethicalImperatives.length, greaterThanOrEqualTo(4));
      expect(canon.coreTenetAr, contains('إِتَاحَةُ مَعْرِفَةِ الوَقْتِ'));
    });
  });
}
