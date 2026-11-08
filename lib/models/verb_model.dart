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
    final conj = (json['conjugations'] as Map<String, dynamic>?) ?? const <String, dynamic>{};
    return VerbModel(
      verbId: (json['verb_id'] as String?) ?? '',
      rootAr: (json['root_ar'] as String?) ?? '',
      typeDe: (json['type_de'] as String?) ?? 'regular',
      imageId: (json['image_id'] as String?) ?? '',
      infinitive: Map<String, String>.from((json['infinitive'] as Map<String, dynamic>?) ?? const <String, dynamic>{}),
      conjugationsDe: Map<String, String>.from((conj['de'] as Map<String, dynamic>?) ?? const <String, dynamic>{}),
      conjugationsEn: Map<String, String>.from((conj['en'] as Map<String, dynamic>?) ?? const <String, dynamic>{}),
      conjugationsAr: Map<String, String>.from((conj['ar'] as Map<String, dynamic>?) ?? const <String, dynamic>{}),
      examples: Map<String, String>.from((json['examples'] as Map<String, dynamic>?) ?? const <String, dynamic>{}),
    );
  }
}
