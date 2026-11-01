import '../utils/logger.dart';

/// مراقب حالة البطارية وترشيد استهلاك المعالجة الرسومية تلقائياً
class BatteryOptimizer {
  static final BatteryOptimizer _instance = BatteryOptimizer._internal();
  factory BatteryOptimizer() => _instance;
  BatteryOptimizer._internal();

  bool _isLowPowerMode = false;
  int _batteryLevel = 100;

  bool get isLowPowerMode => _isLowPowerMode || _batteryLevel <= 20;
  int get batteryLevel => _batteryLevel;

  /// تحديث مستوى شحن البطارية وترشيد الحركة عند الانخفاض دون 20%
  void updateBatteryLevel(int level) {
    _batteryLevel = level.clamp(0, 100);
    if (_batteryLevel <= 20 && !_isLowPowerMode) {
      _isLowPowerMode = true;
      logger.i('تم تفعيل وضع توفير الطاقة تلقائياً (البطارية: $_batteryLevel%)', 'BatteryOptimizer');
    }
  }

  void setLowPowerMode(bool enabled) {
    _isLowPowerMode = enabled;
    logger.d('تغيير وضع توفير الطاقة إلى: $enabled', 'BatteryOptimizer');
  }

  /// زمن حركات الانتقال الأمثل بحسب وضع البطارية
  Duration get optimalAnimationDuration =>
      isLowPowerMode ? const Duration(milliseconds: 100) : const Duration(milliseconds: 300);

  /// تعطيل التأثيرات البصرية الحركية الثقيلة عند انخفاض الشحن
  bool get shouldDisableHeavyEffects => isLowPowerMode;
}

final batteryOptimizer = BatteryOptimizer();
