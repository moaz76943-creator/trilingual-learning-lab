/// بيانات توثيق وتكامل خطوط التطبيق المستخلصة بحجم خفيف
class FontSubsetInfo {
  static const List<String> supportedFamilies = ['Cairo', 'Amiri', 'Inter'];
  static const String arabicTashkeelRange = 'U+064B-U+0652';
  static const String germanUmlautsRange = 'ä, ö, ü, Ä, Ö, Ü, ß';

  /// التأكد من دعم المحرف ضمن نطاق الخطوط المستخلصة
  static bool isSupportedGlyph(int charCode) {
    if (charCode >= 0x0020 && charCode <= 0x007E) return true;
    if (charCode >= 0x0600 && charCode <= 0x06FF) return true;
    const germanCodes = [0x00E4, 0x00F6, 0x00FC, 0x00C4, 0x00D6, 0x00DC, 0x00DF];
    return germanCodes.contains(charCode);
  }
}
