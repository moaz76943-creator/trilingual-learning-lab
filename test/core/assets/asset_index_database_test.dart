import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trilingual_learning_lab/core/assets/asset_index_database.dart';

class _MockAssetBundle extends CachingAssetBundle {
  _MockAssetBundle(this.payload);
  final String payload;

  @override
  Future<ByteData> load(String key) async {
    if (key != 'content/assets/images_registry.json') {
      throw StateError('Unknown asset: $key');
    }
    final bytes = Uint8List.fromList(utf8.encode(payload));
    return ByteData.sublistView(bytes);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('asset index loads both string and object path records', () async {
    final index = AssetIndexDatabase(
      assetBundle: _MockAssetBundle(jsonEncode({
        'one': 'content/assets/svg/one.svg',
        'two': {'path': 'content/assets/svg/two.svg'},
      })),
    );
    await index.initialize();
    expect(index.contains('one'), isTrue);
    expect(index.resolvePath('two'), 'content/assets/svg/two.svg');
    expect(index.contains('missing'), isFalse);
  });

  test('asset index rejects unsafe path traversal', () async {
    final index = AssetIndexDatabase(
      assetBundle: _MockAssetBundle(jsonEncode({
        'bad': '../private/secret.svg',
      })),
    );
    await index.initialize();
    expect(index.contains('bad'), isFalse);
  });
}
