class LivelihoodValueItem {
  final String theme;
  final String arabic;
  final String german;
  final String english;
  final String spiritualSignificance;

  const LivelihoodValueItem({
    required this.theme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.spiritualSignificance,
  });
}

class WholesomeLivelihoodService {
  static List<LivelihoodValueItem> getCoreValues() {
    return const [
      LivelihoodValueItem(
        theme: 'الرزق الحلال وبركته (Blessed Lawful Sustenance)',
        arabic: 'طِيبُ المَطْعَمِ وَتَحَرِّي الكَسْبِ الحَلَالِ',
        german: 'Reine und gesunde Speise aus redlichem, gesegnetem Erwerb.',
        english: 'Wholesome sustenance derived from honest, lawful earning.',
        spiritualSignificance: 'تحري الحلال يملأ القلب نوراً ويستجاب به الدعاء وتستقر به السكينة.',
      ),
      LivelihoodValueItem(
        theme: 'القصد والاعتدال دون سرف (Moderation without Extravagance)',
        arabic: 'القَصْدُ فِي المَعِيشَةِ نِصْفُ الكِفَايَةِ',
        german: 'Gerechtes Maß und Bescheidenheit im Alltag schenken Wohlstand.',
        english: 'Moderation in living is half of sufficiency and content.',
        spiritualSignificance: 'شكر النعمة بحفظها وحسن استهلاكها وصيانتها عن التبذير.',
      ),
    ];
  }
}
