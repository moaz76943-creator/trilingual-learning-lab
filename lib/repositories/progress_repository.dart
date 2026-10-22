import 'dart:convert';
import 'dart:io';

class ProgressRepository {
  final Set<String> _favoriteIds = {};
  final Set<String> _learnedIds = {};
  bool _isInitialized = false;

  Set<String> get favoriteIds => _favoriteIds;
  Set<String> get learnedIds => _learnedIds;
  bool get isInitialized => _isInitialized;

  bool isFavorite(String conceptId) => _favoriteIds.contains(conceptId);
  bool isLearned(String conceptId) => _learnedIds.contains(conceptId);

  // تهيئة وقراءة البيانات من الملف المحلي الآمن
  Future<void> init(String storageDirectoryPath) async {
    final file = File('$storageDirectoryPath/user_progress.json');
    if (await file.exists()) {
      try {
        final content = await file.readAsString();
        final Map<String, dynamic> data = jsonDecode(content);
        
        _favoriteIds.clear();
        _learnedIds.clear();

        final List favs = data['favorites'] ?? [];
        final List learned = data['learned'] ?? [];

        _favoriteIds.addAll(favs.map((e) => e.toString()));
        _learnedIds.addAll(learned.map((e) => e.toString()));
      } catch (e) {
        // حماية البيانات: عمل نسخة احتياطية من الملف التالف بدلاً من مسحه
        try {
          await file.copy('$storageDirectoryPath/user_progress.corrupted.bak');
        } catch (_) {}
      }
    }
    _isInitialized = true;
  }

  // تبديل حالة المفضلة وحفظها ذرياً
  Future<bool> toggleFavorite(String conceptId, String storageDirectoryPath) async {
    if (_favoriteIds.contains(conceptId)) {
      _favoriteIds.remove(conceptId);
    } else {
      _favoriteIds.add(conceptId);
    }
    return await _saveSafely(storageDirectoryPath);
  }

  // تبديل حالة الإتقان وحفظها ذرياً
  Future<bool> toggleLearned(String conceptId, String storageDirectoryPath) async {
    if (_learnedIds.contains(conceptId)) {
      _learnedIds.remove(conceptId);
    } else {
      _learnedIds.add(conceptId);
    }
    return await _saveSafely(storageDirectoryPath);
  }

  // تقنية الكتابة الذرية (Atomic Write) لمنع تلف الملف
  Future<bool> _saveSafely(String storageDirectoryPath) async {
    try {
      final targetFile = File('$storageDirectoryPath/user_progress.json');
      final tempFile = File('$storageDirectoryPath/user_progress.tmp');

      final payload = {
        'version': 1,
        'updated_at': DateTime.now().toIso8601String(),
        'favorites': _favoriteIds.toList(),
        'learned': _learnedIds.toList(),
      };

      final jsonString = jsonEncode(payload);

      // 1. الكتابة في ملف مؤقت أولاً
      await tempFile.writeAsString(jsonString, flush: true);

      // 2. استبدال الملف الأصلي بالملف المؤقت بعملية ذرية (Atomic Rename)
      if (await targetFile.exists()) {
        await targetFile.delete();
      }
      await tempFile.rename(targetFile.path);
      return true;
    } catch (e) {
      return false;
    }
  }
}
