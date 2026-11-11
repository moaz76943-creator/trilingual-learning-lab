import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/audio/local_audio_cache_manager.dart';
import 'package:trilingual_learning_lab/core/audio/tts_calibration_service.dart';
import 'package:trilingual_learning_lab/core/notifications/local_notification_service.dart';
import 'package:trilingual_learning_lab/features/settings/presentation/controllers/settings_controller.dart';

void main() {
  group('SettingsController Data Sovereignty & Preferences', () {
    late LocalAudioCacheManager audioCache;
    late TtsCalibrationService tts;
    late LocalNotificationService notifications;
    late SettingsController controller;

    setUp(() {
      audioCache = LocalAudioCacheManager(maxCacheSizeBytes: 5000);
      tts = TtsCalibrationService();
      notifications = LocalNotificationService();

      controller = SettingsController(
        audioCacheManager: audioCache,
        ttsService: tts,
        notificationService: notifications,
      );
    });

    test('Initializes with default sovereign settings', () {
      expect(controller.settings.dailyReviewTarget, equals(20));
      expect(controller.settings.dailyNewCardsTarget, equals(10));
      expect(controller.settings.speechRateAr, equals(0.80));
      expect(controller.settings.speechRateDe, equals(0.85));
      expect(controller.settings.speechRateEn, equals(0.90));
    });

    test('Updates daily review targets and speech rates', () {
      controller.updateDailyTargets(reviewTarget: 35, newCardsTarget: 15);
      expect(controller.settings.dailyReviewTarget, equals(35));
      expect(controller.settings.dailyNewCardsTarget, equals(15));

      controller.updateSpeechRate('ar', 0.75);
      expect(controller.settings.speechRateAr, equals(0.75));
      expect(tts.getProfile('ar').speechRate, equals(0.75));
    });

    test('Generates cryptographic backup with verified SHA-256 and imports it', () async {
      final exportJson = await controller.exportSovereignBackup(
        progressData: {'streak': 22},
        srsCards: [
          {'id': 'test_card', 'interval': 4}
        ],
      );

      expect(exportJson.contains('checksum'), isTrue);
      expect(exportJson.contains('streak'), isTrue);
      expect(controller.lastExportedBackup, equals(exportJson));

      final restored = controller.importSovereignBackup(exportJson);
      expect(restored.schemaVersion, equals(1));
      expect(restored.progress['streak'], equals(22));
    });

    test('Clears audio cache index', () {
      audioCache.put(key: 'key1', filePath: '/a.mp3', byteSize: 300);
      expect(controller.cachedAudioCount, equals(1));
      expect(controller.cachedAudioBytes, equals(300));

      controller.clearAudioCache();
      expect(controller.cachedAudioCount, equals(0));
      expect(controller.cachedAudioBytes, equals(0));
    });
  });
}
