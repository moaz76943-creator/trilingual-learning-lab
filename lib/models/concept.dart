class ArabicLexeme {
  final String word;
  final String vocalized;
  final String gender;
  final String plural;
  final String example;

  ArabicLexeme({
    required this.word,
    required this.vocalized,
    required this.gender,
    required this.plural,
    required this.example,
  });

  factory ArabicLexeme.fromJson(Map<String, dynamic> json) {
    return ArabicLexeme(
      word: json['word'] ?? '',
      vocalized: json['vocalized'] ?? '',
      gender: json['gender'] ?? 'm',
      plural: json['plural'] ?? '',
      example: json['example'] ?? '',
    );
  }
}

class GermanLexeme {
  final String article;
  final String word;
  final String plural;
  final String example;

  GermanLexeme({
    required this.article,
    required this.word,
    required this.plural,
    required this.example,
  });

  factory GermanLexeme.fromJson(Map<String, dynamic> json) {
    return GermanLexeme(
      article: json['article'] ?? '',
      word: json['word'] ?? '',
      plural: json['plural'] ?? '',
      example: json['example'] ?? '',
    );
  }
}

class EnglishLexeme {
  final String word;
  final String plural;
  final String example;

  EnglishLexeme({
    required this.word,
    required this.plural,
    required this.example,
  });

  factory EnglishLexeme.fromJson(Map<String, dynamic> json) {
    return EnglishLexeme(
      word: json['word'] ?? '',
      plural: json['plural'] ?? '',
      example: json['example'] ?? '',
    );
  }
}

class Concept {
  final String conceptId;
  final String imageId;
  final String? semanticDistinction;
  final ArabicLexeme ar;
  final GermanLexeme de;
  final EnglishLexeme en;

  Concept({
    required this.conceptId,
    required this.imageId,
    this.semanticDistinction,
    required this.ar,
    required this.de,
    required this.en,
  });

  factory Concept.fromJson(Map<String, dynamic> json) {
    return Concept(
      conceptId: json['concept_id'] ?? '',
      imageId: json['image_id'] ?? '',
      semanticDistinction: json['semantic_distinction'],
      ar: ArabicLexeme.fromJson(json['ar'] ?? {}),
      de: GermanLexeme.fromJson(json['de'] ?? {}),
      en: EnglishLexeme.fromJson(json['en'] ?? {}),
    );
  }
}
