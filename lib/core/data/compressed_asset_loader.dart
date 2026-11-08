import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import '../errors/failures.dart';
import '../utils/result.dart';

/// محمل بيانات فوري يفك ضغط GZip مباشرة في الذاكرة دون كتابة ملفات مؤقتة على القرص
class CompressedAssetLoader {
  /// فك ضغط بايتات gzip إلى نص JSON وتحليله في الذاكرة
  static Result<Map<String, dynamic>, Failure> decompressJsonMap(Uint8List compressedBytes) {
    try {
      final decompressedBytes = gzip.decode(compressedBytes);
      final jsonString = utf8.decode(decompressedBytes);
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      return Result.success(decoded);
    } catch (e) {
      return Result.failure(ParseFailure('فشل فك ضغط بيانات JSON: $e'));
    }
  }

  /// فك ضغط ملف gzip مباشرة من مسار محلي
  static Future<Result<Map<String, dynamic>, Failure>> loadFromFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return Result.failure(ValidationFailure('الملف المضغوط غير موجود: $filePath'));
      }
      final bytes = await file.readAsBytes();
      return decompressJsonMap(bytes);
    } catch (e) {
      return Result.failure(CacheFailure('تعذر قراءة الملف المضغوط: $e'));
    }
  }
}
