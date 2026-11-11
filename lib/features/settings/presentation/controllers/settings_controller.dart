import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../../core/audio/local_audio_cache_manager.dart';
import '../../../../core/audio/tts_calibration_service.dart';
import '../../../../core/backup/sovereign_backup_service.dart';
import '../../../../core/notifications/local_notification_service.dart';

/// User learning preferences and audio configuration model.
class UserAppSettings {
  final int dailyReviewTarget;
  final int dailyNewCardsTarget;
  final int reminderHour;
  final int reminderMinute;
  final bool enableNotifications;
  final double speechRateAr;
  final double speechRateDe;
  final double speechRateEn;

  const UserAppSettings({
    this.dailyReviewTarget = 20,
    this.dailyNewCardsTarget = 10,
    this.reminderHour = 20,
    this.reminderMinute = 0,
    this.enableNotifications = true,
    this.speechRateAr = 0.80,
    this.speechRateDe = 0.85,
    this.speechRateEn = 0.90,
  });

  UserAppSettings copyWith({
    int? dailyReviewTarget,
    int? dailyNewCardsTarget,
    int? reminderHour,
    int? reminderMinute,
    bool? enableNotifications,
    double? speechRateAr,
    double? speechRateDe,
    double? speechRateEn,
  }) {
    return UserAppSettings(
      dailyReviewTarget: dailyReviewTarget ?? this.dailyReviewTarget,
      dailyNewCardsTarget: dailyNewCardsTarget ?? this.dailyNewCardsTarget,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      speechRateAr: speechRateAr ?? this.speechRateAr,
      speechRateDe: speechRateDe ?? this.speechRateDe,
      speechRateEn: speechRateEn ?? this.speechRateEn,
    );
  }

  Map<String, dynamic> toMap() => {
    'daily_review_target': dailyReviewTarget,
    'daily_new_cards_target': dailyNewCardsTarget,
    'reminder_hour': reminderHour,
    'reminder_minute': reminderMinute,
    'enable_notifications': enableNotifications,
    'speech_rate_ar': speechRateAr,
    'speech_rate_de': speechRateDe,
    'speech_rate_en': speechRateEn,
  };

  factory UserAppSettings.fromMap(Map<String, dynamic> map) {
    return UserAppSettings(
      dailyReviewTarget: map['daily_review_target'] as int? ?? 20,
      dailyNewCardsTarget: map['daily_new_cards_target'] as int? ?? 10,
      reminderHour: map['reminder_hour'] as int? ?? 20,
      reminderMinute: map['reminder_minute'] as int? ?? 0,
      enableNotifications: map['enable_notifications'] as bool? ?? true,
      speechRateAr: (map['speech_rate_ar'] as num?)?.toDouble() ?? 0.80,
      speechRateDe: (map['speech_rate_de'] as num?)?.toDouble() ?? 0.85,
      speechRateEn: (map['speech_rate_en'] as num?)?.toDouble() ?? 0.90,
    );
  }
}

/// Controller managing application settings, notifications, cache, and data sovereignty backups.
class SettingsController extends ChangeNotifier {
  final LocalAudioCacheManager audioCacheManager;
  final TtsCalibrationService ttsService;
  final LocalNotificationService notificationService;

  UserAppSettings _settings;
  String? _lastExportedBackup;
  bool _isExporting = false;

  SettingsController({
    required this.audioCacheManager,
    required this.ttsService,
    required this.notificationService,
    UserAppSettings initialSettings = const UserAppSettings(),
  }) : _settings = initialSettings;

  UserAppSettings get settings => _settings;
  String? get lastExportedBackup => _lastExportedBackup;
  bool get isExporting => _isExporting;
  int get cachedAudioBytes => audioCacheManager.currentCacheSizeBytes;
  int get cachedAudioCount => audioCacheManager.cachedFilesCount;

  /// Updates daily study goals.
  void updateDailyTargets({int? reviewTarget, int? newCardsTarget}) {
    _settings = _settings.copyWith(
      dailyReviewTarget: reviewTarget,
      dailyNewCardsTarget: newCardsTarget,
    );
    notifyListeners();
  }

  /// Updates notification reminder time and reschedules notification.
  Future<void> updateReminderSchedule(int hour, int minute) async {
    _settings = _settings.copyWith(reminderHour: hour, reminderMinute: minute);
    notifyListeners();

    if (_settings.enableNotifications) {
      await notificationService.scheduleDailyStudyReminder(
        id: 1,
        title: 'وَقْتُ دِرَاسَةِ اللُّغَاتِ الثَّلاَثِ',
        body: 'حَانَ مَوْعِدُ جَلْسَةِ التَّعَلُّمِ اليَوْمِيَّةِ لِتَثْبِيتِ المُفْرَدَاتِ.',
        hour: hour,
        minute: minute,
      );
    }
  }

  /// Updates TTS speech rates for specific language.
  void updateSpeechRate(String languageCode, double rate) {
    if (languageCode == 'ar') {
      _settings = _settings.copyWith(speechRateAr: rate);
      final profile = ttsService.getProfile('ar').copyWith(speechRate: rate);
      ttsService.setProfile(profile);
    } else if (languageCode == 'de') {
      _settings = _settings.copyWith(speechRateDe: rate);
      final profile = ttsService.getProfile('de').copyWith(speechRate: rate);
      ttsService.setProfile(profile);
    } else if (languageCode == 'en') {
      _settings = _settings.copyWith(speechRateEn: rate);
      final profile = ttsService.getProfile('en').copyWith(speechRate: rate);
      ttsService.setProfile(profile);
    }
    notifyListeners();
  }

  /// Clears the local audio cache.
  void clearAudioCache() {
    audioCacheManager.clear();
    notifyListeners();
  }

  /// Generates a tamper-proof SHA-256 backup payload of all user data.
  Future<String> exportSovereignBackup({
    required Map<String, dynamic> progressData,
    required List<Map<String, dynamic>> srsCards,
  }) async {
    _isExporting = true;
    notifyListeners();

    final jsonPayload = SovereignBackupService.exportToJson(
      progress: progressData,
      srsCards: srsCards,
      settings: _settings.toMap(),
    );

    _lastExportedBackup = jsonPayload;
    _isExporting = false;
    notifyListeners();
    return jsonPayload;
  }

  /// Verifies and imports a backup string, updating settings if valid.
  SovereignBackupData importSovereignBackup(String rawJson) {
    final restored = SovereignBackupService.importFromJson(rawJson);
    if (restored.settings.isNotEmpty) {
      _settings = UserAppSettings.fromMap(restored.settings);
      notifyListeners();
    }
    return restored;
  }
}
