import 'dart:math';

/// مولد معرفات فريد ومعياري وفق صيغة RFC 4122 الإصدار الرابع (UUIDv4)
class UuidGenerator {
  static final Random _random = Random.secure();

  /// توليد معرف فريد UUIDv4 بصيغة خالية من التكرار
  static String generate() {
    final values = List<int>.generate(16, (i) => _random.nextInt(256));

    // تعيين بتات الإصدار 4
    values[6] = (values[6] & 0x0f) | 0x40;
    // تعيين بتات البديل IETF
    values[8] = (values[8] & 0x3f) | 0x80;

    return '${_toHex(values.sublist(0, 4))}-'
        '${_toHex(values.sublist(4, 6))}-'
        '${_toHex(values.sublist(6, 8))}-'
        '${_toHex(values.sublist(8, 10))}-'
        '${_toHex(values.sublist(10, 16))}';
  }

  static String _toHex(List<int> bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
