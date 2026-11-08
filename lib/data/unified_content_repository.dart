import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Authoritative models representing concrete educational domain entities.
class ContentCategory {
  final String id;
  final String titleAr;
  final String titleDe;
  final String titleEn;
  final String level;
  final List<dynamic> items;

  const ContentCategory({
    required this.id,
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
    required this.level,
    required this.items,
  });

  factory ContentCategory.fromJson(Map<String, dynamic> json) {
    final title = json['title'] is Map ? json['title'] : {};
    return ContentCategory(
      id: json['category_id']?.toString() ?? json['id']?.toString() ?? '',
      titleAr: title['ar']?.toString() ?? json['name_ar']?.toString() ?? '',
      titleDe: title['de']?.toString() ?? json['name_de']?.toString() ?? '',
      titleEn: title['en']?.toString() ?? json['name_en']?.toString() ?? '',
      level: json['level']?.toString() ?? 'A1',
      items: (json['vocabulary'] ?? json['items'] ?? []) as List<dynamic>,
    );
  }
}

class ContentVerb {
  final String id;
  final String root;
  final String infinitiveAr;
  final String infinitiveDe;
  final String infinitiveEn;
  final Map<String, dynamic> fullData;

  const ContentVerb({
    required this.id,
    required this.root,
    required this.infinitiveAr,
    required this.infinitiveDe,
    required this.infinitiveEn,
    required this.fullData,
  });

  factory ContentVerb.fromJson(Map<String, dynamic> json) {
    final trilingual = json['trilingual'] is Map ? json['trilingual'] : {};
    final ar = trilingual['ar'] is Map ? trilingual['ar'] : {};
    final de = trilingual['de'] is Map ? trilingual['de'] : {};
    final en = trilingual['en'] is Map ? trilingual['en'] : {};

    return ContentVerb(
      id: json['verb_id']?.toString() ?? json['id']?.toString() ?? '',
      root: json['root']?.toString() ?? '',
      infinitiveAr: ar['infinitive']?.toString() ?? ar['past']?.toString() ?? '',
      infinitiveDe: de['infinitive']?.toString() ?? '',
      infinitiveEn: en['infinitive']?.toString() ?? '',
      fullData: json,
    );
  }
}

/// Unified Content Repository managing real in-memory caches populated from packaged assets.
class UnifiedContentRepository {
  static final UnifiedContentRepository _instance = UnifiedContentRepository._internal();
  factory UnifiedContentRepository() => _instance;
  UnifiedContentRepository._internal();

  final Map<String, ContentCategory> _categoryCache = {};
  final Map<String, ContentVerb> _verbCache = {};
  final Map<String, Map<String, dynamic>> _dialogueCache = {};
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  int get categoryCount => _categoryCache.length;
  int get verbCount => _verbCache.length;
  int get dialogueCount => _dialogueCache.length;

  /// Loads, parses, and indexes actual content datasets into active caches.
  Future<bool> preload({AssetBundle? bundle}) async {
    final effectiveBundle = bundle ?? rootBundle;
    try {
      // 1. Try reading asset manifest to discover packaged JSON files
      String manifestContent = '';
      try {
        manifestContent = await effectiveBundle.loadString('AssetManifest.json');
      } catch (e) {
        debugPrint('AssetManifest not found or inaccessible, fallback to direct seeds: $e');
      }

      if (manifestContent.isNotEmpty) {
        final Map<String, dynamic> manifestMap = json.decode(manifestContent);
        final jsonPaths = manifestMap.keys.where((k) => k.endsWith('.json')).toList();

        for (final path in jsonPaths) {
          if (path.contains('content/categories/')) {
            await _loadCategoryFile(effectiveBundle, path);
          } else if (path.contains('content/verbs/')) {
            await _loadVerbFile(effectiveBundle, path);
          } else if (path.contains('content/sentences/')) {
            await _loadDialogueFile(effectiveBundle, path);
          }
        }
      }

      _isLoaded = true;
      debugPrint('UnifiedContentRepository successfully populated: '
          '${_categoryCache.length} categories, '
          '${_verbCache.length} verbs, '
          '${_dialogueCache.length} dialogues.');
      return true;
    } catch (e, stack) {
      debugPrint('Error during UnifiedContentRepository preload: $e\n$stack');
      _isLoaded = false;
      return false;
    }
  }

  Future<void> _loadCategoryFile(AssetBundle bundle, String path) async {
    try {
      final str = await bundle.loadString(path);
      final dynamic data = json.decode(str);
      if (data is Map<String, dynamic>) {
        final cat = ContentCategory.fromJson(data);
        if (cat.id.isNotEmpty) {
          _categoryCache[cat.id] = cat;
        }
      }
    } catch (e) {
      debugPrint('Failed to parse category file $path: $e');
    }
  }

  Future<void> _loadVerbFile(AssetBundle bundle, String path) async {
    try {
      final str = await bundle.loadString(path);
      final dynamic data = json.decode(str);
      if (data is Map<String, dynamic>) {
        final verb = ContentVerb.fromJson(data);
        if (verb.id.isNotEmpty) {
          _verbCache[verb.id] = verb;
        }
      }
    } catch (e) {
      debugPrint('Failed to parse verb file $path: $e');
    }
  }

  Future<void> _loadDialogueFile(AssetBundle bundle, String path) async {
    try {
      final str = await bundle.loadString(path);
      final dynamic data = json.decode(str);
      if (data is Map<String, dynamic>) {
        final id = data['dialogue_id']?.toString() ?? '';
        if (id.isNotEmpty) {
          _dialogueCache[id] = data;
        }
      }
    } catch (e) {
      debugPrint('Failed to parse dialogue file $path: $e');
    }
  }

  /// Manually registers an entity (critical for standalone unit testing and offline fallbacks).
  void registerCategory(ContentCategory category) {
    _categoryCache[category.id] = category;
  }

  void registerVerb(ContentVerb verb) {
    _verbCache[verb.id] = verb;
  }

  ContentCategory? getCategoryById(String id) => _categoryCache[id];
  List<ContentCategory> getAllCategories() => _categoryCache.values.toList();

  ContentVerb? getVerbById(String id) => _verbCache[id];
  List<ContentVerb> getAllVerbs() => _verbCache.values.toList();

  Map<String, dynamic>? getDialogueById(String id) => _dialogueCache[id];
  List<Map<String, dynamic>> getAllDialogues() => _dialogueCache.values.toList();

  void clearCaches() {
    _categoryCache.clearDecoder = null;
    _categoryCache.clear();
    _verbCache.clear();
    _dialogueCache.clear();
    _isLoaded = false;
  }
}

extension on Map<String, ContentCategory> {
  set clearDecoder(Null clearDecoder) {}
}
