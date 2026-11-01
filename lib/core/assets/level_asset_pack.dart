/// بيانات حزم الأصول المقسمة حسب المستوى التعليمي
class LevelAssetPack {
  final String level; // A1, A2, B1
  final List<String> categoryIds;

  const LevelAssetPack({required this.level, required this.categoryIds});

  bool containsCategory(String categoryId) => categoryIds.contains(categoryId);
}
