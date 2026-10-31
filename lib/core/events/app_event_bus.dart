import 'dart:async';

/// الصنف الأساسي لكافة أحداث التطبيق النواتية
abstract class AppEvent {
  final DateTime timestamp;
  AppEvent([DateTime? timestamp]) : timestamp = timestamp ?? DateTime.now();
}

/// حدث إتمام درس تعليمي
class LessonCompletedEvent extends AppEvent {
  final String categoryId;
  final int score;
  final int totalQuestions;
  LessonCompletedEvent({
    required this.categoryId,
    required this.score,
    required this.totalQuestions,
  });
}

/// حدث إتقان مفردة لغوية
class WordMasteredEvent extends AppEvent {
  final String conceptId;
  final String categoryId;
  WordMasteredEvent({required this.conceptId, required this.categoryId});
}

/// حدث تحديث سلسلة الأيام المتواصلة
class StreakUpdatedEvent extends AppEvent {
  final int streakDays;
  StreakUpdatedEvent({required this.streakDays});
}

/// حدث تغير إعدادات التطبيق
class SettingsChangedEvent extends AppEvent {
  final String settingKey;
  final dynamic newValue;
  SettingsChangedEvent({required this.settingKey, required this.newValue});
}

/// ناقل الأحداث الداخلي السريع لفك الارتباط بين الشاشات والمكونات
class AppEventBus {
  static final AppEventBus _instance = AppEventBus._internal();
  factory AppEventBus() => _instance;
  AppEventBus._internal();

  final StreamController<AppEvent> _streamController = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get stream => _streamController.stream;

  /// إرسال حدث لكافة المستمعين عبر التطبيق
  void emit(AppEvent event) {
    if (!_streamController.isClosed) {
      _streamController.add(event);
    }
  }

  /// الاستماع لنوع محدد من الأحداث المعرفية
  Stream<T> on<T extends AppEvent>() {
    return _streamController.stream.where((event) => event is T).cast<T>();
  }

  void dispose() {
    _streamController.close();
  }
}

final eventBus = AppEventBus();
