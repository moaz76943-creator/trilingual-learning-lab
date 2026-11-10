import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Verbs 337 and 338 Morphological Integrity', () {
    test('Verifies Verb 337 (wazana / to balance) conjugation completeness', () {
      final file = File('content/verbs/verb_337_wazana_balance.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_337_wazana_balance'));
      expect(data['root'], equals('و - ز - ن'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('وَازَنَ'));
      expect(ar['present'], equals('يُوَازِنُ'));
      expect(ar['imperative'], equals('وَازِنْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], contains('ausbalancieren'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], contains('balance'));
    });

    test('Verifies Verb 338 (dara / to rotate) conjugation completeness', () {
      final file = File('content/verbs/verb_338_dara_rotate.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_338_dara_rotate'));
      expect(data['root'], equals('د - و - ر'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('دَارَ'));
      expect(ar['present'], equals('يَدُورُ'));
      expect(ar['imperative'], equals('دُرْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], contains('drehen'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], contains('rotate'));
    });
  });
}
