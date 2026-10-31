/// كيان الجملة السياقية الثلاثية النقي في طبقة Domain
class SentenceItem {
  final String id;
  final String arabic;
  final String german;
  final String english;
  final String level; // A1, A2, B1
  final List<String> conceptRefs;
  final String? grammarNote;

  const SentenceItem({
    required this.id,
    required this.arabic,
    required this.german,
    required this.english,
    this.level = 'A1',
    this.conceptRefs = const [],
    this.grammarNote,
  });

  @override
  String toString() => 'SentenceItem($id: $german)';
}
