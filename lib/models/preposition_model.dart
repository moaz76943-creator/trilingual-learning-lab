class PrepositionModel {
  final String id;
  final String imageId;
  final String wordAr;
  final String meaningAr;
  final String exampleAr;
  final String wordDe;
  final String caseRuleDe;
  final String exampleDe;
  final String wordEn;
  final String exampleEn;

  PrepositionModel({
    required this.id,
    required this.imageId,
    required this.wordAr,
    required this.meaningAr,
    required this.exampleAr,
    required this.wordDe,
    required this.caseRuleDe,
    required this.exampleDe,
    required this.wordEn,
    required this.exampleEn,
  });

  factory PrepositionModel.fromJson(Map<String, dynamic> json) {
    final ar = json['ar'] ?? {};
    final de = json['de'] ?? {};
    final en = json['en'] ?? {};
    return PrepositionModel(
      id: json['id'] ?? '',
      imageId: json['image_id'] ?? '',
      wordAr: ar['word'] ?? '',
      meaningAr: ar['meaning'] ?? '',
      exampleAr: ar['example'] ?? '',
      wordDe: de['word'] ?? '',
      caseRuleDe: de['case_rule'] ?? '',
      exampleDe: de['example'] ?? '',
      wordEn: en['word'] ?? '',
      exampleEn: en['example'] ?? '',
    );
  }
}
