import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/data/adapters/content_schema_adapter.dart';

void main() {
  group('Category 172 Astrolabe Retes Integrity', () {
    test('Loads and normalizes category 172 through ContentSchemaAdapter', () {
      final file = File('content/categories/category_172_astrolabe_retes.json');
      expect(file.existsSync(), isTrue);

      final rawJson = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final normalized = ContentSchemaAdapter.normalizeCategory(rawJson);

      expect(normalized.id, equals('category_172_astrolabe_retes'));
      expect(normalized.level, equals('B1'));
      expect(normalized.title.ar, contains('العَنْكَبُوتِيَّةِ'));
      expect(normalized.title.de, contains('Rete'));
      expect(normalized.title.en, contains('Rete'));
      expect(normalized.items.length, equals(6));

      // Verify Tashkeel presence on items
      for (final item in normalized.items) {
        expect(RegExp(r'[\u064B-\u0652\u0670]').hasMatch(item.ar), isTrue,
            reason: 'Item ${item.id} Arabic text lacks Tashkeel');
        expect(item.de.isNotEmpty, isTrue);
        expect(item.en.isNotEmpty, isTrue);
      }
    });
  });
}
