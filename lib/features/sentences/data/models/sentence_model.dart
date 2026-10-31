class SentenceModel {
  final String id;
  final String arabic;
  final String german;
  final String english;
  final String level;
  final List<String> conceptRefs;
  final String? grammarNote;

  const SentenceModel({
    required this.id,
    required this.arabic,
    required this.german,
    required this.english,
    this.level = 'A1',
    this.conceptRefs = const [],
    this.grammarNote,
  });

  /// استخراج آمن للجمل يدعم بنيتي (القائمة المفردة أو القاموس مع مفتاح sentences)
  factory SentenceModel.fromJson(Map<String, dynamic> json, [int fallbackIndex = 0]) {
    final id = json['id']?.toString() ?? 'sent_$fallbackIndex';
    final arabic = (json['arabic'] ?? json['ar'] ?? '').toString().trim();
    final german = (json['german'] ?? json['de'] ?? '').toString().trim();
    final english = (json['english'] ?? json['en'] ?? '').toString().trim();
    final level = (json['level'] ?? json['cefr'] ?? 'A1').toString().trim();

    List<String> refs = [];
    if (json['concept_refs'] is List) {
      refs = (json['concept_refs'] as List).map((e) => e.toString()).toList();
    } else if (json['keywords'] is List) {
      refs = (json['keywords'] as List).map((e) => e.toString()).toList();
    }

    final note = json['grammar_note']?.toString() ?? json['note']?.toString();

    return SentenceModel(
      id: id,
      arabic: arabic,
      german: german,
      english: english,
      level: level,
      conceptRefs: refs,
      grammarNote: note,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'arabic': arabic,
        'german': german,
        'english': english,
        'level': level,
        'concept_refs': conceptRefs,
        if (grammarNote != null) 'grammar_note': grammarNote,
      };
}
