import 'package:flutter/material.dart';

/// الثوابت والإعدادات المركزية للتطبيق
class AppConfig {
  static const String appName = 'المختبر اللغوي الثلاثي';
  static const String appVersion = '1.0.0';
  static const int schemaVersion = 1;

  // اللغات المدعومة رسمياً
  static const Locale localeArabic = Locale('ar');
  static const Locale localeGerman = Locale('de');
  static const Locale localeEnglish = Locale('en');

  static const List<Locale> supportedLocales = [
    localeArabic,
    localeGerman,
    localeEnglish,
  ];

  // مفاتيح التخزين الآمن
  static const String keyAppLocale = 'app_locale';
  static const String keyDarkMode = 'app_dark_mode';
  static const String keyDailyGoal = 'app_daily_goal';

  // معايير التعلم والتكرار المتباعد
  static const int defaultDailyWordsGoal = 10;
  static const int maxReviewQueueSize = 50;

  // مسارات الأصول والبيانات
  static const String pathSentencesA1 = 'content/sentences/sentences_a1.json';
  static const String pathAssetRegistry = 'content/assets/images_registry.json';
}
