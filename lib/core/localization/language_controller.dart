import 'package:flutter/material.dart';

class LanguageController extends ChangeNotifier {
  Locale _currentLocale = const Locale('ar');

  Locale get currentLocale => _currentLocale;
  bool get isRtl => _currentLocale.languageCode == 'ar';

  void setLocale(Locale newLocale) {
    if (_currentLocale == newLocale) return;
    _currentLocale = newLocale;
    notifyListeners();
  }

  void switchToArabic() => setLocale(const Locale('ar'));
  void switchToGerman() => setLocale(const Locale('de'));
  void switchToEnglish() => setLocale(const Locale('en'));
}
