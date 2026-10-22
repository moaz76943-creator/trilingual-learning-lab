import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/concept.dart';

class CategoryInfo {
  final String id;
  final String titleAr;
  final String titleDe;
  final String titleEn;
  final String jsonPath;
  List<Concept> concepts;

  CategoryInfo({
    required this.id,
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
    required this.jsonPath,
    this.concepts = const [],
  });
}

class ContentRepository {
  final Map<String, List<Concept>> _categoriesData = {};
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;
  List<Concept> getConcepts(String categoryId) => _categoriesData[categoryId] ?? [];

  // قائمة الفئات المسجلة في التطبيق
  final List<CategoryInfo> registeredCategories = [
    CategoryInfo(
      id: 'family',
      titleAr: 'العائلة',
      titleDe: 'Familie',
      titleEn: 'Family',
      jsonPath: 'content/vocabulary/family_a1.json',
    ),
    CategoryInfo(
      id: 'food',
      titleAr: 'الطعام والشراب',
      titleDe: 'Essen & Trinken',
      titleEn: 'Food & Drinks',
      jsonPath: 'content/vocabulary/food_a1.json',
    ),
  ];

  // تحميل آمن لجميع الفئات النشطة
  Future<bool> loadAllActiveCategories() async {
    try {
      for (var cat in registeredCategories) {
        final jsonString = await rootBundle.loadString(cat.jsonPath);
        final Map<String, dynamic> data = jsonDecode(jsonString);
        final List raw = data['concepts'] ?? [];
        final parsed = raw.map((item) => Concept.fromJson(item)).toList();
        _categoriesData[cat.id] = parsed;
        cat.concepts = parsed;
      }
      _isLoaded = true;
      return true;
    } catch (e) {
      // إقلاع آمن: حتى لو تعثر ملف يستمر التطبيق بما توفر
      return false;
    }
  }
}
