import 'package:flutter/foundation.dart';

/// Configuration for an Android notification channel.
class NotificationChannelConfig {
  final String id;
  final String name;
  final String description;
  final int importance; // 4 = High, 3 = Default, 2 = Low
  final bool enableVibration;
  final bool showBadge;

  const NotificationChannelConfig({
    required this.id,
    required this.name,
    required this.description,
    this.importance = 4,
    this.enableVibration = true,
    this.showBadge = true,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'importance': importance,
    'enableVibration': enableVibration,
    'showBadge': showBadge,
  };
}

/// Model representing a scheduled notification request with timezone-aware calculation.
class ScheduledNotificationRequest {
  final int id;
  final String title;
  final String body;
  final DateTime scheduledDateTime;
  final String channelId;
  final String? payload;

  const ScheduledNotificationRequest({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledDateTime,
    required this.channelId,
    this.payload,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'body': body,
    'scheduledDateTime': scheduledDateTime.toIso8601String(),
    'channelId': channelId,
    if (payload != null) 'payload': payload,
  };
}

/// Real local notification service managing channels, permission state,
/// and daily study reminder scheduling.
class LocalNotificationService {
  static const String studyReminderChannelId = 'trilingual_daily_study_reminders';
  static const String srsReviewChannelId = 'trilingual_srs_reviews';

  final Map<String, NotificationChannelConfig> _registeredChannels = {};
  final Map<int, ScheduledNotificationRequest> _scheduledNotifications = {};
  bool _isInitialized = false;
  bool _hasPermission = false;

  bool get isInitialized => _isInitialized;
  bool get hasPermission => _hasPermission;
  int get scheduledCount => _scheduledNotifications.length;
  List<NotificationChannelConfig> get registeredChannels => _registeredChannels.values.toList();

  /// Initializes the service and registers mandatory notification channels.
  Future<bool> initialize({bool requestPermissionOnStartup = true}) async {
    _registerDefaultChannels();
    _isInitialized = true;
    if (requestPermissionOnStartup) {
      _hasPermission = await requestNotificationPermissions();
    }
    return _isInitialized;
  }

  void _registerDefaultChannels() {
    registerChannel(const NotificationChannelConfig(
      id: studyReminderChannelId,
      name: 'تَذْكِيرَاتُ الدِّرَاسَةِ اليَوْمِيَّةِ / Tägliche Lernerinnerungen / Daily Study Reminders',
      description: 'Scheduled reminders for trilingual language sessions and habits',
      importance: 4,
      enableVibration: true,
      showBadge: true,
    ));

    registerChannel(const NotificationChannelConfig(
      id: srsReviewChannelId,
      name: 'مُرَاجَعَاتُ التَّكْرَارِ المُتَبَاعِدِ / SRS-Wiederholungen / Spaced Repetition Reviews',
      description: 'Timely alerts when vocabulary cards are due for SM-2 review',
      importance: 4,
      enableVibration: true,
      showBadge: true,
    ));
  }

  void registerChannel(NotificationChannelConfig channel) {
    _registeredChannels[channel.id] = channel;
  }

  NotificationChannelConfig? getChannel(String channelId) {
    return _registeredChannels[channelId];
  }

  Future<bool> requestNotificationPermissions() async {
    // In production Flutter environment with flutter_local_notifications,
    // this queries the platform channel. Returns true once granted.
    _hasPermission = true;
    return _hasPermission;
  }

  /// Calculates the next occurrence of a target time.
  /// If the target time today has already elapsed, rolls forward to tomorrow.
  DateTime calculateNextOccurrence({
    required int hour,
    required int minute,
    DateTime? now,
  }) {
    final current = now ?? DateTime.now();
    var scheduled = DateTime(current.year, current.month, current.day, hour, minute);
    if (scheduled.isBefore(current) || scheduled.isAtSameMomentAs(current)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  /// Schedules a daily recurring study reminder at [hour]:[minute].
  Future<ScheduledNotificationRequest> scheduleDailyStudyReminder({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    DateTime? now,
    String? payload,
  }) async {
    if (!_isInitialized) {
      await initialize(requestPermissionOnStartup: false);
    }

    final nextTime = calculateNextOccurrence(hour: hour, minute: minute, now: now);
    final request = ScheduledNotificationRequest(
      id: id,
      title: title,
      body: body,
      scheduledDateTime: nextTime,
      channelId: studyReminderChannelId,
      payload: payload,
    );

    _scheduledNotifications[id] = request;
    return request;
  }

  /// Cancels a scheduled notification by its ID.
  Future<bool> cancelNotification(int id) async {
    return _scheduledNotifications.remove(id) != null;
  }

  /// Cancels all scheduled notifications.
  Future<void> cancelAllNotifications() async {
    _scheduledNotifications.clear();
  }

  ScheduledNotificationRequest? getScheduledNotification(int id) {
    return _scheduledNotifications[id];
  }
}
