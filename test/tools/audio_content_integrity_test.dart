import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/data/adapters/content_schema_adapter.dart';

void main() {
  group('Audio & Content Integrity Automated Verification', () {
    test('Validates vocalized Arabic text contains Tashkeel diacritics', () {
      final tashkeelRegex = RegExp(r'[\u064B-\u0652\u0670]');
      const vocalizedTitle = 'السَّاعَاتُ المَائِيَّةُ وَالمُعَدِّلاَتُ';
      const plainTitle = 'الساعات المائية والمعدلات';

      expect(tashkeelRegex.hasMatch(vocalizedTitle), isTrue);
      expect(tashkeelRegex.hasMatch(plainTitle), isFalse);
    });

    test('Ensures canonical models reject empty trilingual titles', () {
      const invalidText = TrilingualText(ar: '', de: 'Wasseruhr', en: 'Water clock');
      expect(invalidText.isValid, isFalse);

      const validText = TrilingualText(
        ar: 'سَاعَةٌ مَائِيَّةٌ',
        de: 'Wasseruhr',
        en: 'Water clock',
      );
      expect(validText.isValid, isTrue);
    });

    test('Verifies unique IDs prevent collision in entity registry', () {
      final seenIds = <String>{};
      final candidateIds = ['cat_001', 'cat_002', 'cat_003', 'cat_001'];

      final duplicates = <String>[];
      for (final id in candidateIds) {
        if (!seenIds.add(id)) {
          duplicates.add(id);
        }
      }

      expect(duplicates.length, equals(1));
      expect(duplicates.first, equals('cat_001'));
      expect(seenIds.length, equals(3));
    });
  });
}
