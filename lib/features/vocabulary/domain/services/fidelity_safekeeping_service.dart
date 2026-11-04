class SafekeepingValueTerm {
  final String virtueName;
  final String arabic;
  final String german;
  final String english;
  final String ethicalPillar;

  const SafekeepingValueTerm({
    required this.virtueName,
    required this.arabic,
    required this.german,
    required this.english,
    required this.ethicalPillar,
  });
}

class FidelitySafekeepingService {
  static List<SafekeepingValueTerm> getTerms() {
    return const [
      SafekeepingValueTerm(
        virtueName: 'أداء الأمانة إلى أهلها (Fulfilling Trusts Faithfully)',
        arabic: 'أَدِّ الأَمَانَةَ إِلَى مَنِ ائْتَمَنَكَ وَلَا تَخُنْ مَنْ خَانَكَ',
        german: 'Gib das Anvertraute dem zurück, der dir vertraute, und brich niemals die Treue.',
        english: 'Return the trust to the one who entrusted you, and never betray confidence.',
        ethicalPillar: 'الأمانة خلق مطلق لا يقبل التبديل أو المعاملة بالمثل في الإساءة.',
      ),
      SafekeepingValueTerm(
        virtueName: 'حفظ الودائع دون تفريط (Vigilant Safekeeping)',
        arabic: 'الحِفْظُ الصَّادِقُ لِلْوَدِيعَةِ بِعَيْنِ الرِّعَايَةِ وَالمَسْؤُولِيَّةِ',
        german: 'Gewissenhaftes Verwahren des anvertrauten Gutes mit wachsamer Sorgfalt.',
        english: 'Faithful custody of deposits with vigilant care and full responsibility.',
        ethicalPillar: 'صيانة متاع الآخرين كما يصون الإنسان أثمن مقتنياته الخاصة.',
      ),
    ];
  }
}
