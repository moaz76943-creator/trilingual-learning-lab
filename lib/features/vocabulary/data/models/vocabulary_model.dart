class VocabularyModel {
  final String id;
  final String categoryId;
  final String arabic;
  final String german;
  final String english;
  final String? germanArticle;
  final String? germanPlural;
  final String? partOfSpeech;
  final String cefrLevel;
  final List<String> tags;
  final String? imageRef;

  const VocabularyModel({
    required this.id,
    required this.categoryId,
    required this.arabic,
    required this.german,
    required this.english,
    this.germanArticle,
    this.germanPlural,
    this.partOfSpeech,
    this.cefrLevel = 'A1',
    this.tags = const [],
    this.imageRef,
  });

  /// مُحلل مرن يدعم البنى القديمة والمحدثة مع الترقية التلقائية للبيانات
  factory VocabularyModel.fromJson(Map<String, dynamic> json, {String? categoryFallback}) {
    final id = json['id']?.toString() ?? json['concept_id']?.toString() ?? '';
    final categoryId = json['category_id']?.toString() ?? categoryFallback ?? 'general';
    final arabic = (json['arabic'] ?? json['ar'] ?? '').toString().trim();
    final german = (json['german'] ?? json['de'] ?? '').toString().trim();
    final english = (json['english'] ?? json['en'] ?? '').toString().trim();

    final article = json['article']?.toString() ?? json['german_article']?.toString();
    final plural = json['plural']?.toString() ?? json['german_plural']?.toString();
    final pos = json['part_of_speech']?.toString() ?? json['type']?.toString();
    final level = json['level']?.toString() ?? json['cefr_level']?.toString() ?? 'A1';

    List<String> parsedTags = [];
    if (json['tags'] is List) {
      parsedTags = (json['tags'] as List).map((e) => e.toString()).toList();
    }

    final imageRef = json['image_ref']?.toString() ?? json['image']?.toString();

    return VocabularyModel(
      id: id,
      categoryId: categoryId,
      arabic: arabic,
      german: german,
      english: english,
      germanArticle: article,
      germanPlural: plural,
      partOfSpeech: pos,
      cefrLevel: level,
      tags: parsedTags,
      imageRef: imageRef,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'arabic': arabic,
        'german': german,
        'english': english,
        if (germanArticle != null) 'article': germanArticle,
        if (germanPlural != null) 'plural': germanPlural,
        if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
        'cefr_level': cefrLevel,
        'tags': tags,
        if (imageRef != null) 'image_ref': imageRef,
      };

  VocabularyModel copyWith({
    String? id,
    String? categoryId,
    String? arabic,
    String? german,
    String? english,
    String? germanArticle,
    String? germanPlural,
    String? partOfSpeech,
    String? cefrLevel,
    List<String>? tags,
    String? imageRef,
  }) {
    return VocabularyModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      arabic: arabic ?? this.arabic,
      german: german ?? this.german,
      english: english ?? this.english,
      germanArticle: germanArticle ?? this.germanArticle,
      germanPlural: germanPlural ?? this.germanPlural,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      tags: tags ?? this.tags,
      imageRef: imageRef ?? this.imageRef,
    );
  }
}
