import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/nib_mastery_ethics_service.dart';

void main() {
  group('NibMasteryEthicsService Tests', () {
    test('Ensures decisive mastery and instrument reverence ethics canon', () {
      final canon = NibMasteryEthicsService.resolveCanon();
      expect(canon.verifyEthicalCompliance(), isTrue);
      expect(canon.ethicalImperatives.length, greaterThanOrEqualTo(4));
      expect(canon.coreTenetAr, contains('شَحْذُ العَزِيمَةِ'));
    });
  });
}
