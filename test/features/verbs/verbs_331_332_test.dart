import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Verbs 331 and 332 Morphological Integrity', () {
    test('Verifies Verb 331 (saddada / to collimate) conjugation completeness', () {
      final file = File('content/verbs/verb_331_saddada_collimate.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_331_saddada_collimate'));
      expect(data['root'], equals('س - د - د'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('سَدَّدَ'));
      expect(ar['present'], equals('يُسَدِّدُ'));
      expect(ar['imperative'], equals('سَدِّدْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], equals('anvisieren'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], equals('to collimate'));
    });

    test('Verifies Verb 332 (thaqaba / to perforate) conjugation completeness', () {
      final file = File('content/verbs/verb_332_thaqaba_perforate.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_332_thaqaba_perforate'));
      expect(data['root'], equals('ث - ق - ب'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('ثَقَبَ'));
      expect(ar['present'], equals('يَثْقُبُ'));
      expect(ar['imperative'], equals('اثْقُبْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], equals('durchbohren'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], equals('to perforate'));
    });
  });
}
