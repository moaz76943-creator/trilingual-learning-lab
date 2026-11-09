import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Verbs 333 and 334 Morphological Integrity', () {
    test('Verifies Verb 333 (asqata / to project) conjugation completeness', () {
      final file = File('content/verbs/verb_333_asqata_project.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_333_asqata_project'));
      expect(data['root'], equals('س - ق - ط'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('أَسْقَطَ'));
      expect(ar['present'], equals('يُسْقِطُ'));
      expect(ar['imperative'], equals('أَسْقِطْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], equals('projizieren'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], equals('to project'));
    });

    test('Verifies Verb 334 (darraja / to graduate) conjugation completeness', () {
      final file = File('content/verbs/verb_334_darraja_graduate.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      expect(data['verb_id'], equals('verb_334_darraja_graduate'));
      expect(data['root'], equals('د - ر - ج'));

      final ar = data['trilingual']['ar'] as Map<String, dynamic>;
      expect(ar['past'], equals('دَرَّجَ'));
      expect(ar['present'], equals('يُدَرِّجُ'));
      expect(ar['imperative'], equals('دَرِّجْ'));

      final de = data['trilingual']['de'] as Map<String, dynamic>;
      expect(de['infinitive'], contains('graduieren'));

      final en = data['trilingual']['en'] as Map<String, dynamic>;
      expect(en['infinitive'], contains('graduate'));
    });
  });
}
