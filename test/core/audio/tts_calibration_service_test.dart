import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/audio/tts_calibration_service.dart';

void main() {
  group('TtsCalibrationService Acoustic Profiles & Timing', () {
    late TtsCalibrationService service;

    setUp(() {
      service = TtsCalibrationService();
    });

    test('Provides distinct calibrated profiles for Arabic, German, and English', () {
      final arProfile = service.getProfile('ar');
      final deProfile = service.getProfile('de');
      final enProfile = service.getProfile('en');

      expect(arProfile.speechRate, equals(0.80)); // Slower for Tashkeel
      expect(arProfile.pitch, equals(0.95));

      expect(deProfile.speechRate, equals(0.85)); // Compound clarity
      expect(enProfile.speechRate, equals(0.90));
    });

    test('Resolves localized language sub-tags to primary language profile', () {
      final arSa = service.getProfile('ar-SA');
      final deDe = service.getProfile('de_DE');

      expect(arSa.languageCode, equals('ar'));
      expect(deDe.languageCode, equals('de'));
    });

    test('Prepares text for synthesis by normalizing spaces and punctuation', () {
      const raw = 'إِذَا صَوَّبَ المَسَّاحُ ،خَيْطَ الشَّاقُولِ   :عَلَى المُرَبَّعِ.';
      final cleaned = service.prepareTextForSynthesis(raw, 'ar');

      expect(cleaned, contains('، '));
      expect(cleaned, contains(': '));
      expect(cleaned.contains('   '), isFalse);
    });

    test('Estimates duration proportional to speech rate and word count', () {
      const text = 'نَقْشُ شَبَكَةِ الجُيُوبِ وَمُرَبَّعِ الظِّلِّ عَلَى الرُّبْعِ النُّحَاسِيِّ';
      final durationAr = service.estimateDuration(text, 'ar');
      final durationEn = service.estimateDuration('Engraving the sine grid on brass quadrant', 'en');

      expect(durationAr.inMilliseconds, greaterThan(1500));
      expect(durationEn.inMilliseconds, greaterThan(1000));
    });
  });
}
