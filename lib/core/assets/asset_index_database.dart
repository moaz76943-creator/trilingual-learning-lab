import 'dart:convert';

import 'package:flutter/services.dart';

/// Offline lookup for registered packaged assets.
/// Only project-relative paths are accepted; external URLs are never resolved.
class AssetIndexDatabase {
  AssetIndexDatabase({AssetBundle? assetBundle})
      : _assetBundle = assetBundle ?? rootBundle;

  final AssetBundle _assetBundle;
  Map<String, String> _paths = const <String, String>{};
  bool _loaded = false;

  bool get isLoaded => _loaded;
  int get length => _paths.length;

  Future<void> initialize() async {
    if (_loaded) return;

    final raw = await _assetBundle.loadString(
      'content/assets/images_registry.json',
    );
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Asset registry must be a JSON object');
    }

    final result = <String, String>{};
    for (final entry in decoded.entries) {
      final Object? record = entry.value;
      final String? candidate = switch (record) {
        String value => value,
        Map<String, dynamic> value => value['path'] as String?,
        _ => null,
      };
      if (candidate == null || candidate.isEmpty) continue;

      final normalized = candidate.replaceAll('\\', '/');
      final parts = normalized.split('/');
      final isUnsafe = normalized.startsWith('/') ||
          normalized.contains('://') ||
          normalized.startsWith('~') ||
          parts.contains('..') ||
          parts.contains('.');
      if (isUnsafe) continue;
      if (!(normalized.endsWith('.svg') ||
          normalized.endsWith('.png') ||
          normalized.endsWith('.webp') ||
          normalized.endsWith('.jpg') ||
          normalized.endsWith('.jpeg'))) {
        continue;
      }
      result[entry.key] = normalized;
    }
    _paths = Map<String, String>.unmodifiable(result);
    _loaded = true;
  }

  bool contains(String key) => _paths.containsKey(key);

  String resolvePath(String key) => _paths[key] ?? '';
}

final assetIndexDb = AssetIndexDatabase();
