import 'dart:convert';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../../../core/utils/result.dart';

/// خدمة تصدير واستيراد النسخ الاحتياطي لتقدم المتعلم محلياً
class BackupService {
  final SecureStorageService _storage;

  BackupService(this._storage);

  /// تصدير كامل بيانات المتعلم في حزمة JSON منظمة
  Future<Result<String, Failure>> exportBackupJson({
    required Map<String, dynamic> progressData,
    required int streakDays,
  }) async {
    try {
      final backupPayload = {
        'version': 1,
        'app': 'trilingual-learning-lab',
        'exported_at': DateTime.now().toIso8601String(),
        'streak_days': streakDays,
        'progress': progressData,
      };

      final jsonString = jsonEncode(backupPayload);
      return Result.success(jsonString);
    } catch (e) {
      return Result.failure(CacheFailure('فشل تصدير النسخة الاحتياطية: $e'));
    }
  }

  /// استيراد والتحقق من صحة ملف النسخة الاحتياطية
  Future<Result, Failure>> importBackupJson(String jsonString) async {
    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is! Map<String, dynamic>) {
        return Result.failure(const ParseFailure('تنسيق النسخة الاحتياطية غير صالح'));
      }

      if (decoded['app'] != 'trilingual-learning-lab') {
        return Result.failure(const ValidationFailure('ملف النسخة الاحتياطية غير متطابق مع التطبيق'));
      }

      return Result.success(decoded);
    } catch (e) {
      return Result.failure(ParseFailure('خطأ أثناء فك تشفير النسخة الاحتياطية: $e'));
    }
  }
}
