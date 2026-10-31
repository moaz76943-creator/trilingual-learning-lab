import 'package:flutter/material.dart';

/// نظام الترجمة الذاتية المدمج والخفيف الخالي من التبعيات الخارجية
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('ar'));
  }

  static const _localizedValues = <String, Map<String, String>>{
    'ar': {
      'app_title': 'المختبر اللغوي الثلاثي',
      'home': 'الرئيسية',
      'categories': 'التصنيفات',
      'sentences': 'الجمل التفاعلية',
      'verbs': 'تصريف الأفعال',
      'review': 'المراجعة الذكية',
      'settings': 'الإعدادات',
      'search_hint': 'ابحث عن كلمة، فعل، أو جملة...',
      'retry': 'إعادة المحاولة',
      'save': 'حفظ',
      'cancel': 'إلغاء',
      'start_lesson': 'ابدأ الدرس',
      'daily_streak': 'سلسلة الأيام',
      'words_learned': 'الكلمات المحفوظة',
    },
    'de': {
      'app_title': 'Trilingual Learning Lab',
      'home': 'Startseite',
      'categories': 'Kategorien',
      'sentences': 'Interaktive Sätze',
      'verbs': 'Verbkonjugation',
      'review': 'Wiederholung',
      'settings': 'Einstellungen',
      'search_hint': 'Suche nach Wort, Verb oder Satz...',
      'retry': 'Wiederholen',
      'save': 'Speichern',
      'cancel': 'Abbrechen',
      'start_lesson': 'Lektion beginnen',
      'daily_streak': 'Tägliche Serie',
      'words_learned': 'Gelernte Wörter',
    },
    'en': {
      'app_title': 'Trilingual Learning Lab',
      'home': 'Home',
      'categories': 'Categories',
      'sentences': 'Interactive Sentences',
      'verbs': 'Verb Conjugation',
      'review': 'Smart Review',
      'settings': 'Settings',
      'search_hint': 'Search word, verb, or sentence...',
      'retry': 'Retry',
      'save': 'Save',
      'cancel': 'Cancel',
      'start_lesson': 'Start Lesson',
      'daily_streak': 'Daily Streak',
      'words_learned': 'Words Learned',
    },
  };

  String translate(String key) {
    final langCode = locale.languageCode;
    return _localizedValues[langCode]?[key] ?? _localizedValues['ar']?[key] ?? key;
  }
}
