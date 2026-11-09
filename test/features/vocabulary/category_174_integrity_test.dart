import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/data/adapters/content_schema_adapter.dart';

void main() {
  group('Category 174 Astrolabe Mater & Tympan Integrity', () {
    test('Loads and validates category 174 through ContentSchemaAdapter', () {
      final file = File('content/categories/category_174_astrolabe_tympan_plates.json');
      expect(file.existsSync(), isTrue);

      final rawJson = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final normalized = ContentSchemaAdapter.normalizeCategory(rawJson);

      expect(normalized.id, equals('category_174_astrolabe_tympan_plates'));
      expect(normalized.level, equals('B1'));
      expect(normalized.title.ar, contains('حُجْرَةُ'));
      expect(normalized.title.de, contains('Mutter'));
      expect(normalized.title.en, contains('Mater'));
      expect(normalized.items.length, equals(6));

      for (final item in normalized.items) {
        expect(RegExp(r'[\u064B-\u0652\u0670]').hasMatch(item.ar), isTrue,
            reason: 'Item ${item.id} Arabic text lacks Tashkeel');
        expect(item.de.isNotEmpty, isTrue);
        expect(item.en.isNotEmpty, isTrue);
      }
    });
  });
}
