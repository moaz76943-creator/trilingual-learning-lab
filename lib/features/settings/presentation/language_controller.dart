import 'package:flutter/material.dart';
import '../../../core/config/app_config.dart';
import '../../../core/events/app_event_bus.dart';
import '../../../core/storage/secure_storage_service.dart';

/// متحكم لغة الواجهة التفاعلي مع الحفظ المحلي الفوري وتبديل اتجاه النصوص
class LanguageController extends ChangeNotifier {
  final SecureStorageService _storage;
  Locale _currentLocale = AppConfig.localeArabic;

  LanguageController(this._storage);

  Locale get currentLocale => _currentLocale;

  bool get isRTL => _currentLocale.languageCode == 'ar';

  TextDirection get textDirection =>
      isRTL ? TextDirection.rtl : TextDirection.ltr;

  Future<void> init() async {
    final result = await _storage.read(AppConfig.keyAppLocale);
    result.fold(
      (failure) => null,
      (savedCode) {
        if (savedCode != null && savedCode.isNotEmpty) {
          _currentLocale = Locale(savedCode);
          notifyListeners();
        }
      },
    );
  }

  Future<void> setLocale(Locale newLocale) async {
    if (_currentLocale == newLocale) return;
    _currentLocale = newLocale;
    notifyListeners();

    await _storage.write(AppConfig.keyAppLocale, newLocale.languageCode);
    eventBus.emit(SettingsChangedEvent(
      settingKey: AppConfig.keyAppLocale,
      newValue: newLocale.languageCode,
    ));
  }
}
