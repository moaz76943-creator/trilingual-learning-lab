import 'package:flutter/services.dart';
import 'logger.dart';

/// مساعد الحافظة لنسخ النصوص الثلاثية بتنسيق منظم مع أو بدون تشكيل
class ClipboardHelper {
  /// نسخ نص عادي إلى الحافظة
  static Future<bool> copyText(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      logger.d('تم نسخ النص إلى الحافظة: $text', 'ClipboardHelper');
      return true;
    } catch (e) {
      logger.e('فشل نسخ النص: $e', 'ClipboardHelper');
      return false;
    }
  }

  /// نسخ بطاقة مفردة ثلاثية منسقة
  static Future<bool> copyTrilingualConcept({
    required String arabic,
    required String german,
    required String english,
    String? article,
  }) async {
    final germanWithArticle = article != null ? '$article $german' : german;
    final formatted = '$arabic | $germanWithArticle | $english';
    return copyText(formatted);
  }

  /// إزالة التشكيل من النص العربي عند الرغبة في النسخ المجرد
  static String removeDiacritics(String text) {
    return text.replaceAll(RegExp(r'[\u064B-\u0652\u0670]'), '');
  }
}
