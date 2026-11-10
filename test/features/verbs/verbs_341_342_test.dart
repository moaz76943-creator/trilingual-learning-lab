import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Verbs 341 and 342 Morphological Integrity', () {
    test('Verifies Verb 341 (tawa / to fold) conjugation completeness', () {
      final file = File('content/verbs/verb_341_tawa_fold.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_341_tawa_fold'));
      expect(data['root'], equals('ط - و - ي'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('طَوَى'));
      expect(ar['present'], equals('يَطْوِي'));
      expect(ar['imperative'], equals('اطْوِ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], contains('zusammenklappen'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], contains('fold'));
    });

    test('Verifies Verb 342 (maghnata / to magnetize) conjugation completeness', () {
      final file = File('content/verbs/verb_342_maghnata_magnetize.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_342_maghnata_magnetize'));
      expect(data['root'], equals('م - غ - ن - ط'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('مَغْنَطَ'));
      expect(ar['present'], equals('يُمَغْنِطُ'));
      expect(ar['imperative'], equals('مَغْنِطْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], contains('magnetisieren'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], contains('magnetize'));
    });
  });
}
