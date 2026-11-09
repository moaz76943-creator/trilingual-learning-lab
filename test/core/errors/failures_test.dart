import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/errors/failures.dart';

void main() {
  group('Failure Domain Models & Trilingual Localization', () {
    test('StorageFailure resolves localized messages correctly', () {
      const failure = StorageFailure();
      expect(failure.code, equals('STORAGE_FAILURE'));
      expect(failure.getLocalizedMessage('ar'), contains('تَعَذَّرَ حِفْظُ'));
      expect(failure.getLocalizedMessage('de'), contains('Fehler beim Speichern'));
      expect(failure.getLocalizedMessage('en'), contains('Failed to persist'));
      expect(failure.getLocalizedMessage('fr'), equals(failure.messageEn)); // Fallback
    });

    test('ContentNotFoundFailure formats entityId into messages', () {
      final failure = ContentNotFoundFailure(entityId: 'astrolabe_001');
      expect(failure.code, equals('CONTENT_NOT_FOUND'));
      expect(failure.getLocalizedMessage('ar'), contains('astrolabe_001'));
      expect(failure.getLocalizedMessage('de'), contains('astrolabe_001'));
      expect(failure.getLocalizedMessage('en'), contains('astrolabe_001'));
    });

    test('CorruptedDataFailure retains original exception for debugging', () {
      final innerError = Exception('Checksum mismatch 0xFA');
      final failure = CorruptedDataFailure(originalError: innerError);

      expect(failure.originalError, equals(innerError));
      expect(failure.code, equals('CORRUPTED_DATA'));
    });

    test('AudioPlaybackFailure exposes target language code', () {
      final failure = AudioPlaybackFailure(languageCode: 'ar-SA');
      expect(failure.languageCode, equals('ar-SA'));
      expect(failure.getLocalizedMessage('ar'), contains('ar-SA'));
    });

    test('ValidationFailure surfaces field name and custom details', () {
      final failure = ValidationFailure(
        fieldName: 'ease_factor',
        detailAr: 'يَجِبُ أَنْ يَكُونَ أَكْبَرَ مِنْ 1.3',
        detailDe: 'muss größer als 1.3 sein',
        detailEn: 'must be greater than 1.3',
      );

      expect(failure.code, equals('VALIDATION_FAILED'));
      expect(failure.getLocalizedMessage('ar'), contains('ease_factor'));
      expect(failure.getLocalizedMessage('ar'), contains('1.3'));
    });
  });
}
