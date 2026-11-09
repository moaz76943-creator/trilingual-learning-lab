import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Verbs 329 and 330 Morphological Integrity', () {
    test('Verifies Verb 329 (faragha / to pierce) conjugation completeness', () {
      final file = File('content/verbs/verb_329_faragha_pierce.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_329_faragha_pierce'));
      expect(data['root'], equals('ف - ر - غ'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('فَرَّغَ'));
      expect(ar['present'], equals('يُفَرِّغُ'));
      expect(ar['imperative'], equals('فَرِّغْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], equals('ausfeilen'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], equals('to pierce'));
    });

    test('Verifies Verb 330 (qawwasa / to curve) conjugation completeness', () {
      final file = File('content/verbs/verb_330_qawwasa_curve.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_330_qawwasa_curve'));
      expect(data['root'], equals('ق - و - س'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('قَوَّسَ'));
      expect(ar['present'], equals('يُقَوِّسُ'));
      expect(ar['imperative'], equals('قَوِّسْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], equals('wölben'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], equals('to curve'));
    });
  });
}
