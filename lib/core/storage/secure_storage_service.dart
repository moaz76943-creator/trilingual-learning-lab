import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Contract for durable key-value storage surviving process restarts.
abstract class ISecureStorageService {
  Future<void> write({required String key, required String value});
  Future<String?> read({required String key});
  Future<void> delete({required String key});
  Future<void> deleteAll();
  Future<bool> containsKey({required String key});
}

/// Durable, private-disk storage service replacing volatile in-memory maps.
/// Implements immediate memory caching with asynchronous, durable disk serialization.
class SecureStorageService implements ISecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  File? _storageFile;
  final Map<String, String> _cache = {};
  bool _isInitialized = false;

  /// Initializes the physical storage file path in app-private storage.
  Future<void> init([Directory? baseDir]) async {
    if (_isInitialized && baseDir == null) return;

    try {
      final Directory directory = baseDir ?? await getApplicationDocumentsDirectory();
      final storageDir = Directory('${directory.path}/security_store');
      if (!await storageDir.exists()) {
        await storageDir.create(recursive: true);
      }
      _storageFile = File('${storageDir.path}/app_secure_kv.json');
      await _loadFromDisk();
      _isInitialized = true;
    } catch (e) {
      debugPrint('SecureStorageService initialization notice: $e (using local fallback)');
      // Local fallback for headless CLI / Termux unit tests
      final fallbackDir = Directory('./.app_secure_store');
      if (!fallbackDir.existsSync()) {
        fallbackDir.createSync(recursive: true);
      }
      _storageFile = File('${fallbackDir.path}/app_secure_kv.json');
      await _loadFromDisk();
      _isInitialized = true;
    }
  }

  Future<void> _loadFromDisk() async {
    if (_storageFile == null || !await _storageFile!.exists()) {
      _cache.clear();
      return;
    }

    try {
      final content = await _storageFile!.readAsString();
      if (content.trim().isNotEmpty) {
        final Map<String, dynamic> decoded = json.decode(content);
        _cache.clear();
        decoded.forEach((k, v) => _cache[k] = v.toString());
      }
    } catch (e) {
      debugPrint('Failed to load secure store from disk, starting clean: $e');
      _cache.clear();
    }
  }

  Future<void> _flushToDisk() async {
    if (_storageFile == null) return;
    try {
      final jsonString = json.encode(_cache);
      final tempFile = File('${_storageFile!.path}.tmp');
      await tempFile.writeAsString(jsonString, flush: true);
      if (await _storageFile!.exists()) {
        await _storageFile!.delete();
      }
      await tempFile.rename(_storageFile!.path);
    } catch (e) {
      debugPrint('Error flushing secure storage to disk: $e');
    }
  }

  @override
  Future<void> write({required String key, required String value}) async {
    if (!_isInitialized) await init();
    _cache[key] = value;
    await _flushToDisk();
  }

  @override
  Future<String?> read({required String key}) async {
    if (!_isInitialized) await init();
    return _cache[key];
  }

  @override
  Future<void> delete({required String key}) async {
    if (!_isInitialized) await init();
    if (_cache.containsKey(key)) {
      _cache.remove(key);
      await _flushToDisk();
    }
  }

  @override
  Future<void> deleteAll() async {
    if (!_isInitialized) await init();
    _cache.clear();
    await _flushToDisk();
  }

  @override
  Future<bool> containsKey({required String key}) async {
    if (!_isInitialized) await init();
    return _cache.containsKey(key);
  }

  @visibleForTesting
  void clearMemoryCacheOnly() {
    _cache.clear();
    _isInitialized = false;
  }
}
