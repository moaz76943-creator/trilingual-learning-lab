class VerbModel {
  final String verbId;
  final String rootAr;
  final String typeDe;
  final String imageId;
  final Map<String, String> infinitive;
  final Map<String, String> conjugationsDe;
  final Map<String, String> conjugationsEn;
  final Map<String, String> conjugationsAr;
  final Map<String, String> examples;

  VerbModel({
    required this.verbId,
    required this.rootAr,
    required this.typeDe,
    required this.imageId,
    required this.infinitive,
    required this.conjugationsDe,
    required this.conjugationsEn,
    required this.conjugationsAr,
    required this.examples,
  });

  factory VerbModel.fromJson(Map<String, dynamic> json) {
    final conj = json['conjugations'] ?? {};
    return VerbModel(
      verbId: json['verb_id'] ?? '',
      rootAr: json['root_ar'] ?? '',
      typeDe: json['type_de'] ?? 'regular',
      imageId: json['image_id'] ?? '',
      infinitive: Map<String, String>.from(json['infinitive'] ?? {}),
      conjugationsDe: Map<String, String>.from(conj['de'] ?? {}),
      conjugationsEn: Map<String, String>.from(conj['en'] ?? {}),
      conjugationsAr: Map<String, String>.from(conj['ar'] ?? {}),
      examples: Map<String, String>.from(json['examples'] ?? {}),
    );
  }
}
