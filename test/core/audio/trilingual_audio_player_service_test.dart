import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/audio/trilingual_audio_player_service.dart';

void main() {
  group('TrilingualAudioPlayerService Truthful Playback Tests', () {
    late TrilingualAudioPlayerService audioService;

    setUp(() {
      audioService = TrilingualAudioPlayerService();
    });

    tearDown(() async {
      await audioService.stop();
    });

    test('Validates supported trilingual curriculum languages (ar, de, en)', () {
      expect(audioService.isLanguageSupported('ar'), isTrue);
      expect(audioService.isLanguageSupported('de'), isTrue);
      expect(audioService.isLanguageSupported('en'), isTrue);
      expect(audioService.isLanguageSupported('fr'), isFalse);
      expect(audioService.isLanguageSupported('es'), isFalse);
    });

    test('Rejects empty text with explicit, honest error result', () async {
      final result = await audioService.speak(text: '   ', languageCode: 'de');
      expect(result.success, isFalse);
      expect(result.status, equals(AudioPlaybackStatus.error));
      expect(result.errorMessage, contains('النص الصوتي'));
    });

    test('Rejects unsupported language without false success claim', () async {
      final result = await audioService.speak(text: 'Bonjour', languageCode: 'fr');
      expect(result.success, isFalse);
      expect(result.status, equals(AudioPlaybackStatus.unsupported));
      expect(result.errorMessage, contains('غير مثبت'));
    });

    test('Transitions state accurately when valid Arabic text is submitted', () async {
      final result = await audioService.speak(
        text: 'الصِّدْقُ طُمَأْنِينَةٌ',
        languageCode: 'ar',
      );

      expect(result.success, isTrue);
      expect(audioService.isPlaying, isTrue);
      expect(audioService.activeLanguage, equals('ar'));
      expect(audioService.lastSpokenText, equals('الصِّدْقُ طُمَأْنِينَةٌ'));
    });
  });
}
