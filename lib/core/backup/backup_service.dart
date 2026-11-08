import 'dart:convert';
import '../error/result.dart';
import '../error/failures.dart';

class BackupService {
  static String exportToJson(Map<String, dynamic> progressData) {
    final payload = {
      'version': '1.0.0',
      'timestamp': DateTime.now().toIso8601String(),
      'data': progressData,
    };
    return jsonEncode(payload);
  }

  static Result<Map<String, dynamic>, Failure> importFromJson(String rawJson) {
    try {
      final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
      if (!decoded.containsKey('data')) {
        return Result.failure(const StorageFailure('Invalid backup structure'));
      }
      return Result.success(decoded['data'] as Map<String, dynamic>);
    } catch (e) {
      return Result.failure(StorageFailure('Failed to parse backup: $e'));
    }
  }
}
