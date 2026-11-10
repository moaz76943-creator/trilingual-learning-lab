import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Verbs 335 and 336 Morphological Integrity', () {
    test('Verifies Verb 335 (shadda / to fasten) conjugation completeness', () {
      final file = File('content/verbs/verb_335_shadda_fasten.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_335_shadda_fasten'));
      expect(data['root'], equals('ش - د - د'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('شَدَّ'));
      expect(ar['present'], equals('يَشُدُّ'));
      expect(ar['imperative'], equals('اشْدُدْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], contains('verkeilen'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], contains('fasten'));
    });

    test('Verifies Verb 336 (rakkaba / to assemble) conjugation completeness', () {
      final file = File('content/verbs/verb_336_rakkaba_assemble.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_336_rakkaba_assemble'));
      expect(data['root'], equals('ر - ك - ب'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('رَكَّبَ'));
      expect(ar['present'], equals('يُرَكِّبُ'));
      expect(ar['imperative'], equals('رَكِّبْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], contains('zusammenbauen'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], contains('assemble'));
    });
  });
}
