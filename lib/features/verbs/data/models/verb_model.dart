class VerbModel {
  final String id;
  final String infinitiveGerman;
  final String rootArabic;
  final String infinitiveEnglish;
  final Map<String, String> presentGerman;
  final Map<String, String> pastGerman;
  final Map<String, String> perfectGerman;
  final String level;

  const VerbModel({
    required this.id,
    required this.infinitiveGerman,
    required this.rootArabic,
    required this.infinitiveEnglish,
    required this.presentGerman,
    this.pastGerman = const {},
    this.perfectGerman = const {},
    this.level = 'A1',
  });

  factory VerbModel.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? json['verb_id']?.toString() ?? '';
    final deInf =
        (json['infinitive_de'] ?? json['german'] ?? json['infinitive'] ?? '').toString().trim();
    final arRoot = (json['root_ar'] ?? json['arabic'] ?? json['root'] ?? '').toString().trim();
    final enInf = (json['infinitive_en'] ?? json['english'] ?? '').toString().trim();
    final level = json['level']?.toString() ?? 'A1';

    Map<String, String> parseMap(dynamic mapData) {
      if (mapData is Map) {
        return mapData.map((k, v) => MapEntry(k.toString(), v.toString().trim()));
      }
      return {};
    }

    return VerbModel(
      id: id,
      infinitiveGerman: deInf,
      rootArabic: arRoot,
      infinitiveEnglish: enInf,
      presentGerman: parseMap(json['present'] ?? json['prasens'] ?? json['conjugations']),
      pastGerman: parseMap(json['past'] ?? json['prateritum']),
      perfectGerman: parseMap(json['perfect'] ?? json['perfekt']),
      level: level,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'infinitive_de': infinitiveGerman,
        'root_ar': rootArabic,
        'infinitive_en': infinitiveEnglish,
        'present': presentGerman,
        'past': pastGerman,
        'perfect': perfectGerman,
        'level': level,
      };
}
