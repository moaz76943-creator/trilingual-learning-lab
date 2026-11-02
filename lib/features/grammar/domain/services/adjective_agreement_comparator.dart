class AdjectiveAgreementNote {
  final String language;
  final String ruleSummary;
  final String masculineExample;
  final String feminineExample;

  const AdjectiveAgreementNote({
    required this.language,
    required this.ruleSummary,
    required this.masculineExample,
    required this.feminineExample,
  });
}

class AdjectiveAgreementComparator {
  static List<AdjectiveAgreementNote> getAgreementRules() {
    return const [
      AdjectiveAgreementNote(
        language: 'ar',
        ruleSummary: 'النعت يتبع المنعوت في أربعة أمور: الإعراب، والتعريف أو التنكير، والتذكير أو التأنيث، والعدد.',
        masculineExample: 'الكِتَابُ النَّافِعُ (مرفوع معرف مذكر مفرد)',
        feminineExample: 'الصَّحِيفَةُ النَّافِعَةُ (مرفوع معرف مؤنث مفرد)',
      ),
      AdjectiveAgreementNote(
        language: 'de',
        ruleSummary: 'Adjektivdeklination: Die Endung des Adjektivs ändert sich nach Artikel (der/die/das) und Kasus.',
        masculineExample: 'das nützliche Buch (Neutrum Nominativ: -e)',
        feminineExample: 'die nützliche Zeitung (Feminin Nominativ: -e)',
      ),
      AdjectiveAgreementNote(
        language: 'en',
        ruleSummary: 'Invariable Adjectives: Adjectives in English never change their form regardless of gender or number.',
        masculineExample: 'the useful book',
        feminineExample: 'the useful newspaper',
      ),
    ];
  }
}
