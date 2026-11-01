import 'package:flutter/material.dart';
import '../utils/logger.dart';

/// قناة التكامل مع ميزات الوصولية في نظام التشغيل (حجم الخطوط، التباين، قارئ الشاشة)
class AccessibilityChannel extends ChangeNotifier {
  static final AccessibilityChannel _instance = AccessibilityChannel._internal();
  factory AccessibilityChannel() => _instance;
  AccessibilityChannel._internal();

  double _textScaleFactor = 1.0;
  bool _isHighContrast = false;
  bool _isScreenReaderActive = false;

  double get textScaleFactor => _textScaleFactor;
  bool get isHighContrast => _isHighContrast;
  bool get isScreenReaderActive => _isScreenReaderActive;

  void updateFromMediaQuery(MediaQueryData mediaQuery) {
    bool hasChanged = false;

    if (_textScaleFactor != mediaQuery.textScaleFactor) {
      _textScaleFactor = mediaQuery.textScaleFactor.clamp(0.8, 2.0);
      hasChanged = true;
    }

    if (_isHighContrast != mediaQuery.highContrast) {
      _isHighContrast = mediaQuery.highContrast;
      hasChanged = true;
    }

    if (_isScreenReaderActive != mediaQuery.accessibleNavigation) {
      _isScreenReaderActive = mediaQuery.accessibleNavigation;
      hasChanged = true;
    }

    if (hasChanged) {
      logger.d(
        'تحديث إعدادات الوصولية: مقياس الخط=$_textScaleFactor، تباين عالي=$_isHighContrast',
        'AccessibilityChannel',
      );
      notifyListeners();
    }
  }
}

final accessibilityChannel = AccessibilityChannel();
