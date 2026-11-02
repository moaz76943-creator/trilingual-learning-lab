class ArchitecturalTerm {
  final String category;
  final String arabic;
  final String german;
  final String english;
  final String technicalNote;

  const ArchitecturalTerm({
    required this.category,
    required this.arabic,
    required this.german,
    required this.english,
    required this.technicalNote,
  });
}

class ArchitecturalHarmonyService {
  static List<ArchitecturalTerm> getCoreArchitecturalTerms() {
    return const [
      ArchitecturalTerm(
        category: 'التهوية الطبيعية (Natural Ventilation)',
        arabic: 'التَّهْوِيَةُ المُتَقَاطِعَةُ العَذْبَةُ',
        german: 'die sanfte Querlüftung',
        english: 'gentle cross ventilation',
        technicalNote: 'تصميم النوافذ المتقابلة لتدوير الهواء النقي دون استهلاك كهربائي.',
      ),
      ArchitecturalTerm(
        category: 'الإضاءة النهارية (Daylight Harvesting)',
        arabic: 'الإِضَاءَةُ الشَّمْسِيَّةُ غَيْرُ المُبَاشِرَةِ',
        german: 'das gesunde indirekte Tageslicht',
        english: 'healthy indirect daylight',
        technicalNote: 'توزيع النور لإنارة الغرف برفق دون إحداث وهج حراري مزعج.',
      ),
    ];
  }
}
