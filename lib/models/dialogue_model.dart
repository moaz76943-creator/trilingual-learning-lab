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
      speaker: (json['speaker'] as String?) ?? 'A',
      name: (json['name'] as String?) ?? '',
      textDe: (json['de'] as String?) ?? '',
      textEn: (json['en'] as String?) ?? '',
      textAr: (json['ar'] as String?) ?? '',
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
    final title = (json['title'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    final sit = (json['situation'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    final rawLines = (json['lines'] as List<dynamic>?) ?? const <dynamic>[];
    return DialogueModel(
      id: (json['id'] as String?) ?? '',
      imageId: (json['image_id'] as String?) ?? '',
      titleAr: (title['ar'] as String?) ?? '',
      titleDe: (title['de'] as String?) ?? '',
      titleEn: (title['en'] as String?) ?? '',
      situationAr: (sit['ar'] as String?) ?? '',
      situationDe: (sit['de'] as String?) ?? '',
      situationEn: (sit['en'] as String?) ?? '',
      lines: rawLines.map((l) => DialogueLine.fromJson(l as Map<String, dynamic>)).toList(),
    );
  }
}
