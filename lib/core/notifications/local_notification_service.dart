import '../utils/logger.dart';

class ScheduledReminder {
  final int id;
  final String title;
  final String body;
  final int hour;
  final int minute;

  ScheduledReminder({
    required this.id,
    required this.title,
    required this.body,
    required this.hour,
    required this.minute,
  });
}

/// مدير التنبيهات والإشعارات المحلية المجدولة دون استهلاك للبطارية
class LocalNotificationService {
  static final LocalNotificationService _instance = LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final List<ScheduledReminder> _activeReminders = [];

  void initialize() {
    logger.i('تم تهيئة مدير التنبيهات المحلية بنجاح', 'NotificationService');
  }

  void scheduleDailyStudyReminder({
    int id = 101,
    String title = 'وقت المذاكرة اليومية 📖',
    String body = 'لا تنس مراجعة بطاقاتك لليوم في اللغات الثلاث!',
    int hour = 20,
    int minute = 0,
  }) {
    _activeReminders.removeWhere((r) => r.id == id);
    _activeReminders.add(ScheduledReminder(
      id: id,
      title: title,
      body: body,
      hour: hour,
      minute: minute,
    ));
    logger.d('تمت جدولة تنبيه يومي في الساعة $hour:$minute', 'NotificationService');
  }

  void cancelReminder(int id) {
    _activeReminders.removeWhere((r) => r.id == id);
  }

  List<ScheduledReminder> get activeReminders => List.unmodifiable(_activeReminders);
}

final notificationService = LocalNotificationService();
