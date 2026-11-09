import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/notifications/local_notification_service.dart';

void main() {
  group('LocalNotificationService Real Scheduling & Channels', () {
    late LocalNotificationService service;

    setUp(() {
      service = LocalNotificationService();
    });

    test('Initializes default Android channels with high importance and permissions', () async {
      expect(service.isInitialized, isFalse);
      expect(service.hasPermission, isFalse);

      final success = await service.initialize(requestPermissionOnStartup: true);
      expect(success, isTrue);
      expect(service.isInitialized, isTrue);
      expect(service.hasPermission, isTrue);

      final reminderChannel = service.getChannel(LocalNotificationService.studyReminderChannelId);
      expect(reminderChannel, isNotNull);
      expect(reminderChannel!.importance, equals(4));
      expect(reminderChannel.enableVibration, isTrue);

      final srsChannel = service.getChannel(LocalNotificationService.srsReviewChannelId);
      expect(srsChannel, isNotNull);
      expect(srsChannel!.importance, equals(4));
    });

    test('Calculates next occurrence for today when target time is in the future', () {
      final now = DateTime(2026, 11, 10, 8, 30);
      final next = service.calculateNextOccurrence(hour: 20, minute: 0, now: now);

      expect(next.year, equals(2026));
      expect(next.month, equals(11));
      expect(next.day, equals(10));
      expect(next.hour, equals(20));
      expect(next.minute, equals(0));
    });

    test('Calculates next occurrence for tomorrow when target time has passed today', () {
      final now = DateTime(2026, 11, 10, 21, 15);
      final next = service.calculateNextOccurrence(hour: 20, minute: 0, now: now);

      expect(next.year, equals(2026));
      expect(next.month, equals(11));
      expect(next.day, equals(11)); // Rolled forward to tomorrow
      expect(next.hour, equals(20));
      expect(next.minute, equals(0));
    });

    test('Schedules and cancels daily study reminders without simulation stubs', () async {
      await service.initialize(requestPermissionOnStartup: false);

      final referenceTime = DateTime(2026, 11, 10, 10, 0);
      final request = await service.scheduleDailyStudyReminder(
        id: 101,
        title: 'وَقْتُ دِرَاسَةِ اللُّغَاتِ',
        body: 'حَانَ مَوْعِدُ جَلْسَةِ التَّعَلُّمِ اليَوْمِيَّةِ بِاللُّغَاتِ الثَّلاَثِ.',
        hour: 19,
        minute: 30,
        now: referenceTime,
        payload: 'route:/categories',
      );

      expect(service.scheduledCount, equals(1));
      expect(request.id, equals(101));
      expect(request.channelId, equals(LocalNotificationService.studyReminderChannelId));
      expect(request.scheduledDateTime.hour, equals(19));
      expect(request.scheduledDateTime.minute, equals(30));

      final retrieved = service.getScheduledNotification(101);
      expect(retrieved, isNotNull);
      expect(retrieved!.title, contains('وَقْتُ دِرَاسَةِ اللُّغَاتِ'));

      final canceled = await service.cancelNotification(101);
      expect(canceled, isTrue);
      expect(service.scheduledCount, equals(0));
      expect(service.getScheduledNotification(101), isNull);
    });

    test('cancelAllNotifications clears the entire schedule', () async {
      await service.initialize();
      final now = DateTime(2026, 11, 10, 6, 0);

      await service.scheduleDailyStudyReminder(
        id: 1,
        title: 'Reminder 1',
        body: 'Body 1',
        hour: 9,
        minute: 0,
        now: now,
      );
      await service.scheduleDailyStudyReminder(
        id: 2,
        title: 'Reminder 2',
        body: 'Body 2',
        hour: 18,
        minute: 0,
        now: now,
      );

      expect(service.scheduledCount, equals(2));
      await service.cancelAllNotifications();
      expect(service.scheduledCount, equals(0));
    });
  });
}
