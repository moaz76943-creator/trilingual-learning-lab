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
  bool _isFullyLoaded = false;

  bool get isFullyLoaded => _isFullyLoaded;
  List<Concept> getConcepts(String categoryId) => _categoriesData[categoryId] ?? [];

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
    CategoryInfo(
      id: 'home',
      titleAr: 'المنزل والأثاث',
      titleDe: 'Zuhause & Möbel',
      titleEn: 'Home & Furniture',
      jsonPath: 'content/vocabulary/home_a1.json',
    ),
    CategoryInfo(
      id: 'clothes',
      titleAr: 'الملابس والمظهر',
      titleDe: 'Kleidung & Aussehen',
      titleEn: 'Clothes & Appearance',
      jsonPath: 'content/vocabulary/clothes_a1.json',
    ),
    CategoryInfo(
      id: 'colors_numbers',
      titleAr: 'الألوان والأرقام',
      titleDe: 'Farben & Zahlen',
      titleEn: 'Colors & Numbers',
      jsonPath: 'content/vocabulary/colors_numbers_a1.json',
    ),
    CategoryInfo(
      id: 'time_calendar',
      titleAr: 'الوقت والتقويم',
      titleDe: 'Zeit & Kalender',
      titleEn: 'Time & Calendar',
      jsonPath: 'content/vocabulary/time_calendar_a1.json',
    ),
  ];

  /// Lazy load a single category. Caches the result.
  Future<List<Concept>> loadCategory(String categoryId) async {
    if (_categoriesData.containsKey(categoryId)) {
      return _categoriesData[categoryId]!;
    }

    final cat = registeredCategories.firstWhere(
      (c) => c.id == categoryId,
      orElse: () => throw Exception('Unknown category: $categoryId'),
    );

    try {
      final jsonString = await rootBundle.loadString(cat.jsonPath);
      final Map<String, dynamic> data = jsonDecode(jsonString);
      final List raw = data['concepts'] ?? [];
      final parsed = raw.map((item) => Concept.fromJson(item)).toList();
      _categoriesData[categoryId] = parsed;
      cat.concepts = parsed;
      return parsed;
    } catch (e) {
      // Return empty on failure (e.g. missing asset) without crashing
      _categoriesData[categoryId] = [];
      cat.concepts = [];
      return [];
    }
  }

  /// Load all categories (used for search). Idempotent.
  Future<bool> loadAllActiveCategories() async {
    if (_isFullyLoaded) return true;
    try {
      for (var cat in registeredCategories) {
        await loadCategory(cat.id);
      }
      _isFullyLoaded = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Convenience for search: ensures all are loaded then returns flattened list.
  Future<List<Concept>> loadAllConcepts() async {
    await loadAllActiveCategories();
    return [
      for (final cat in registeredCategories) ...getConcepts(cat.id),
    ];
  }
}
