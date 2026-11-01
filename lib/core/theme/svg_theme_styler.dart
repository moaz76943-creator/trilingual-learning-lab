import 'package:flutter/material.dart';

/// منسق ألوان المتجهات المتكيف ديناميكياً مع السمة الفاتحة والداكنة
class SvgThemeStyler {
  /// تكييف كود لون SVG بحسب سطوع الثيم الحالي (Dark / Light Mode)
  static Color getAdaptiveColor({
    required BuildContext context,
    required Color lightColor,
    required Color darkColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? darkColor : lightColor;
  }

  /// مرشح لوني لتغيير ألوان المتجه عند تفعيل الوضع الليلي
  static ColorFilter getThemeColorFilter(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) {
      return const ColorFilter.matrix(<double>[
        -1.0, 0, 0, 0, 255,
        0, -1.0, 0, 0, 255,
        0, 0, -1.0, 0, 255,
        0, 0, 0, 1.0, 0,
      ]);
    }
    return const ColorFilter.mode(Colors.transparent, BlendMode.dst);
  }
}
