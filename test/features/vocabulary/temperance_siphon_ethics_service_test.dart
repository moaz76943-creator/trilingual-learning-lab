import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/temperance_siphon_ethics_service.dart';

void main() {
  group('TemperanceSiphonEthicsService Tests', () {
    test('Ensures temperance siphon ethics canon is upheld', () {
      final canon = TemperanceSiphonEthicsService.temperanceCanon();
      expect(canon.verifyEthicalCompliance(), isTrue);
      expect(canon.ethicalImperatives.length, greaterThanOrEqualTo(4));
      expect(canon.coreTenetAr, contains('تَسْخِيرُ الحِيَلِ الهَيْدْرُولِيكِيَّةِ'));
    });
  });
}
