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
      word: (json['word'] as String?) ?? '',
      vocalized: (json['vocalized'] as String?) ?? '',
      gender: (json['gender'] as String?) ?? 'm',
      plural: (json['plural'] as String?) ?? '',
      example: (json['example'] as String?) ?? '',
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
      article: (json['article'] as String?) ?? '',
      word: (json['word'] as String?) ?? '',
      plural: (json['plural'] as String?) ?? '',
      example: (json['example'] as String?) ?? '',
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
      word: (json['word'] as String?) ?? '',
      plural: (json['plural'] as String?) ?? '',
      example: (json['example'] as String?) ?? '',
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
      conceptId: (json['concept_id'] as String?) ?? '',
      imageId: (json['image_id'] as String?) ?? '',
      semanticDistinction: json['semantic_distinction'] as String?,
      ar: ArabicLexeme.fromJson((json['ar'] as Map<String, dynamic>?) ?? const <String, dynamic>{}),
      de: GermanLexeme.fromJson((json['de'] as Map<String, dynamic>?) ?? const <String, dynamic>{}),
      en: EnglishLexeme.fromJson((json['en'] as Map<String, dynamic>?) ?? const <String, dynamic>{}),
    );
  }
}
