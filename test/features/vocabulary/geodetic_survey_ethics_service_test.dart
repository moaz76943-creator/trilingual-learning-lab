import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/features/vocabulary/domain/services/geodetic_survey_ethics_service.dart';

void main() {
  group('GeodeticSurveyEthicsService Tests', () {
    test('Ensures geodetic survey justice canon and impartiality', () {
      final canon = GeodeticSurveyEthicsService.geodeticJusticeCanon();
      expect(canon.verifyEthicalCompliance(), isTrue);
      expect(canon.ethicalImperatives.length, greaterThanOrEqualTo(4));
      expect(canon.coreTenetAr, contains('إِقَامَةُ العَدْلِ فِي قِسْمَةِ الأَرَاضِي'));
    });
  });
}
