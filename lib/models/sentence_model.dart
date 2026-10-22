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
    final ar = json['ar'] ?? {};
    final de = json['de'] ?? {};
    final en = json['en'] ?? {};
    return SentenceModel(
      id: json['id'] ?? '',
      fullAr: ar['full'] ?? '',
      fullDe: de['full'] ?? '',
      fullEn: en['full'] ?? '',
      tokensDe: List<String>.from(de['tokens'] ?? []),
      tokensEn: List<String>.from(en['tokens'] ?? []),
    );
  }
}
