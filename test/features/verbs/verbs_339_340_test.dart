import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Verbs 339 and 340 Morphological Integrity', () {
    test('Verifies Verb 339 (ammama / to universalize) conjugation completeness', () {
      final file = File('content/verbs/verb_339_ammama_universalize.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_339_ammama_universalize'));
      expect(data['root'], equals('ع - م - م'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('عَمَّمَ'));
      expect(ar['present'], equals('يُعَمِّمُ'));
      expect(ar['imperative'], equals('عَمِّمْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], contains('verallgemeinern'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], contains('universalize'));
    });

    test('Verifies Verb 340 (istaghna / to dispense with) conjugation completeness', () {
      final file = File('content/verbs/verb_340_istaghna_dispense.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_340_istaghna_dispense'));
      expect(data['root'], equals('غ - ن - ي'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('اسْتَغْنَى'));
      expect(ar['present'], equals('يَسْتَغْنِي'));
      expect(ar['imperative'], equals('اسْتَغْنِ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], contains('verzichten'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], contains('dispense with'));
    });
  });
}
