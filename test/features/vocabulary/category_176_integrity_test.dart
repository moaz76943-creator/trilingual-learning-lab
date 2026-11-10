import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/data/adapters/content_schema_adapter.dart';

void main() {
  group('Category 176 Universal Astrolabe Integrity', () {
    test('Loads and validates category 176 through ContentSchemaAdapter', () {
      final file = File('content/categories/category_176_zarqallu_universal_astrolabe.json');
      expect(file.existsSync(), isTrue);

      final rawJson = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final normalized = ContentSchemaAdapter.normalizeCategory(rawJson);

      expect(normalized.id, equals('category_176_zarqallu_universal_astrolabe'));
      expect(normalized.level, equals('B1'));
      expect(normalized.title.ar, contains('الشَّكَّازِيُّ'));
      expect(normalized.title.de, contains('universelle Astrolabium'));
      expect(normalized.title.en, contains('Universal Astrolabe'));
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
