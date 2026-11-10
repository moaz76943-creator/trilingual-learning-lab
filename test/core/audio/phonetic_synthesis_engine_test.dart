import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/audio/phonetic_synthesis_engine.dart';

void main() {
  group('PhoneticSynthesisEngine Trilingual IPA Mapping', () {
    test('Transcribes vocalized Arabic words with Tashkeel into accurate IPA', () {
      const vocalized = 'الشَّبَكَةُ';
      final transcription = PhoneticSynthesisEngine.transcribeArabic(vocalized);

      expect(transcription.language, equals('ar'));
      expect(transcription.ipa, contains('ʃ')); // Sheen
      expect(transcription.ipa, contains('b')); // Baa
      expect(transcription.ipa, contains('k')); // Kaaf
      expect(transcription.syllableCount, greaterThanOrEqualTo(3));
    });

    test('Transcribes Arabic emphatic and pharyngeal consonants faithfully', () {
      const emphatic = 'الأَسْطُرْلاَبُ';
      final transcription = PhoneticSynthesisEngine.transcribeArabic(emphatic);

      // Must include emphatic /sˤ/ and /tˤ/
      expect(transcription.ipa, contains('sˤ'));
      expect(transcription.ipa, contains('tˤ'));
      expect(transcription.ipa, contains('b'));
    });

    test('Transcribes German words with umlauts and consonant clusters into IPA', () {
      const german = 'Schöpfräder';
      final transcription = PhoneticSynthesisEngine.transcribeGerman(german);

      expect(transcription.language, equals('de'));
      expect(transcription.ipa, contains('ʃ')); // sch -> ʃ
      expect(transcription.ipa, contains('øː')); // ö -> øː
      expect(transcription.ipa, contains('ɛː')); // ä -> ɛː
      expect(transcription.syllableCount, greaterThanOrEqualTo(2));
    });

    test('Transcribes English words into phonetic approximation', () {
      const english = 'The astrolabe plate';
      final transcription = PhoneticSynthesisEngine.transcribeEnglish(english);

      expect(transcription.language, equals('en'));
      expect(transcription.ipa, contains('θ')); // th -> θ
      expect(transcription.syllableCount, greaterThanOrEqualTo(3));
    });

    test('Produces unified trilingual phonetic comparison', () {
      final comparison = PhoneticSynthesisEngine.compare(
        arVocalized: 'العِضَادَةُ',
        deText: 'Die Alhidade',
        enText: 'The Alidade',
      );

      expect(comparison.arabic.ipa, contains('ʕ')); // Ayn -> ʕ
      expect(comparison.german.ipa, contains('diː'));
      expect(comparison.english.ipa, contains('θ'));
    });
  });
}
