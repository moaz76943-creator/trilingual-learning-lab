import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/data/adapters/content_schema_adapter.dart';

void main() {
  group('Category 177 Shatir Compendium Sundial Integrity', () {
    test('Loads and validates category 177 through ContentSchemaAdapter', () {
      final file = File('content/categories/category_177_shatir_compendium_sundial.json');
      expect(file.existsSync(), isTrue);

      final rawJson = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final normalized = ContentSchemaAdapter.normalizeCategory(rawJson);

      expect(normalized.id, equals('category_177_shatir_compendium_sundial'));
      expect(normalized.level, equals('B1'));
      expect(normalized.title.ar, contains('اليَوَاقِيتِ'));
      expect(normalized.title.de, contains('Sonnenuhrkästchen'));
      expect(normalized.title.en, contains('Compendium'));
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
