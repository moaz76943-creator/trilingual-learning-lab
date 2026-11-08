class SentenceModel {
  final String id;
  final String fullAr;
  final String fullDe;
  final String fullEn;
  final List<String> tokensDe;
  final List<String> tokensEn;

  SentenceModel({
    required this.id,
    required this.fullAr,
    required this.fullDe,
    required this.fullEn,
    required this.tokensDe,
    required this.tokensEn,
  });

  factory SentenceModel.fromJson(Map<String, dynamic> json) {
    final ar = (json['ar'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    final de = (json['de'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    final en = (json['en'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    return SentenceModel(
      id: (json['id'] as String?) ?? '',
      fullAr: (ar['full'] as String?) ?? '',
      fullDe: (de['full'] as String?) ?? '',
      fullEn: (en['full'] as String?) ?? '',
      tokensDe: List<String>.from((de['tokens'] as List<dynamic>?) ?? const <dynamic>[]),
      tokensEn: List<String>.from((en['tokens'] as List<dynamic>?) ?? const <dynamic>[]),
    );
  }
}
