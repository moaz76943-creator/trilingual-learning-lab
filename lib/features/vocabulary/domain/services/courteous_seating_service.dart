class SeatingEtiquetteItem {
  final String etiquetteTheme;
  final String arabic;
  final String german;
  final String english;
  final String socialSignificance;

  const SeatingEtiquetteItem({
    required this.etiquetteTheme,
    required this.arabic,
    required this.german,
    required this.english,
    required this.socialSignificance,
  });
}

class CourteousSeatingService {
  static List<SeatingEtiquetteItem> getEtiquetteItems() {
    return const [
      SeatingEtiquetteItem(
        etiquetteTheme: 'إفساح المجلس للقادمين (Welcoming Space)',
        arabic: 'تَفَسَّحُوا فِي المَجَالِسِ يَفْسَحِ اللهُ لَكُمْ',
        german: 'Macht Raum im Kreis, so schafft Gott euch Weite und Wohl.',
        english: 'Make room in the gathering, and God will grant you abundance.',
        socialSignificance: 'إشعار الداخل بالترحيب والتقدير ونشر الألفة بين الجالسين.',
      ),
      SeatingEtiquetteItem(
        etiquetteTheme: 'طهارة المجلس وطيب المقام (Cleanliness of Gathering)',
        arabic: 'طَهَارَةُ المَفَارِشِ وَحُسْنُ الجُلُوسِ بِأَدَبٍ وَوَقَارٍ',
        german: 'Reinhaltung der Sitzmatten und würdevolles, achtsames Beisammensein.',
        english: 'Cleanliness of seating mats and dignified, considerate companionship.',
        socialSignificance: 'احترام المكان وأهله بالحفاظ على النظافة والسكينة.',
      ),
    ];
  }
}
