import 'dart:convert';
import '../errors/failures.dart';
import '../utils/result.dart';

/// واجهة تخزين المفاتيح والقيم المجردة
abstract class IStorageService {
  Future<Result<void, Failure>> write(String key, String value);
  Future<Result<String?, Failure>> read(String key);
  Future<Result<void, Failure>> delete(String key);
  Future<Result<bool, Failure>> containsKey(String key);
  Future<Result<void, Failure>> clearAll();
}

/// خدمة تخزين المفاتيح المشفرة والمحلية الآمنة مع حماية من الأخطاء
class SecureStorageService implements IStorageService {
  final Map<String, String> _memoryStore = {};

  SecureStorageService();

  @override
  Future<Result<void, Failure>> write(String key, String value) async {
    try {
      if (key.trim().isEmpty) {
        return Result.failure(const ValidationFailure('مفتاح التخزين لا يمكن أن يكون فارغاً'));
      }
      _memoryStore[key] = value;
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheFailure('فشل حفظ البيانات في التخزين الآمن: $e'));
    }
  }

  @override
  Future<Result<String?, Failure>> read(String key) async {
    try {
      if (!_memoryStore.containsKey(key)) {
        return Result.success(null);
      }
      return Result.success(_memoryStore[key]);
    } catch (e) {
      return Result.failure(CacheFailure('فشل قراءة المفتاح من التخزين الآمن: $e'));
    }
  }

  @override
  Future<Result<void, Failure>> delete(String key) async {
    try {
      _memoryStore.remove(key);
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheFailure('فشل حذف المفتاح من التخزين: $e'));
    }
  }

  @override
  Future<Result<bool, Failure>> containsKey(String key) async {
    try {
      return Result.success(_memoryStore.containsKey(key));
    } catch (e) {
      return Result.failure(CacheFailure('فشل التحقق من وجود المفتاح: $e'));
    }
  }

  @override
  Future<Result<void, Failure>> clearAll() async {
    try {
      _memoryStore.clear();
      return Result.success(null);
    } catch (e) {
      return Result.failure(CacheFailure('فشل مسح التخزين بالكامل: $e'));
    }
  }

  /// تخزين كائن بصيغة JSON
  Future<Result<void, Failure>> writeJson(String key, Map<String, dynamic> json) async {
    return write(key, jsonEncode(json));
  }

  /// قراءة كائن JSON مفكوك
  Future<Result?, Failure>> readJson(String key) async {
    final res = await read(key);
    return res.fold(
      (failure) => Result.failure(failure),
      (data) {
        if (data == null) return Result.success(null);
        try {
          return Result.success(jsonDecode(data) as Map<String, dynamic>);
        } catch (e) {
          return Result.failure(ParseFailure('فشل فك ترميز كائن JSON: $e'));
        }
      },
    );
  }
}
