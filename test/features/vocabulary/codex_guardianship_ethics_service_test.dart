import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/codex_guardianship_ethics_service.dart';

void main() {
  group('CodexGuardianshipEthicsService Tests', () {
    test('Ensures codex guardianship and scriptorium reverence ethics canon', () {
      final canon = CodexGuardianshipEthicsService.guardianshipCanon();
      expect(canon.verifyEthicalCompliance(), isTrue);
      expect(canon.ethicalImperatives.length, greaterThanOrEqualTo(4));
      expect(canon.coreTenetAr, contains('إِكْرَامُ كَلِمَاتِ الحِكْمَةِ'));
    });
  });
}
