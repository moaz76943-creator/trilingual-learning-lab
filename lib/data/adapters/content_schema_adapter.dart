import 'package:flutter/foundation.dart';

/// Canonical representation of trilingual text across Arabic, German, and English.
class TrilingualText {
  final String ar;
  final String de;
  final String en;

  const TrilingualText({
    required this.ar,
    required this.de,
    required this.en,
  });

  factory TrilingualText.empty() => const TrilingualText(ar: '', de: '', en: '');

  bool get isValid => ar.trim().isNotEmpty && de.trim().isNotEmpty && en.trim().isNotEmpty;

  Map<String, String> toMap() => {
    'ar': ar,
    'de': de,
    'en': en,
  };
}

/// Canonical vocabulary item mapped from diverse schema variants.
class CanonicalVocabItem {
  final String id;
  final String ar;
  final String de;
  final String en;
  final String? transliteration;

  const CanonicalVocabItem({
    required this.id,
    required this.ar,
    required this.de,
    required this.en,
    this.transliteration,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'ar': ar,
    'de': de,
    'en': en,
    if (transliteration != null) 'transliteration': transliteration,
  };
}

/// Canonical category entity.
class CanonicalCategory {
  final String id;
  final TrilingualText title;
  final String level;
  final List<CanonicalVocabItem> items;

  const CanonicalCategory({
    required this.id,
    required this.title,
    required this.level,
    required this.items,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title.toMap(),
    'level': level,
    'items': items.map((e) => e.toMap()).toList(),
  };
}

/// Canonical dialogue turn.
class CanonicalDialogueTurn {
  final TrilingualText speaker;
  final TrilingualText speech;

  const CanonicalDialogueTurn({
    required this.speaker,
    required this.speech,
  });

  Map<String, dynamic> toMap() => {
    'speaker': speaker.toMap(),
    'speech': speech.toMap(),
  };
}

/// Canonical dialogue entity.
class CanonicalDialogue {
  final String id;
  final TrilingualText title;
  final TrilingualText? context;
  final List<CanonicalDialogueTurn> turns;

