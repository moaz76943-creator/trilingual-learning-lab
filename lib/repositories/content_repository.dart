import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/concept.dart';

class ContentRepository {
  List<Concept> _concepts = [];
  bool _isLoaded = false;

  List<Concept> get concepts => _concepts;
  bool get isLoaded => _isLoaded;

  // تحميل آمن يحمي مسار الإقلاع من الانهيار
  Future<bool> loadCategory(String categoryPath) async {
    try {
      final jsonString = await rootBundle.loadString(categoryPath);
      final Map<String, dynamic> data = jsonDecode(jsonString);
      final List rawConcepts = data['concepts'] ?? [];
      _concepts = rawConcepts.map((item) => Concept.fromJson(item)).toList();
      _isLoaded = true;
      return true;
    } catch (e) {
      // حماية المسار الحرج مع تسجيل الفشل دون تجميد التطبيق
      _isLoaded = false;
      return false;
    }
  }
}
