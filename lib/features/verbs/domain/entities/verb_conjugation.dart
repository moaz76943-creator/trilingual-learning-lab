/// كيان تصريف الأفعال الثلاثي النقي في طبقة Domain
class VerbConjugation {
  final String id;
  final String infinitiveGerman;
  final String rootArabic;
  final String infinitiveEnglish;
  final Map<String, String> presentGerman; // ich, du, er/sie/es, wir, ihr, sie
  final Map<String, String> pastGerman;
  final Map<String, String> perfectGerman;
  final String level;

  const VerbConjugation({
    required this.id,
    required this.infinitiveGerman,
    required this.rootArabic,
    required this.infinitiveEnglish,
    required this.presentGerman,
    this.pastGerman = const {},
    this.perfectGerman = const {},
    this.level = 'A1',
  });

  @override
  String toString() => 'VerbConjugation($infinitiveGerman | $rootArabic)';
}
