import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../errors/failures.dart';
import '../utils/result.dart';

/// محلل JSON في مسار معالجة منفصل (Background Isolate) لمنع تجميد واجهة المستخدم
class JsonIsolateParser {
  /// فك ترميز نص JSON خام إلى خريطة Map في الخلفية
  static Future<Result, Failure>> parseMap(String jsonString) async {
    try {
      final result = await compute(_decodeMap, jsonString);
      return Result.success(result);
    } catch (e) {
      return Result.failure(ParseFailure('فشل فك ترميز JSON كخريطة: $e'));
    }
  }

  /// فك ترميز نص JSON خام إلى قائمة List في الخلفية
  static Future<Result<List<dynamic>, Failure>> parseList(String jsonString) async {
    try {
      final result = await compute(_decodeList, jsonString);
      return Result.success(result);
    } catch (e) {
      return Result.failure(ParseFailure('فشل فك ترميز JSON كقائمة: $e'));
    }
  }

  static Map<String, dynamic> _decodeMap(String input) {
    return jsonDecode(input) as Map<String, dynamic>;
  }

  static List<dynamic> _decodeList(String input) {
    return jsonDecode(input) as List<dynamic>;
  }
}
