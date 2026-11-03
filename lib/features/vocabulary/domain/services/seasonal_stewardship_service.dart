class SeasonalTerm {
  final String seasonPhase;
  final String arabic;
  final String german;
  final String english;
  final String agriculturalPractice;

  const SeasonalTerm({
    required this.seasonPhase,
    required this.arabic,
    required this.german,
    required this.english,
    required this.agriculturalPractice,
  });
}

class SeasonalStewardshipService {
  static List<SeasonalTerm> getSeasonalTerms() {
    return const [
      SeasonalTerm(
        seasonPhase: 'الإزهار الربيعي الباكر (Early Spring Bloom)',
        arabic: 'الإِزْهَارُ البَاكِرُ لِأَشْجَارِ اللَّوْزِ',
        german: 'die frühe Frühlingsblüte der Mandelbäume',
        english: 'the early spring blossom of almond trees',
        agriculturalPractice: 'تهيئة مسارات تصريف المياه برفق حول جذوع الأشجار.',
      ),
      SeasonalTerm(
        seasonPhase: 'حماية الشتلات من الصقيع (Frost Protection)',
        arabic: 'تَغْطِيَةُ الغِرَاسِ الصَّغِيرَةِ مِنَ الجَلِيدِ',
        german: 'das behutsame Schützen junger Setzlinge vor Spätfrost',
        english: 'careful protection of young seedlings from frost',
        agriculturalPractice: 'استخدام القش الطبيعي لتغطية الجذور وحفظ رطوبة ودفء التربة.',
      ),
    ];
  }
}
