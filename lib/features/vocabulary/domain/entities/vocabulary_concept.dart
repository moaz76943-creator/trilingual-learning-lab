/// كيان المفردة اللغوية الثلاثية النقي في طبقة Domain
class VocabularyConcept {
  final String id;
  final String categoryId;
  final String arabic;
  final String german;
  final String english;
  final String? germanArticle; // der, die, das
  final String? germanPlural;
  final String? partOfSpeech; // noun, verb, adjective, phrase
  final String cefrLevel; // A1, A2, B1
  final List<String> tags;
  final String? imageRef;

  const VocabularyConcept({
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

  @override
  String toString() => 'VocabularyConcept($id: $german | $arabic | $english)';
}
