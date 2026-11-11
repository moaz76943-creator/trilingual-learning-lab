import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/audio/audio_subtitle_synchronizer.dart';
import 'package:trilingual_learning_lab/core/audio/speech_overflow_guard.dart';

void main() {
  group('AudioSubtitleSynchronizer & SpeechOverflowGuard Critical Verification', () {
    test('Builds syllable-weighted subtitle track for vocalized Arabic', () {
      const arabicSentence = 'صِنَاعَةُ الأَسْطُرْلاَبِ النُّحَاسِيِّ';
      final track = AudioSubtitleSynchronizer.buildTrack(
        text: arabicSentence,
        languageCode: 'ar',
      );

      expect(track.cues.length, equals(3));
      expect(track.cues[0].word, equals('صِنَاعَةُ'));
      expect(track.cues[1].word, equals('الأَسْطُرْلاَبِ'));
      expect(track.cues[2].word, equals('النُّحَاسِيِّ'));

      // Verify non-overlapping sequential timeline
      expect(track.cues[0].endMs, lessThan(track.cues[1].startMs));
      expect(track.cues[1].endMs, lessThan(track.cues[2].startMs));
      expect(track.totalDurationMs, greaterThan(track.cues[2].endMs));
    });

    test('Resolves active cue at specific millisecond positions', () {
      const text = 'Das Messingastrolabium';
      final track = AudioSubtitleSynchronizer.buildTrack(
        text: text,
        languageCode: 'de',
      );

      expect(track.cues.length, equals(2));
      final cue1 = track.cues[0];
      final midPoint = (cue1.startMs + cue1.endMs) ~/ 2;

      final active = track.getActiveCue(midPoint);
      expect(active, isNotNull);
      expect(active!.word, equals('Das'));
    });

    test('SpeechOverflowGuard cancels previous speech token on new acquisition', () {
      final guard = SpeechOverflowGuard();
      expect(guard.hasActiveSpeech, isFalse);

      guard.acquireSpeechLock(101);
      expect(guard.hasActiveSpeech, isTrue);
      expect(guard.activePlaybackToken, equals(101));

      // New token preempts previous
      guard.acquireSpeechLock(102);
      expect(guard.activePlaybackToken, equals(102));

      guard.releaseSpeechLock();
      expect(guard.hasActiveSpeech, isFalse);
    });

    test('SpeechOverflowGuard dynamically scales font size to avoid mobile viewport clipping', () {
      const longGermanWord = 'Geschwindigkeitsregulierungsmechanismus';

      // Width 400px: plenty of room -> returns default 22px
      final largeSize = SpeechOverflowGuard.calculateSafeFontSize(
        text: longGermanWord,
        availableWidth: 400.0,
        defaultFontSize: 22.0,
        maxLines: 2,
      );
      expect(largeSize, equals(22.0));

      // Width 120px: narrow constraint -> scales down font size safely
      final constrainedSize = SpeechOverflowGuard.calculateSafeFontSize(
        text: longGermanWord,
        availableWidth: 120.0,
        defaultFontSize: 22.0,
        minimumFontSize: 12.0,
        maxLines: 1,
      );
      expect(constrainedSize, lessThan(22.0));
      expect(constrainedSize, greaterThanOrEqualTo(12.0));
    });
  });
}
