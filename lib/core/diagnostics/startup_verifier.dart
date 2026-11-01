import '../errors/failures.dart';
import '../utils/logger.dart';
import '../utils/result.dart';

/// فاحص تماسك البيانات أثناء الإقلاع لضمان سلامة الجداول والملفات النواتية
class StartupIntegrityVerifier {
  /// التحقق من سلامة البنية التحتية قبل فتح الشاشة الرئيسية
  static Future<Result<bool, Failure>> verifyIntegrity({
    required List<String> requiredFiles,
    required bool Function(String path) fileChecker,
  }) async {
    logger.d('بدء فحص تماسك ملفات الإقلاع...', 'StartupVerifier');

    final missing = <String>[];

    for (final file in requiredFiles) {
      if (!fileChecker(file)) {
        missing.add(file);
      }
    }

    if (missing.isNotEmpty) {
      logger.w('رُصدت ملفات مفقودة أثناء الإقلاع: $missing', 'StartupVerifier');
      return Result.failure(
        ValidationFailure('ملفات أساسية مفقودة: ${missing.join(", ")}'),
      );
    }

    logger.i('اجتاز النظام فحص تماسك ملفات الإقلاع بنجاح 100%', 'StartupVerifier');
    return Result.success(true);
  }
}
