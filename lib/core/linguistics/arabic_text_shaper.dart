/// معالج النصوص وتشكيل العربية لضمان سلامة الحركات وتفادي انفصال الحروف
class ArabicTextShaper {
  static final RegExp _diacriticsRegex = RegExp(r'[\u064B-\u0652\u0670]');
  static final RegExp _tatweelRegex = RegExp(r'\u0640');

  /// إزالة التشكيل بالكامل لأغراض البحث المرن والمطابقة غير الصارمة
  static String stripDiacritics(String text) {
    return text.replaceAll(_diacriticsRegex, '').replaceAll(_tatweelRegex, '');
  }

  /// تطبيع الألف والهمزات (أ، إ، آ -> ا) لتسهيل الفهرسة السريعة
  static String normalizeLetters(String text) {
    return stripDiacritics(text)
        .replaceAll(RegExp(r'[أإآ]'), 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي');
  }

  /// فحص نسبة التشكيل في النص (هل النص مشكول كلياً أم جزئياً؟)
  static double getDiacriticsRatio(String text) {
    if (text.isEmpty) return 0.0;
    final arabicLetters = RegExp(r'[\u0621-\u064A]').allMatches(text).length;
    if (arabicLetters == 0) return 0.0;
    final diacritics = _diacriticsRegex.allMatches(text).length;
    return diacritics / arabicLetters;
  }

  /// التأكد من وجود تشكيل سليم (نسبة حركات تفوق 70% من الحروف)
  static bool isVowelled(String text) {
    return getDiacriticsRatio(text) >= 0.7;
  }
}
