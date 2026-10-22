class DialogueLine {
  final String speaker;
  final String name;
  final String textDe;
  final String textEn;
  final String textAr;

  DialogueLine({
    required this.speaker,
    required this.name,
    required this.textDe,
    required this.textEn,
    required this.textAr,
  });

  factory DialogueLine.fromJson(Map<String, dynamic> json) {
    return DialogueLine(
      speaker: json['speaker'] ?? 'A',
      name: json['name'] ?? '',
      textDe: json['de'] ?? '',
      textEn: json['en'] ?? '',
      textAr: json['ar'] ?? '',
    );
  }
}

class DialogueModel {
  final String id;
  final String imageId;
  final String titleAr;
  final String titleDe;
  final String titleEn;
  final String situationAr;
  final String situationDe;
  final String situationEn;
  final List<DialogueLine> lines;

  DialogueModel({
    required this.id,
    required this.imageId,
    required this.titleAr,
    required this.titleDe,
    required this.titleEn,
    required this.situationAr,
    required this.situationDe,
    required this.situationEn,
    required this.lines,
  });

  factory DialogueModel.fromJson(Map<String, dynamic> json) {
    final title = json['title'] ?? {};
    final sit = json['situation'] ?? {};
    final rawLines = json['lines'] as List? ?? [];
    return DialogueModel(
      id: json['id'] ?? '',
      imageId: json['image_id'] ?? '',
      titleAr: title['ar'] ?? '',
      titleDe: title['de'] ?? '',
      titleEn: title['en'] ?? '',
      situationAr: sit['ar'] ?? '',
      situationDe: sit['de'] ?? '',
      situationEn: sit['en'] ?? '',
      lines: rawLines.map((l) => DialogueLine.fromJson(l)).toList(),
    );
  }
}
