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
    final ar = (json['ar'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    final de = (json['de'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    final en = (json['en'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    return PrepositionModel(
      id: (json['id'] as String?) ?? '',
      imageId: (json['image_id'] as String?) ?? '',
      wordAr: (ar['word'] as String?) ?? '',
      meaningAr: (ar['meaning'] as String?) ?? '',
      exampleAr: (ar['example'] as String?) ?? '',
      wordDe: (de['word'] as String?) ?? '',
      caseRuleDe: (de['case_rule'] as String?) ?? '',
      exampleDe: (de['example'] as String?) ?? '',
      wordEn: (en['word'] as String?) ?? '',
      exampleEn: (en['example'] as String?) ?? '',
    );
  }
}
