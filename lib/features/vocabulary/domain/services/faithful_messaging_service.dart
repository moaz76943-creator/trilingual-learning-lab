class MessageIntegrityTerm {
  final String virtueName;
  final String arabic;
  final String german;
  final String english;
  final String moralGuideline;

  const MessageIntegrityTerm({
    required this.virtueName,
    required this.arabic,
    required this.german,
    required this.english,
    required this.moralGuideline,
  });
}

class FaithfulMessagingService {
  static List<MessageIntegrityTerm> getTerms() {
    return const [
      MessageIntegrityTerm(
        virtueName: 'أمانة نقل الخبر دون تبديل (Faithful Relaying of Words)',
        arabic: 'أَمَانَةُ نَقْلِ الرِّسَالَةِ وَصِدْقُ الخَبَرِ دُونَ تَحْرِيفٍ',
        german: 'Getreue Überbringung der Botschaft und Ehrlichkeit der Kunde ohne Verfälschung.',
        english: 'Faithful transmission of messages and truthfulness of tidings without distortion.',
        moralGuideline: 'الناقل الصادق صمام أمان بين الأسر والمجتمعات يحفظ الألفة وينفي الفتن.',
      ),
      MessageIntegrityTerm(
        virtueName: 'نشر البشائر والكلمة الطيبة (Spreading Good Tidings)',
        arabic: 'بَثُّ البَشَائِرِ وَإِدْخَالُ السُّرُورِ عَلَى قُلُوبِ النَّاسِ',
        german: 'Verbreitung froher Botschaften und Freude schenken in den Herzen der Menschen.',
        english: 'Spreading glad tidings and bringing joyful comfort to people\'s hearts.',
        moralGuideline: 'الكلمة الطيبة صدقة، وتبشير الناس بالخير عبادة تقوي روابط المحبة.',
      ),
    ];
  }
}