  const CanonicalDialogue({
    required this.id,
    required this.title,
    this.context,
    required this.turns,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title.toMap(),
    if (context != null) 'context': context!.toMap(),
    'turns': turns.map((e) => e.toMap()).toList(),
  };
}

/// Universal schema adapter that extracts and normalizes varied JSON schemas
/// into standardized canonical domain models.
class ContentSchemaAdapter {
  /// Extracts primary identifier using priority fallback order.
  static String extractId(Map<String, dynamic> json, [List<String>? candidates]) {
    final searchKeys = candidates ?? [
      'id',
      'concept_id',
      'category_id',
      'dialogue_id',
      'verb_id',
      'item_id',
      'slug',
    ];

    for (final key in searchKeys) {
      final value = json[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    throw const FormatException('Could not resolve entity identifier from candidate keys.');
  }

  /// Extracts trilingual text whether stored as nested object, flat keys, or prefixed keys.
  static TrilingualText extractTrilingualText(
    Map<String, dynamic> json, {
    String nestedKey = 'title',
    String prefix = 'title_',
    String fallbackPrefix = 'name_',
  }) {
    // 1. Try nested object: "title": {"ar": "...", "de": "...", "en": "..."}
    final nested = json[nestedKey] ?? json['trilingual'] ?? json['titles'];
    if (nested is Map) {
      final ar = (nested['ar'] ?? '').toString().trim();
      final de = (nested['de'] ?? '').toString().trim();
      final en = (nested['en'] ?? '').toString().trim();
      if (ar.isNotEmpty || de.isNotEmpty || en.isNotEmpty) {
        return TrilingualText(ar: ar, de: de, en: en);
      }
    }

    // 2. Try prefixed flat keys: "title_ar", "title_de", "title_en"
    String ar = (json['${prefix}ar'] ?? '').toString().trim();
    String de = (json['${prefix}de'] ?? '').toString().trim();
    String en = (json['${prefix}en'] ?? '').toString().trim();

    // 3. Try fallback flat keys: "name_ar", "name_de", "name_en"
    if (ar.isEmpty) ar = (json['${fallbackPrefix}ar'] ?? json['ar'] ?? '').toString().trim();
    if (de.isEmpty) de = (json['${fallbackPrefix}de'] ?? json['de'] ?? '').toString().trim();
    if (en.isEmpty) en = (json['${fallbackPrefix}en'] ?? json['en'] ?? '').toString().trim();

    return TrilingualText(ar: ar, de: de, en: en);
  }

  /// Normalizes category JSON into [CanonicalCategory].
  static CanonicalCategory normalizeCategory(Map<String, dynamic> raw) {
    final id = extractId(raw, ['category_id', 'id', 'concept_id']);
    final title = extractTrilingualText(raw, nestedKey: 'title', prefix: 'title_');
    final level = (raw['level'] ?? raw['cefr_level'] ?? 'A1').toString().trim();

    // Extract items from "items", "vocabulary", or "terms"
    final rawList = raw['items'] ?? raw['vocabulary'] ?? raw['terms'] ?? [];
    final items = <CanonicalVocabItem>[];

    if (rawList is List) {
      for (var i = 0; i < rawList.length; i++) {
        final itemRaw = rawList[i];
        if (itemRaw is Map<String, dynamic>) {
          final itemId = itemRaw['id']?.toString() ?? '${id}_item_$i';
          final ar = (itemRaw['ar'] ?? itemRaw['term_ar'] ?? '').toString().trim();
          final de = (itemRaw['de'] ?? itemRaw['term_de'] ?? '').toString().trim();
          final en = (itemRaw['en'] ?? itemRaw['term_en'] ?? '').toString().trim();
          final transliteration = itemRaw['transliteration']?.toString().trim();

          items.add(CanonicalVocabItem(
            id: itemId,
            ar: ar,
            de: de,
            en: en,
            transliteration: transliteration,
          ));
        }
      }
    }

    return CanonicalCategory(
      id: id,
      title: title,
      level: level,
      items: items,
    );
  }

  /// Normalizes dialogue JSON into [CanonicalDialogue].
  static CanonicalDialogue normalizeDialogue(Map<String, dynamic> raw) {
    final id = extractId(raw, ['dialogue_id', 'id', 'concept_id']);
    final title = extractTrilingualText(raw, nestedKey: 'title', prefix: 'title_');

    TrilingualText? context;
    if (raw.containsKey('context')) {
      final ctxRaw = raw['context'];
      if (ctxRaw is Map) {
        context = TrilingualText(
          ar: (ctxRaw['ar'] ?? '').toString().trim(),
          de: (ctxRaw['de'] ?? '').toString().trim(),
          en: (ctxRaw['en'] ?? '').toString().trim(),
        );
      }
    }

    final rawTurns = raw['turns'] ?? raw['lines'] ?? raw['conversation'] ?? [];
    final turns = <CanonicalDialogueTurn>[];

    if (rawTurns is List) {
      for (final turnRaw in rawTurns) {
        if (turnRaw is Map<String, dynamic>) {
          // Speaker parsing (object or flat)
          TrilingualText speaker;
          if (turnRaw['speaker'] is Map) {
            final spkMap = turnRaw['speaker'] as Map;
            speaker = TrilingualText(
              ar: (spkMap['ar'] ?? '').toString().trim(),
              de: (spkMap['de'] ?? '').toString().trim(),
              en: (spkMap['en'] ?? '').toString().trim(),
            );
          } else if (turnRaw['speaker'] is String) {
            final spkStr = turnRaw['speaker'].toString().trim();
            speaker = TrilingualText(ar: spkStr, de: spkStr, en: spkStr);
          } else {
            speaker = extractTrilingualText(turnRaw, nestedKey: 'speaker', prefix: 'speaker_');
          }

          // Speech text
          final speech = TrilingualText(
            ar: (turnRaw['ar'] ?? turnRaw['text_ar'] ?? '').toString().trim(),
            de: (turnRaw['de'] ?? turnRaw['text_de'] ?? '').toString().trim(),
            en: (turnRaw['en'] ?? turnRaw['text_en'] ?? '').toString().trim(),
          );

          turns.add(CanonicalDialogueTurn(speaker: speaker, speech: speech));
        }
      }
    }

    return CanonicalDialogue(
      id: id,
      title: title,
      context: context,
      turns: turns,
    );
  }
}
